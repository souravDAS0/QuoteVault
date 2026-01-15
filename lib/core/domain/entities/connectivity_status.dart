import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_status.freezed.dart';

/// Connection type enumeration
enum ConnectionType {
  wifi,
  cellular,
  ethernet,
  unknown,
  none,
}

/// Domain entity representing connectivity status
/// NO framework dependencies
@freezed
sealed class ConnectivityStatus with _$ConnectivityStatus {
  const factory ConnectivityStatus.connected({
    required ConnectionType type,
  }) = ConnectedStatus;

  const factory ConnectivityStatus.disconnected() = DisconnectedStatus;

  /// Factory to create from platform channel data
  factory ConnectivityStatus.fromPlatformData(Map<String, dynamic> data) {
    final isConnected = data['isConnected'] as bool? ?? false;
    final connectionTypeStr = data['connectionType'] as String? ?? 'none';

    if (!isConnected) {
      return const ConnectivityStatus.disconnected();
    }

    final connectionType = switch (connectionTypeStr) {
      'wifi' => ConnectionType.wifi,
      'cellular' => ConnectionType.cellular,
      'ethernet' => ConnectionType.ethernet,
      'none' => ConnectionType.none,
      _ => ConnectionType.unknown,
    };

    return ConnectivityStatus.connected(type: connectionType);
  }
}

/// Extension for convenient checks
extension ConnectivityStatusX on ConnectivityStatus {
  bool get isConnected => this is ConnectedStatus;
  bool get isDisconnected => this is DisconnectedStatus;

  ConnectionType get connectionType => switch (this) {
        ConnectedStatus(:final type) => type,
        DisconnectedStatus() => ConnectionType.none,
      };
}
