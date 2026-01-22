import 'package:quote_vault/features/collections/domain/entities/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/collection_details_state.dart';
import '../providers/collection_providers.dart';
import '../../../home_feed/domain/entities/quote.dart';
import '../../../home_feed/application/providers/quote_providers.dart';
import '../../../../core/domain/entities/retryable_operation.dart';
import '../../../../core/mixins/offline_aware_mixin.dart';
import 'collections_controller.dart';

part 'collection_details_controller.g.dart';

@riverpod
class CollectionDetailsController extends _$CollectionDetailsController {
  static const int _pageSize = 20;

  /// Track quotes being removed to prevent race conditions
  final Set<String> _removingQuotes = {};

  @override
  CollectionDetailsState build(String collectionId) {
    // Schedule initial data load after build completes
    Future.microtask(() => _loadCollectionDetails(collectionId));
    return const CollectionDetailsState(isLoading: true);
  }

  Future<void> _loadCollectionDetails(String collectionId) async {
    try {
      final repository = ref.read(collectionRepositoryProvider);

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          // Load collection and quotes in parallel
          final results = await Future.wait([
            repository.getCollectionById(collectionId),
            repository.getCollectionQuotes(
              collectionId: collectionId,
              page: 0,
              pageSize: _pageSize,
            ),
          ]);

          final collection = results[0] as Collection;
          final quotes = results[1] as List<Quote>;

          state = state.copyWith(
            collection: collection,
            quotes: quotes,
            isLoading: false,
            hasReachedEnd: quotes.length < _pageSize,
          );
        },
        operationType: OperationType.fetchCollectionDetails,
        payload: {'collectionId': collectionId},
        onQueued: () {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Operation queued. Waiting for connection...',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load collection: $e',
      );
    }
  }

  Future<void> refresh() async {
    final collectionId = state.collection?.id;
    if (collectionId == null) return;

    state = state.copyWith(
      isLoading: true,
      currentPage: 0,
      quotes: [],
      hasReachedEnd: false,
      errorMessage: null,
    );
    await _loadCollectionDetails(collectionId);
  }

  Future<void> loadMore() async {
    final collectionId = state.collection?.id;
    if (collectionId == null || state.isLoadingMore || state.hasReachedEnd) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      final nextPage = state.currentPage + 1;

      final newQuotes = await repository.getCollectionQuotes(
        collectionId: collectionId,
        page: nextPage,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        quotes: [...state.quotes, ...newQuotes],
        currentPage: nextPage,
        isLoadingMore: false,
        hasReachedEnd: newQuotes.length < _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more quotes: $e',
      );
    }
  }

  Future<void> updateCollectionName(String newName) async {
    final collectionId = state.collection?.id;
    if (collectionId == null || newName.trim().isEmpty) return;

    // Optimistic update
    state = state.copyWith(
      isEditingName: true,
      errorMessage: null,
      collection: state.collection?.copyWith(name: newName.trim()),
    );

    final success = await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(collectionRepositoryProvider);
        final updated = await repository.updateCollection(
          collectionId: collectionId,
          name: newName.trim(),
        );
        state = state.copyWith(collection: updated, isEditingName: false);
      },
      operationType: OperationType.updateCollectionName,
      payload: {'collectionId': collectionId, 'name': newName.trim()},
      operationId: 'update_collection_name_$collectionId',
      onQueued: () {
        // Keep optimistic update
        state = state.copyWith(isEditingName: false);
      },
    );

    if (!success) return;
  }

  Future<void> addQuote(String quoteId) async {
    final collectionId = state.collection?.id;
    if (collectionId == null) return;

    state = state.copyWith(isAddingQuote: true, errorMessage: null);

    final success = await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(collectionRepositoryProvider);
        await repository.addQuoteToCollection(
          collectionId: collectionId,
          quoteId: quoteId,
        );
        // Refresh to get updated list
        await refresh();
      },
      operationType: OperationType.addToCollection,
      payload: {'collectionId': collectionId, 'quoteId': quoteId},
      operationId: 'add_to_collection_${collectionId}_$quoteId',
      onQueued: () {
        state = state.copyWith(
          isAddingQuote: false,
          errorMessage: 'Quote will be added when online',
        );
      },
    );

    if (!success) {
      // Still invalidate collections to update quote count
      ref.invalidate(collectionsControllerProvider);
      return;
    }

    state = state.copyWith(isAddingQuote: false);
    // Invalidate collections to update quote count
    ref.invalidate(collectionsControllerProvider);
  }

  Future<void> removeQuote(String quoteId) async {
    final collectionId = state.collection?.id;
    if (collectionId == null) return;

    // Prevent concurrent removal of same quote
    if (_removingQuotes.contains(quoteId)) return;
    _removingQuotes.add(quoteId);

    // Optimistic update
    final _ = state.quotes;
    final _ = state.collection;
    state = state.copyWith(
      quotes: state.quotes.where((q) => q.id != quoteId).toList(),
      isRemovingQuote: true,
      collection: state.collection?.copyWith(
        quoteCount: (state.collection!.quoteCount - 1).clamp(0, 999999),
      ),
    );

    final success = await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(collectionRepositoryProvider);
        await repository.removeQuoteFromCollection(
          collectionId: collectionId,
          quoteId: quoteId,
        );
        state = state.copyWith(isRemovingQuote: false);
      },
      operationType: OperationType.removeFromCollection,
      payload: {'collectionId': collectionId, 'quoteId': quoteId},
      operationId: 'remove_from_collection_${collectionId}_$quoteId',
      onQueued: () {
        // Keep optimistic update
        state = state.copyWith(isRemovingQuote: false);
      },
    );

    _removingQuotes.remove(quoteId);

    if (!success) {
      // Operation queued - keep optimistic update
      // Still invalidate collections to update quote count
      ref.invalidate(collectionsControllerProvider);
      return;
    }
    // Invalidate collections to update quote count
    ref.invalidate(collectionsControllerProvider);
  }

  Future<void> toggleFavorite(String quoteId) async {
    // Optimistic update - toggle isFavorite in the quote
    final updatedQuotes = state.quotes.map((q) {
      if (q.id == quoteId) {
        return q.copyWith(isFavorite: !q.isFavorite);
      }
      return q;
    }).toList();

    state = state.copyWith(quotes: updatedQuotes);

    await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(quoteRepositoryProvider);
        await repository.toggleFavorite(quoteId: quoteId);
      },
      operationType: OperationType.toggleFavorite,
      payload: {'quoteId': quoteId},
      operationId: 'toggle_favorite_$quoteId',
      onQueued: () {},
    );
    // Invalidate collections to update favorites count
    ref.invalidate(collectionsControllerProvider);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Controller for Favorites (special collection using user_favorites table)
