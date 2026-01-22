import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/connectivity_status.dart';
import '../../providers/connectivity_provider.dart';
import '../state/connectivity_state.dart';
import 'retry_queue_controller.dart';

part 'connectivity_controller.g.dart';

/// Controller for managing connectivity state across the app
@riverpod
class ConnectivityController extends _$ConnectivityController {
  StreamSubscription<ConnectivityStatus>? _subscription;

  @override
  ConnectivityState build() {
    final service = ref.read(connectivityServiceProvider);

    // Listen for changes immediately
    _subscription = service.onConnectivityChanged.listen(
      (status) => _updateFromStatus(status, isInitial: false),
    );

    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Check initial status asynchronously but mark as initialized immediately
    _checkInitialConnectivity();

    // Start with default offline state, will be updated immediately by the check
    return const ConnectivityState(isInitialized: true);
  }

  Future<void> _checkInitialConnectivity() async {
    final service = ref.read(connectivityServiceProvider);
    final status = await service.checkConnectivity();
    _updateFromStatus(status, isInitial: true);
  }

  void _updateFromStatus(ConnectivityStatus status, {required bool isInitial}) {
    final wasConnected = state.isConnected;
    final bool hasChanged = status.isConnected != wasConnected;

    // Only update if the status actually changed or it's the initial check
    if (!hasChanged && !isInitial) {
      return;
    }

    status.when(
      connected: (type) {
        state = state.copyWith(
          isConnected: true,
          connectionType: type,
          wasOffline: !isInitial && !wasConnected,
          lastOnlineTime: DateTime.now(),
        );

        // Trigger retry queue when coming back online
        if (!isInitial && !wasConnected) {
          ref.read(retryQueueControllerProvider.notifier).processQueue();
        }
      },
      disconnected: () {
        state = state.copyWith(
          isConnected: false,
          connectionType: ConnectionType.none,
          wasOffline: false, // Reset when going offline
        );
      },
    );
  }

  /// Clear the wasOffline flag after showing reconnection UI
  void acknowledgeReconnection() {
    state = state.copyWith(wasOffline: false);
  }

  /// Manually check connectivity
  Future<void> checkConnectivity() async {
    final service = ref.read(connectivityServiceProvider);
    final status = await service.checkConnectivity();
    _updateFromStatus(status, isInitial: false);
  }
}
