import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'notification_service.dart';
import '../domain/services/log_service.dart';

/// Concrete implementation of NotificationService using flutter_local_notifications
class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final LogService _logger;

  LocalNotificationService(this._logger);

  static const int _dailyQuoteNotificationId = 0;

  @override
  Future<void> initialize() async {
    await _logger.debug('Initializing notification service', 'NotificationService');

    // Initialize timezone data
    tz.initializeTimeZones();

    // Set the local timezone based on device offset
    // Using a simple map to avoid memory issues from iterating all timezones
    final offset = DateTime.now().timeZoneOffset;
    final offsetMinutes = offset.inMinutes;

    try {
      // Map common timezone offsets to locations
      String locationName;

      if (offsetMinutes == 330) {
        locationName = 'Asia/Kolkata'; // GMT+5:30 (IST)
      } else if (offsetMinutes == 0) {
        locationName = 'UTC'; // GMT+0
      } else if (offsetMinutes == -300) {
        locationName = 'America/New_York'; // GMT-5 (EST)
      } else if (offsetMinutes == -480) {
        locationName = 'America/Los_Angeles'; // GMT-8 (PST)
      } else if (offsetMinutes == 60) {
        locationName = 'Europe/London'; // GMT+1 (BST)
      } else if (offsetMinutes == 480) {
        locationName = 'Asia/Shanghai'; // GMT+8
      } else if (offsetMinutes == 540) {
        locationName = 'Asia/Tokyo'; // GMT+9
      } else {
        // Fallback: use UTC for unknown offsets
        locationName = 'UTC';
        await _logger.warning(
          'Unknown timezone offset: $offsetMinutes minutes, using UTC',
          'NotificationService',
        );
      }

      tz.setLocalLocation(tz.getLocation(locationName));
      await _logger.debug(
        'Timezone set to: ${tz.local.name} (offset: $offset)',
        'NotificationService',
      );
    } catch (e) {
      await _logger.error(
        'Error setting timezone: $e, using UTC',
        'NotificationService',
      );
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher_monochrome',
    );

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);

    // Create notification channel for Android
    const androidChannel = AndroidNotificationChannel(
      'daily_quote_channel',
      'Quote of the Day',
      description: 'Daily inspirational quote notification',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  @override
  Future<bool> requestPermission() async {
    await _logger.debug('Requesting notification permissions', 'NotificationService');

    // Request permissions on iOS
    final iosResult = await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Request permissions on Android (for Android 13+)
    final androidResult = await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    final granted = iosResult ?? androidResult ?? true;
    await _logger.info(
      'Notification permissions ${granted ? 'granted' : 'denied'}',
      'NotificationService',
    );

    // Return true if either returns true, or if both are null (older Android versions)
    return granted;
  }

  @override
  Future<void> scheduleDailyNotification({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    // Cancel existing daily notification first
    await cancelDailyNotification();

    final scheduledTime = _nextInstanceOfTime(hour, minute);
    await _logger.debug(
      'Scheduling notification for: $scheduledTime (timezone: ${tz.local.name})',
      'NotificationService',
    );

    // Schedule new notification
    await _notifications.zonedSchedule(
      _dailyQuoteNotificationId,
      title,
      body,
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quote_channel',
          'Quote of the Day',
          channelDescription: 'Daily inspirational quote notification',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            body,
            contentTitle: title,
            // summaryText: 'Quote of the Day',
          ),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    await _logger.info('Notification scheduled successfully', 'NotificationService');
  }

  @override
  Future<void> showImmediateNotification({
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      999, // Use a different ID for test notifications
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quote_channel',
          'Quote of the Day',
          channelDescription: 'Daily inspirational quote notification',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            body,
            contentTitle: title,
            // summaryText: 'Quote of the Day',
          ),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  @override
  Future<void> cancelDailyNotification() async {
    await _notifications.cancel(_dailyQuoteNotificationId);
  }

  /// Calculate next instance of given time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If scheduled time has passed for today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
