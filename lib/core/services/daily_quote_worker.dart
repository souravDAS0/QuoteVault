import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:convert';

/// Background task name for daily quote updates
const String dailyQuoteTaskName = 'dailyQuoteUpdate';

/// Top-level callback dispatcher for WorkManager
/// This MUST be a top-level function (not a class method)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      print('[WorkManager] Task started: $taskName');

      if (taskName == dailyQuoteTaskName) {
        await updateDailyQuoteNotification();
        print('[WorkManager] Daily quote updated successfully');
        return Future.value(true);
      }

      return Future.value(false);
    } catch (e) {
      print('[WorkManager] Task failed: $e');
      // Return true to prevent WorkManager from retrying endlessly
      return Future.value(true);
    }
  });
}

/// Updates the daily quote notification content
Future<void> updateDailyQuoteNotification() async {
  try {
    // Initialize timezone
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

    if (supabaseUrl == null || supabaseAnonKey == null) {
      print('[WorkManager] Missing Supabase credentials');
      return;
    }

    // Initialize Supabase client
    final client = supabase.SupabaseClient(supabaseUrl, supabaseAnonKey);

    // Fetch today's daily quote
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await client
        .from('quotes')
        .select('*, authors(*), categories(*)')
        .eq('is_quote_of_the_day', true)
        .eq('quote_of_the_day_date', today)
        .maybeSingle();

    if (response == null) {
      print('[WorkManager] No daily quote found for today');
      return;
    }

    // Extract quote data
    final author = response['authors'] as Map<String, dynamic>?;
    final quoteText = response['text']?.toString() ?? '';
    final authorName = author?['name']?.toString() ?? 'Unknown';

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
        print('[WorkManager] Error parsing settings JSON: $e');
      }
    } else {
      // Fallback for individual keys if JSON is missing (legacy support)
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      notificationHour = prefs.getInt('notificationHour') ?? 8;
      notificationMinute = prefs.getInt('notificationMinute') ?? 0;
    }

    if (!notificationsEnabled) {
      print('[WorkManager] Notifications are disabled');
      return;
    }

    // Initialize notification plugin
    final notifications = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
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
      0, // Daily quote notification ID
      'Quote of the Day ☀️',
      '"$quoteText" - $authorName',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quote_channel',
          'Quote of the Day',
          channelDescription: 'Daily inspirational quote notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('[WorkManager] Notification rescheduled with quote: "$quoteText"');
  } catch (e) {
    print('[WorkManager] Error updating notification: $e');
  }
}
