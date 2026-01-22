import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:convert';

import '../data/services/local_log_service.dart';

/// Background task name for daily quote updates
const String dailyQuoteTaskName = 'dailyQuoteUpdate';

/// Top-level callback dispatcher for WorkManager
/// This MUST be a top-level function (not a class method)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    final logger = LocalLogService(prefs);

    try {
      await logger.info('Task started: $taskName', 'WorkManager');

      if (taskName == dailyQuoteTaskName) {
        await updateDailyQuoteNotification(logger);
        await logger.info('Daily quote updated successfully', 'WorkManager');
        return Future.value(true);
      }

      return Future.value(false);
    } catch (e, stackTrace) {
      await logger.error(
        'Task failed: $e',
        'WorkManager',
        stackTrace: stackTrace.toString(),
      );
      // Return true to prevent WorkManager from retrying endlessly
      return Future.value(true);
    }
  });
}

/// Updates the daily quote notification content
Future<void> updateDailyQuoteNotification(LocalLogService logger) async {
  try {
    // Initialize timezone
    await logger.debug('Initializing timezone', 'DailyQuoteWorker');
    tz.initializeTimeZones();
    final offset = DateTime.now().timeZoneOffset;
    final offsetMinutes = offset.inMinutes;

    // Set local timezone
    String locationName;
    if (offsetMinutes == 330) {
      locationName = 'Asia/Kolkata';
    } else if (offsetMinutes == 0) {
      locationName = 'UTC';
    } else if (offsetMinutes == -300) {
      locationName = 'America/New_York';
    } else if (offsetMinutes == -480) {
      locationName = 'America/Los_Angeles';
    } else if (offsetMinutes == 60) {
      locationName = 'Europe/London';
    } else if (offsetMinutes == 480) {
      locationName = 'Asia/Shanghai';
    } else if (offsetMinutes == 540) {
      locationName = 'Asia/Tokyo';
    } else {
      locationName = 'UTC';
    }
    tz.setLocalLocation(tz.getLocation(locationName));

    // Load environment variables
    await dotenv.load(fileName: '.env');

    // Get Supabase credentials from environment
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
    const int dailyQuoteNotificationId = 0;

    if (supabaseUrl == null || supabaseAnonKey == null) {
      await logger.error('Missing Supabase credentials', 'DailyQuoteWorker');
      return;
    }

    await logger.debug('Supabase credentials loaded successfully', 'DailyQuoteWorker');

    // Initialize Supabase client
    final client = supabase.SupabaseClient(supabaseUrl, supabaseAnonKey);

    // Fetch today's daily quote
    // Get today's date in IST timezone
    // IST is UTC+5:30
    final currentTimeUtc = DateTime.now().toUtc();
    final istNow = currentTimeUtc.add(const Duration(hours: 5, minutes: 30));
    final istToday = DateTime(istNow.year, istNow.month, istNow.day);

    // Calculate the range for today in IST
    final istStartOfDay = istToday;
    final istEndOfDay = istStartOfDay.add(const Duration(days: 1));

    // Convert back to UTC for query
    final utcStartOfDay = istStartOfDay.subtract(
      const Duration(hours: 5, minutes: 30),
    );
    final utcEndOfDay = istEndOfDay.subtract(
      const Duration(hours: 5, minutes: 30),
    );

    await logger.debug(
      'Querying quote for date range: ${utcStartOfDay.toIso8601String()} to ${utcEndOfDay.toIso8601String()}',
      'DailyQuoteWorker',
    );

    final response = await client
        .from('quotes')
        .select('*, authors(*), categories(*)')
        .eq('is_quote_of_the_day', true)
        .gte('quote_of_the_day_date', utcStartOfDay.toIso8601String())
        .lt('quote_of_the_day_date', utcEndOfDay.toIso8601String())
        .maybeSingle();

    if (response == null) {
      await logger.warning('No daily quote found for today', 'DailyQuoteWorker');
      return;
    }

    // Extract quote data
    final author = response['authors'] as Map<String, dynamic>?;
    final quoteText = response['text']?.toString() ?? '';
    final authorName = author?['name']?.toString() ?? 'Unknown';

    await logger.info(
      'Fetched quote: "$quoteText" - $authorName',
      'DailyQuoteWorker',
    );

    // Load user settings to get notification time
    final prefs = await SharedPreferences.getInstance();

    // Default values
    var notificationsEnabled = false;
    var notificationHour = 8;
    var notificationMinute = 0;

    // Read settings from JSON
    final settingsJson = prefs.getString('user_settings');
    if (settingsJson != null) {
      try {
        final decoded = jsonDecode(settingsJson) as Map<String, dynamic>;
        notificationsEnabled =
            decoded['notificationsEnabled'] as bool? ?? false;
        notificationHour = decoded['notificationHour'] as int? ?? 8;
        notificationMinute = decoded['notificationMinute'] as int? ?? 0;
      } catch (e) {
        await logger.error('Error parsing settings JSON: $e', 'DailyQuoteWorker');
      }
    } else {
      // Fallback for individual keys if JSON is missing (legacy support)
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      notificationHour = prefs.getInt('notificationHour') ?? 8;
      notificationMinute = prefs.getInt('notificationMinute') ?? 0;
    }

    await logger.debug(
      'Settings loaded: enabled=$notificationsEnabled, time=$notificationHour:${notificationMinute.toString().padLeft(2, '0')}',
      'DailyQuoteWorker',
    );

    if (!notificationsEnabled) {
      await logger.info('Notifications are disabled', 'DailyQuoteWorker');
      return;
    }

    // Initialize notification plugin
    final notifications = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher_monochrome',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await notifications.initialize(initSettings);

    // Create notification channel
    const androidChannel = AndroidNotificationChannel(
      'daily_quote_channel',
      'Quote of the Day',
      description: 'Daily inspirational quote notification',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    // Calculate next notification time
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      notificationHour,
      notificationMinute,
    );

    // If scheduled time has passed for today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // Cancel existing notification and reschedule with new content
    await notifications.cancel(0);

    await notifications.zonedSchedule(
      dailyQuoteNotificationId, // Daily quote notification ID
      'Quote of the Day ☀️',
      '$quoteText \n - $authorName',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quote_channel',
          'Quote of the Day',
          channelDescription: 'Daily inspirational quote notification',
          importance: Importance.high,
          styleInformation: BigTextStyleInformation(
            '$quoteText \n - $authorName',
            contentTitle: 'Quote of the Day ☀️',
          ),
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    await logger.info(
      'Notification scheduled for ${scheduledDate.toIso8601String()} with quote: "$quoteText"',
      'DailyQuoteWorker',
    );
  } catch (e, stackTrace) {
    await logger.error(
      'Error updating notification: $e',
      'DailyQuoteWorker',
      stackTrace: stackTrace.toString(),
    );
  }
}
