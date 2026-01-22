import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/entities/log_entry.dart';
import '../../../../core/domain/entities/log_level.dart';

part 'debug_logs_state.freezed.dart';

@freezed
abstract class DebugLogsState with _$DebugLogsState {
  const factory DebugLogsState({
    @Default([]) List<LogEntry> logs,
    @Default(null) LogLevel? filter,
    @Default(false) bool isLoading,
    @Default(false) bool isClearing,
    String? errorMessage,
  }) = _DebugLogsState;

  const DebugLogsState._();

  List<LogEntry> get filteredLogs {
    if (filter == null) {
      return logs;
    }
    return logs.where((log) => log.level == filter).toList();
  }

  int get logCount => filteredLogs.length;
}
