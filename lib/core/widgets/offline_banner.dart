import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/controllers/retry_queue_controller.dart';
import '../constants/connectivity_constants.dart';
import '../providers/connectivity_provider.dart';

/// Global offline banner widget
/// Displays when the device is offline with retry functionality
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBanner = ref.watch(showOfflineBannerProvider);
    final retryQueueState = ref.watch(retryQueueControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: showBanner ? null : 0,
      child: AnimatedOpacity(
        opacity: showBanner ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: showBanner
            ? Material(
                color: colorScheme.error,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          color: colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ConnectivityConstants.offlineTitle,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (retryQueueState.pendingOperations.isNotEmpty)
                                Text(
                                  '${retryQueueState.pendingOperations.length} ${ConnectivityConstants.pendingOperations}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onErrorContainer
                                        .withValues(alpha: 0.8),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (retryQueueState.pendingOperations.isNotEmpty)
                          TextButton(
                            onPressed: retryQueueState.isProcessing
                                ? null
                                : () {
                                    ref
                                        .read(
                                          retryQueueControllerProvider.notifier,
                                        )
                                        .processQueue();
                                  },
                            child: retryQueueState.isProcessing
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colorScheme.onErrorContainer,
                                    ),
                                  )
                                : Text(
                                    ConnectivityConstants.retryButton,
                                    style: TextStyle(
                                      color: colorScheme.onErrorContainer,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
