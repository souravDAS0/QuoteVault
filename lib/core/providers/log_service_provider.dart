import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/services/local_log_service.dart';
import '../domain/services/log_service.dart';

part 'log_service_provider.g.dart';

@riverpod
Future<LogService> logService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return LocalLogService(prefs);
}
