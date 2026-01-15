import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../application/controllers/retry_queue_controller.dart';
import '../domain/entities/retryable_operation.dart';
import '../providers/connectivity_provider.dart';

/// Utility functions for offline-aware operations in controllers
class OfflineAwareOperations {
  final Ref _ref;
  static const _uuid = Uuid();

  OfflineAwareOperations(this._ref);

  /// Check if currently online
  bool get isOnline => _ref.read(isOnlineProvider);

  /// Execute operation with offline handling
  /// Returns true if operation executed, false if queued for later
  Future<bool> executeWithOfflineHandling({
    required Future<void> Function() operation,
    required OperationType operationType,
    required Map<String, dynamic> payload,
    String? operationId,
    void Function()? onQueued,
  }) async {
    if (!isOnline) {
      // Queue for retry
      _enqueueOperation(
        operationId: operationId ?? _uuid.v4(),
        type: operationType,
        payload: payload,
      );
      onQueued?.call();
      return false;
    }

    try {
      await operation();
      return true;
    } catch (e) {
      if (_isNetworkError(e)) {
        _enqueueOperation(
          operationId: operationId ?? _uuid.v4(),
          type: operationType,
          payload: payload,
        );
        onQueued?.call();
        return false;
      }
      rethrow;
    }
  }

  void _enqueueOperation({
    required String operationId,
    required OperationType type,
    required Map<String, dynamic> payload,
  }) {
    final operation = RetryableOperation(
      id: operationId,
      type: type,
      payload: payload,
      createdAt: DateTime.now(),
    );
    _ref.read(retryQueueControllerProvider.notifier).enqueue(operation);
  }

  bool _isNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('socketexception') ||
        errorString.contains('connection') ||
        errorString.contains('network') ||
        errorString.contains('timeout') ||
        errorString.contains('unreachable') ||
        errorString.contains('no internet');
  }
}

/// Extension on Ref for convenient offline-aware operations
extension OfflineAwareRefExtension on Ref {
  OfflineAwareOperations get offlineAware => OfflineAwareOperations(this);

  bool get isOnline => read(isOnlineProvider);
}
