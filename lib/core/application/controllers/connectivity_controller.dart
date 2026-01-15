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
    _initializeConnectivity();

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return const ConnectivityState();
  }

  Future<void> _initializeConnectivity() async {
    final service = ref.read(connectivityServiceProvider);

    // Check initial status
    final status = await service.checkConnectivity();
    _updateFromStatus(status, isInitial: true);

    // Listen for changes
    _subscription = service.onConnectivityChanged.listen(
      (status) => _updateFromStatus(status, isInitial: false),
    );

    state = state.copyWith(isInitialized: true);
  }

  void _updateFromStatus(ConnectivityStatus status, {required bool isInitial}) {
    final wasConnected = state.isConnected;

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
