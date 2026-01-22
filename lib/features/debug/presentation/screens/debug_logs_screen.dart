import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/debug_constants.dart';
import '../../../../core/domain/entities/log_level.dart';
import '../../application/controllers/debug_logs_controller.dart';
import '../widgets/log_entry_card.dart';
import '../widgets/log_level_filter_chip.dart';

class DebugLogsScreen extends ConsumerWidget {
  const DebugLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsState = ref.watch(debugLogsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(DebugConstants.debugLogsScreenTitle),
        actions: [
          // Copy logs button
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: DebugConstants.copyLogsTooltip,
            onPressed: () => _copyLogs(context, ref),
          ),
          // Clear logs button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: DebugConstants.clearLogsTooltip,
            onPressed: () => _showClearLogsDialog(context, ref),
          ),
        ],
      ),
      body: logsState.when(
        data: (state) {
          if (state.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return Column(
            children: [
              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    LogLevelFilterChip(
                      label: DebugConstants.filterAll,
                      isSelected: state.filter == null,
                      onTap: () => ref
                          .read(debugLogsControllerProvider.notifier)
                          .setFilter(null),
                    ),
                    const SizedBox(width: 8),
                    LogLevelFilterChip(
                      label: DebugConstants.filterDebug,
                      isSelected: state.filter == LogLevel.debug,
                      onTap: () => ref
                          .read(debugLogsControllerProvider.notifier)
                          .setFilter(LogLevel.debug),
                    ),
                    const SizedBox(width: 8),
                    LogLevelFilterChip(
                      label: DebugConstants.filterInfo,
                      isSelected: state.filter == LogLevel.info,
                      onTap: () => ref
                          .read(debugLogsControllerProvider.notifier)
                          .setFilter(LogLevel.info),
                    ),
                    const SizedBox(width: 8),
                    LogLevelFilterChip(
                      label: DebugConstants.filterWarning,
                      isSelected: state.filter == LogLevel.warning,
                      onTap: () => ref
                          .read(debugLogsControllerProvider.notifier)
                          .setFilter(LogLevel.warning),
                    ),
                    const SizedBox(width: 8),
                    LogLevelFilterChip(
                      label: DebugConstants.filterError,
                      isSelected: state.filter == LogLevel.error,
                      onTap: () => ref
                          .read(debugLogsControllerProvider.notifier)
                          .setFilter(LogLevel.error),
                    ),
                  ],
                ),
              ),
              // Entry count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  DebugConstants.entryCount(state.logCount),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 8),
              // Logs list
              Expanded(
                child: state.filteredLogs.isEmpty
                    ? Center(
                        child: Text(
                          DebugConstants.noLogsMessage,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => ref
                            .read(debugLogsControllerProvider.notifier)
                            .refresh(),
                        child: ListView.builder(
                          itemCount: state.filteredLogs.length,
                          itemBuilder: (context, index) {
                            return LogEntryCard(
                              entry: state.filteredLogs[index],
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error: $error',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _copyLogs(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(debugLogsControllerProvider.notifier);
    final logsText = controller.getLogsAsText();

    await Clipboard.setData(ClipboardData(text: logsText));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(DebugConstants.logsCopiedMessage),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _showClearLogsDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(DebugConstants.clearLogsDialogTitle),
        content: const Text(DebugConstants.clearLogsDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(DebugConstants.clearLogsDialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(DebugConstants.clearLogsDialogConfirm),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(debugLogsControllerProvider.notifier).clearLogs();
    }
  }
}
