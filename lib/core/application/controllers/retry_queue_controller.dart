import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/application/providers/auth_state_provider.dart';
import '../../../features/collections/application/providers/collection_providers.dart';
import '../../../features/home_feed/application/providers/quote_providers.dart';
import '../../../features/settings/application/providers/settings_providers.dart';
import '../../domain/entities/retryable_operation.dart';
import '../state/retry_queue_state.dart';

part 'retry_queue_controller.g.dart';

/// Controller for managing the retry queue of offline operations
@riverpod
class RetryQueueController extends _$RetryQueueController {
  @override
  RetryQueueState build() {
    return const RetryQueueState();
  }

  /// Add operation to retry queue
  void enqueue(RetryableOperation operation) {
    // Avoid duplicates
    final exists = state.pendingOperations.any((op) => op.id == operation.id);
    if (exists) return;

    state = state.copyWith(
      pendingOperations: [...state.pendingOperations, operation],
    );
  }

  /// Remove operation from queue
  void dequeue(String operationId) {
    state = state.copyWith(
      pendingOperations: state.pendingOperations
          .where((op) => op.id != operationId)
          .toList(),
      failedOperationIds: state.failedOperationIds
          .where((id) => id != operationId)
          .toList(),
    );
  }

  /// Process all pending operations
  Future<void> processQueue() async {
    if (state.isProcessing || state.pendingOperations.isEmpty) return;

    state = state.copyWith(isProcessing: true);

    final operations = List<RetryableOperation>.from(state.pendingOperations);
    final succeeded = <String>[];
    final failed = <String>[];
    final updatedOperations = <RetryableOperation>[];

    for (final operation in operations) {
      try {
        await _executeOperation(operation);
        succeeded.add(operation.id);
      } catch (e) {
        final updated = operation.incrementRetry(error: e.toString());
        if (updated.hasExceededMaxRetries) {
          failed.add(operation.id);
        } else {
          updatedOperations.add(updated);
        }
      }
    }

    // Update state with remaining operations
    state = state.copyWith(
      pendingOperations: updatedOperations,
      failedOperationIds: [...state.failedOperationIds, ...failed],
      isProcessing: false,
    );
  }

  /// Manual retry for a specific operation
  Future<bool> retryOperation(String operationId) async {
    final operation = state.pendingOperations.firstWhere(
      (op) => op.id == operationId,
      orElse: () => throw Exception('Operation not found'),
    );

    try {
      await _executeOperation(operation);
      dequeue(operationId);
      return true;
    } catch (e) {
      // Update error message
      final updated = operation.incrementRetry(error: e.toString());
      _updateOperation(updated);
      return false;
    }
  }

  /// Execute operation based on type
  Future<void> _executeOperation(RetryableOperation operation) async {
    switch (operation.type) {
      case OperationType.toggleFavorite:
        await _executeToggleFavorite(operation);
      case OperationType.createCollection:
        await _executeCreateCollection(operation);
      case OperationType.addToCollection:
        await _executeAddToCollection(operation);
      case OperationType.removeFromCollection:
        await _executeRemoveFromCollection(operation);
      case OperationType.updateProfile:
        await _executeUpdateProfile(operation);
      case OperationType.syncSettings:
        await _executeSyncSettings(operation);
      case OperationType.deleteCollection:
        await _executeDeleteCollection(operation);
      case OperationType.updateCollectionName:
        await _executeUpdateCollectionName(operation);
      case OperationType.fetchQuotes:
        await _executeFetchQuotes(operation);
      case OperationType.fetchDailyQuote:
        await _executeFetchDailyQuote(operation);
      case OperationType.fetchCollections:
        await _executeFetchCollections(operation);
      case OperationType.fetchCollectionDetails:
        await _executeFetchCollectionDetails(operation);
      case OperationType.fetchFavorites:
        await _executeFetchFavorites(operation);
    }
  }

  Future<void> _executeFetchDailyQuote(RetryableOperation operation) async {
    final repository = ref.read(quoteRepositoryProvider);
    await repository.getDailyQuote();
  }

  Future<void> _executeFetchCollections(RetryableOperation operation) async {
    final repository = ref.read(collectionRepositoryProvider);
    await repository.getCollections(sortBy: 'created_at', ascending: false);
  }

  Future<void> _executeFetchCollectionDetails(
    RetryableOperation operation,
  ) async {
    final collectionId = operation.payload['collectionId'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.getCollectionById(collectionId);
  }

  Future<void> _executeFetchFavorites(RetryableOperation operation) async {
    final repository = ref.read(collectionRepositoryProvider);
    await repository.getFavorites(page: 0);
  }

  Future<void> _executeFetchQuotes(RetryableOperation operation) async {
    final repository = ref.read(quoteRepositoryProvider);
    await repository.getQuotes(page: 0);
  }

  Future<void> _executeToggleFavorite(RetryableOperation operation) async {
    final quoteId = operation.payload['quoteId'] as String;
    final repository = ref.read(quoteRepositoryProvider);
    await repository.toggleFavorite(quoteId: quoteId);
  }

  Future<void> _executeCreateCollection(RetryableOperation operation) async {
    final name = operation.payload['name'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.createCollection(name: name);
  }

  Future<void> _executeAddToCollection(RetryableOperation operation) async {
    final collectionId = operation.payload['collectionId'] as String;
    final quoteId = operation.payload['quoteId'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.addQuoteToCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  Future<void> _executeRemoveFromCollection(
    RetryableOperation operation,
  ) async {
    final collectionId = operation.payload['collectionId'] as String;
    final quoteId = operation.payload['quoteId'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.removeQuoteFromCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  Future<void> _executeUpdateProfile(RetryableOperation operation) async {
    final displayName = operation.payload['displayName'] as String?;
    final photoUrl = operation.payload['photoUrl'] as String?;
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.updateUserProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  Future<void> _executeSyncSettings(RetryableOperation operation) async {
    final repository = await ref.read(settingsRepositoryProvider.future);
    final settings = await repository.getSettings();
    await repository.syncSettingsToCloud(settings);
  }

  Future<void> _executeDeleteCollection(RetryableOperation operation) async {
    final collectionId = operation.payload['collectionId'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.deleteCollection(collectionId);
  }

  Future<void> _executeUpdateCollectionName(
    RetryableOperation operation,
  ) async {
    final collectionId = operation.payload['collectionId'] as String;
    final name = operation.payload['name'] as String;
    final repository = ref.read(collectionRepositoryProvider);
    await repository.updateCollection(collectionId: collectionId, name: name);
  }

  void _updateOperation(RetryableOperation updated) {
    state = state.copyWith(
      pendingOperations: state.pendingOperations
          .map((op) => op.id == updated.id ? updated : op)
          .toList(),
    );
  }

  /// Clear all pending operations
  void clearQueue() {
    state = const RetryQueueState();
  }

  /// Clear failed operation ids (acknowledge failures)
  void clearFailedOperations() {
    state = state.copyWith(failedOperationIds: []);
  }

  /// Get count of pending operations
  int get pendingCount => state.pendingOperations.length;
}
