import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/controllers/connectivity_controller.dart';
import '../application/state/connectivity_state.dart';
import '../constants/connectivity_constants.dart';

/// Widget that listens for reconnection events and shows a snackbar
class ReconnectionNotifier extends ConsumerWidget {
  final Widget child;

  const ReconnectionNotifier({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ConnectivityState>(
      connectivityControllerProvider,
      (previous, next) {
        if (next.wasOffline && next.isConnected) {
          _showReconnectionSnackbar(context, ref);
        }
      },
    );

    return child;
  }

  void _showReconnectionSnackbar(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.wifi_rounded,
              color: colorScheme.onPrimary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              ConnectivityConstants.backOnline,
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    // Acknowledge reconnection to reset wasOffline flag
    ref.read(connectivityControllerProvider.notifier).acknowledgeReconnection();
  }
}
