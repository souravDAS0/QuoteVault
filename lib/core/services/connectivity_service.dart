import '../domain/entities/connectivity_status.dart';

/// Abstract connectivity service interface
/// NO platform-specific imports - this is a domain-level abstraction
abstract class ConnectivityService {
  /// Stream of connectivity status changes
  Stream<ConnectivityStatus> get onConnectivityChanged;

  /// Check current connectivity status (one-time)
  Future<ConnectivityStatus> checkConnectivity();

  /// Whether currently connected to internet
  Future<bool> get isConnected;

  /// Dispose resources
  void dispose();
}
