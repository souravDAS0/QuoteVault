import 'package:freezed_annotation/freezed_annotation.dart';

part 'retryable_operation.freezed.dart';
part 'retryable_operation.g.dart';

/// Types of operations that can be retried when back online
enum OperationType {
  toggleFavorite,
  createCollection,
  addToCollection,
  removeFromCollection,
  updateProfile,
  syncSettings,
  deleteCollection,
  updateCollectionName,
  fetchCollections,
  fetchCollectionDetails,
  fetchFavorites,
  fetchQuotes,
  fetchDailyQuote,
}

/// Domain entity representing an operation that can be retried
/// when network connectivity is restored
@freezed
abstract class RetryableOperation with _$RetryableOperation {
  const factory RetryableOperation({
    required String id,
    required OperationType type,
    required Map<String, dynamic> payload,
    required DateTime createdAt,
    @Default(0) int retryCount,
    @Default(3) int maxRetries,
    String? lastError,
  }) = _RetryableOperation;

  factory RetryableOperation.fromJson(Map<String, dynamic> json) =>
      _$RetryableOperationFromJson(json);
}

/// Extension for convenient checks
extension RetryableOperationX on RetryableOperation {
  bool get canRetry => retryCount < maxRetries;
  bool get hasExceededMaxRetries => retryCount >= maxRetries;

  RetryableOperation incrementRetry({String? error}) {
    return copyWith(retryCount: retryCount + 1, lastError: error);
  }
}
