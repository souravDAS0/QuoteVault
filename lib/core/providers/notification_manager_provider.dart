import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/notification_service.dart';
import '../services/local_notification_service.dart';
import 'log_service_provider.dart';

part 'notification_manager_provider.g.dart';

/// Provider for notification service instance
@riverpod
Future<NotificationService> notificationService(Ref ref) async {
  final logger = await ref.read(logServiceProvider.future);
  final service = LocalNotificationService(logger);
  await service.initialize();
  return service;
}
