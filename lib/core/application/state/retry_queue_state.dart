import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/retryable_operation.dart';

part 'retry_queue_state.freezed.dart';

/// State for the retry queue that manages offline operations
@freezed
abstract class RetryQueueState with _$RetryQueueState {
  const factory RetryQueueState({
    @Default([]) List<RetryableOperation> pendingOperations,
    @Default(false) bool isProcessing,
    @Default([]) List<String> failedOperationIds,
  }) = _RetryQueueState;
}
