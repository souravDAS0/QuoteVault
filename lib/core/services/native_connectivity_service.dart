import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../domain/entities/connectivity_status.dart';
import 'connectivity_service.dart';

/// Concrete implementation using connectivity_plus
class NativeConnectivityService implements ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityStatus> _statusController =
      StreamController<ConnectivityStatus>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectivityStatus? _lastKnownStatus;

  NativeConnectivityService() {
    _initializeStream();
  }

  void _initializeStream() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final status = _mapToStatus(results);
        _lastKnownStatus = status;
        _statusController.add(status);
      },
      onError: (error) {
        // On error, assume disconnected
        final status = const ConnectivityStatus.disconnected();
        _lastKnownStatus = status;
        _statusController.add(status);
      },
    );
  }

  ConnectivityStatus _mapToStatus(List<ConnectivityResult> results) {
    // If any result is mobile/wifi/ethernet, we consider it connected.
    // connectivity_plus v6+ returns a List<ConnectivityResult>.

    if (results.contains(ConnectivityResult.mobile)) {
      return const ConnectivityStatus.connected(type: ConnectionType.cellular);
    } else if (results.contains(ConnectivityResult.wifi)) {
      return const ConnectivityStatus.connected(type: ConnectionType.wifi);
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return const ConnectivityStatus.connected(type: ConnectionType.ethernet);
    } else if (results.contains(ConnectivityResult.vpn)) {
      // VPN is a connection type, we can map it to unknown or wifi depending on preference.
      // Mapping to unknown as it wasn't explicitly in our ConnectionType enum except as general connectivity.
      return const ConnectivityStatus.connected(type: ConnectionType.unknown);
    } else if (results.contains(ConnectivityResult.other)) {
      return const ConnectivityStatus.connected(type: ConnectionType.unknown);
    }

    // If none of the above (e.g. only contains none or empty), it's disconnected
    return const ConnectivityStatus.disconnected();
  }

  @override
  Stream<ConnectivityStatus> get onConnectivityChanged =>
      _statusController.stream;

  @override
  Future<ConnectivityStatus> checkConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      final status = _mapToStatus(results);
      _lastKnownStatus = status;
      return status;
    } catch (_) {
      return _lastKnownStatus ?? const ConnectivityStatus.disconnected();
    }
  }

  @override
  Future<bool> get isConnected async {
    final status = await checkConnectivity();
    return status.isConnected;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }
}
