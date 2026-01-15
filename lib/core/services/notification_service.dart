/// Abstract notification service interface
/// NO platform-specific imports (flutter_local_notifications)
abstract class NotificationService {
  /// Initialize the notification service
  Future<void> initialize();

  /// Request notification permissions (iOS)
  Future<bool> requestPermission();

  /// Schedule a daily notification at specified time
  /// [hour] Hour in 24-hour format (0-23)
  /// [minute] Minute (0-59)
  /// [title] Notification title
  /// [body] Notification body
  Future<void> scheduleDailyNotification({
    required int hour,
    required int minute,
    required String title,
    required String body,
  });

  /// Cancel all scheduled notifications
  Future<void> cancelAllNotifications();

  /// Show an immediate notification for testing
  Future<void> showImmediateNotification({
    required String title,
    required String body,
  });

  /// Cancel only the daily quote notification
  Future<void> cancelDailyNotification();
}