@riverpod
class FavoritesController extends _$FavoritesController {
  static const int _pageSize = 20;

  /// Track quotes being unfavorited to prevent race conditions
  final Set<String> _unfavoritingQuotes = {};

  @override
  FavoritesState build() {
    // Schedule initial data load after build completes
    Future.microtask(() => _loadFavorites());
    return const FavoritesState(isLoading: true);
  }

  Future<void> _loadFavorites() async {
    try {
      final repository = ref.read(collectionRepositoryProvider);

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          final results = await Future.wait([
            repository.getFavoritesCount(),
            repository.getFavorites(page: 0, pageSize: _pageSize),
          ]);

          final totalCount = results[0] as int;
          final quotes = results[1] as List<Quote>;

          state = state.copyWith(
            quotes: quotes,
            totalCount: totalCount,
            isLoading: false,
            hasReachedEnd: quotes.length < _pageSize,
          );
        },
        operationType: OperationType.fetchFavorites,
        payload: {},
        onQueued: () {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Operation queued. Waiting for connection...',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load favorites: $e',
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      currentPage: 0,
      quotes: [],
      hasReachedEnd: false,
      errorMessage: null,
    );
    await _loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      final nextPage = state.currentPage + 1;

      final newQuotes = await repository.getFavorites(
        page: nextPage,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        quotes: [...state.quotes, ...newQuotes],
        currentPage: nextPage,
        isLoadingMore: false,
        hasReachedEnd: newQuotes.length < _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more favorites: $e',
      );
    }
  }

  Future<void> unfavoriteQuote(String quoteId) async {
    if (_unfavoritingQuotes.contains(quoteId)) return;
    _unfavoritingQuotes.add(quoteId);

    // Optimistic update - remove from list
    state = state.copyWith(
      quotes: state.quotes.where((q) => q.id != quoteId).toList(),
      totalCount: (state.totalCount - 1).clamp(0, 999999),
    );

    await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(quoteRepositoryProvider);
        await repository.toggleFavorite(quoteId: quoteId);
      },
      operationType: OperationType.toggleFavorite,
      payload: {'quoteId': quoteId},
      operationId: 'unfavorite_$quoteId',
      onQueued: () {},
    );

    _unfavoritingQuotes.remove(quoteId);
    // Invalidate collections to update favorites count
    ref.invalidate(collectionsControllerProvider);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
