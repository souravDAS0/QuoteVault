import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/notification_service.dart';
import '../services/local_notification_service.dart';

part 'notification_manager_provider.g.dart';

/// Provider for notification service instance
@riverpod
NotificationService notificationService(Ref ref) {
  return LocalNotificationService();
}
