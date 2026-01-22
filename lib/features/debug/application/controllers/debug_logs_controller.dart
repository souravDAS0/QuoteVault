import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';
import '../../../../core/domain/entities/log_level.dart';
import '../../../../core/domain/services/log_service.dart';
import '../../../../core/providers/log_service_provider.dart';
import '../state/debug_logs_state.dart';

part 'debug_logs_controller.g.dart';

@riverpod
class DebugLogsController extends _$DebugLogsController {
  late LogService _logService;

  @override
  Future<DebugLogsState> build() async {
    _logService = await ref.read(logServiceProvider.future);
    return await _loadLogs();
  }

  Future<DebugLogsState> _loadLogs() async {
    try {
      final logs = await _logService.getLogs();
      return DebugLogsState(logs: logs, isLoading: false);
    } catch (e) {
      return DebugLogsState(
        isLoading: false,
        errorMessage: 'Failed to load logs: $e',
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadLogs());
  }

  Future<void> setFilter(LogLevel? filter) async {
    state.whenData((currentState) {
      state = AsyncValue.data(currentState.copyWith(filter: filter));
    });
  }

  Future<void> clearLogs() async {
    state.whenData((currentState) async {
      state = AsyncValue.data(currentState.copyWith(isClearing: true));

      try {
        await _logService.clearLogs();
        state = AsyncValue.data(
          currentState.copyWith(
            logs: [],
            isClearing: false,
            errorMessage: null,
          ),
        );
      } catch (e) {
        state = AsyncValue.data(
          currentState.copyWith(
            isClearing: false,
            errorMessage: 'Failed to clear logs: $e',
          ),
        );
      }
    });
  }

  String getLogsAsText() {
    return state.when(
      data: (data) {
        if (data.filteredLogs.isEmpty) {
          return 'No logs available.';
        }

        final buffer = StringBuffer();
        final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

        for (final log in data.filteredLogs) {
          final timestamp = dateFormat.format(log.timestamp);
          final level = log.level.displayName.toUpperCase();
          final source = log.source;
          final message = log.message;

          buffer.writeln('[$timestamp] [$level] [$source] $message');

          if (log.stackTrace != null) {
            buffer.writeln('Stack trace:');
            buffer.writeln(log.stackTrace);
            buffer.writeln();
          }
        }

        return buffer.toString();
      },
      loading: () => 'Loading logs...',
      error: (error, _) => 'Error loading logs: $error',
    );
  }
}
