import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/connectivity_status.dart';

part 'connectivity_state.freezed.dart';

/// State for connectivity monitoring across the app
@freezed
abstract class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    @Default(true) bool isConnected,
    @Default(ConnectionType.unknown) ConnectionType connectionType,
    @Default(false) bool isInitialized,
    @Default(false) bool wasOffline,
    DateTime? lastOnlineTime,
  }) = _ConnectivityState;
}
