import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/controllers/connectivity_controller.dart';
import '../services/connectivity_service.dart';
import '../services/native_connectivity_service.dart';

part 'connectivity_provider.g.dart';

/// Provider for connectivity service instance
@riverpod
ConnectivityService connectivityService(Ref ref) {
  final service = NativeConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// Convenience provider for checking if online
@riverpod
bool isOnline(Ref ref) {
  return ref.watch(connectivityControllerProvider).isConnected;
}

/// Convenience provider for showing offline banner
@riverpod
bool showOfflineBanner(Ref ref) {
  final state = ref.watch(connectivityControllerProvider);
  return state.isInitialized && !state.isConnected;
}
