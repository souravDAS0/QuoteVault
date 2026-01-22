import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/log_entry.dart';
import '../../domain/entities/log_level.dart';
import '../../domain/services/log_service.dart';

class LocalLogService implements LogService {
  final SharedPreferences _prefs;
  static const String _logsKey = 'debug_logs';
  static const int _maxLogEntries = 500;

  LocalLogService(this._prefs);

  @override
  Future<void> log(
    String message,
    String source, {
    required LogLevel level,
    String? stackTrace,
  }) async {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      message: message,
      source: source,
      stackTrace: stackTrace,
    );

    // Print to console for development
    final levelPrefix = '[${level.displayName.toUpperCase()}]';
    final sourcePrefix = '[$source]';
    print('$levelPrefix $sourcePrefix $message');
    if (stackTrace != null) {
      print('Stack trace:\n$stackTrace');
    }

    // Get existing logs
    final logs = await getLogs();

    // Add new entry at the beginning
    logs.insert(0, entry);

    // Keep only the last _maxLogEntries
    if (logs.length > _maxLogEntries) {
      logs.removeRange(_maxLogEntries, logs.length);
    }

    // Save to SharedPreferences
    final jsonList = logs.map((e) => e.toJson()).toList();
    await _prefs.setString(_logsKey, jsonEncode(jsonList));
  }

  @override
  Future<void> debug(String message, String source) async {
    await log(message, source, level: LogLevel.debug);
  }

  @override
  Future<void> info(String message, String source) async {
    await log(message, source, level: LogLevel.info);
  }

  @override
  Future<void> warning(String message, String source) async {
    await log(message, source, level: LogLevel.warning);
  }

  @override
  Future<void> error(
    String message,
    String source, {
    String? stackTrace,
  }) async {
    await log(
      message,
      source,
      level: LogLevel.error,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<List<LogEntry>> getLogs() async {
    final jsonString = _prefs.getString(_logsKey);
    if (jsonString == null) {
      return [];
    }

    try {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => LogEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If parsing fails, return empty list and clear corrupted data
      await _prefs.remove(_logsKey);
      return [];
    }
  }

  @override
  Future<void> clearLogs() async {
    await _prefs.remove(_logsKey);
  }

  @override
  Future<int> getLogCount() async {
    final logs = await getLogs();
    return logs.length;
  }
}
