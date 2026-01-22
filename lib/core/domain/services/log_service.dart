import '../entities/log_entry.dart';
import '../entities/log_level.dart';

abstract class LogService {
  /// Logs a message with the specified level
  Future<void> log(
    String message,
    String source, {
    required LogLevel level,
    String? stackTrace,
  });

  /// Logs a debug message
  Future<void> debug(String message, String source);

  /// Logs an info message
  Future<void> info(String message, String source);

  /// Logs a warning message
  Future<void> warning(String message, String source);

  /// Logs an error message with optional stack trace
  Future<void> error(
    String message,
    String source, {
    String? stackTrace,
  });

  /// Retrieves all log entries
  Future<List<LogEntry>> getLogs();

  /// Clears all log entries
  Future<void> clearLogs();

  /// Gets the count of log entries
  Future<int> getLogCount();
}
