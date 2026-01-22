import 'package:freezed_annotation/freezed_annotation.dart';
import 'log_level.dart';

part 'log_entry.freezed.dart';
part 'log_entry.g.dart';

@freezed
abstract class LogEntry with _$LogEntry {
  const factory LogEntry({
    required DateTime timestamp,
    required LogLevel level,
    required String message,
    required String source,
    String? stackTrace,
  }) = _LogEntry;

  factory LogEntry.fromJson(Map<String, dynamic> json) =>
      _$LogEntryFromJson(json);
}
