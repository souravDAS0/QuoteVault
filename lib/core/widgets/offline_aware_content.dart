import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/connectivity_constants.dart';
import '../providers/connectivity_provider.dart';

/// Wrapper widget that shows offline state for content areas
class OfflineAwareContent extends ConsumerWidget {
  final Widget child;
  final Widget? offlineWidget;
  final bool showDefaultOffline;
  final String? offlineMessage;

  const OfflineAwareContent({
    super.key,
    required this.child,
    this.offlineWidget,
    this.showDefaultOffline = true,
    this.offlineMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    if (!isOnline && showDefaultOffline) {
      return offlineWidget ?? _buildDefaultOfflineWidget(context);
    }

    return child;
  }

  Widget _buildDefaultOfflineWidget(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 64,
              color: colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              ConnectivityConstants.offlineTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              offlineMessage ?? ConnectivityConstants.offlineSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple offline indicator chip for inline use
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);
    final colorScheme = Theme.of(context).colorScheme;

    if (isOnline) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 14,
            color: colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 4),
          Text(
            'Offline',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
          ),
        ],
      ),
    );
  }
}
