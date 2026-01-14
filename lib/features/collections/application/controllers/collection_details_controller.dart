import 'package:quote_vault/features/collections/domain/entities/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/collection_details_state.dart';
import '../providers/collection_providers.dart';
import '../../../home_feed/domain/entities/quote.dart';

part 'collection_details_controller.g.dart';

@riverpod
class CollectionDetailsController extends _$CollectionDetailsController {
  static const int _pageSize = 20;

  /// Track quotes being removed to prevent race conditions
  final Set<String> _removingQuotes = {};

  @override
  CollectionDetailsState build(String collectionId) {
    _loadCollectionDetails(collectionId);
    return const CollectionDetailsState(isLoading: true);
  }

  Future<void> _loadCollectionDetails(String collectionId) async {
    try {
      final repository = ref.read(collectionRepositoryProvider);

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

    state = state.copyWith(isEditingName: true, errorMessage: null);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      final updated = await repository.updateCollection(
        collectionId: collectionId,
        name: newName.trim(),
      );

      state = state.copyWith(collection: updated, isEditingName: false);
    } catch (e) {
      state = state.copyWith(
        isEditingName: false,
        errorMessage: 'Failed to update collection name: $e',
      );
    }
  }

  Future<void> addQuote(String quoteId) async {
    final collectionId = state.collection?.id;
    if (collectionId == null) return;

    state = state.copyWith(isAddingQuote: true, errorMessage: null);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      await repository.addQuoteToCollection(
        collectionId: collectionId,
        quoteId: quoteId,
      );

      // Refresh to get updated list
      await refresh();
    } catch (e) {
      state = state.copyWith(
        isAddingQuote: false,
        errorMessage: e.toString().contains('already in collection')
            ? 'Quote already in this collection'
            : 'Failed to add quote: $e',
      );
    }
  }

  Future<void> removeQuote(String quoteId) async {
    final collectionId = state.collection?.id;
    if (collectionId == null) return;

    // Prevent concurrent removal of same quote
    if (_removingQuotes.contains(quoteId)) return;
    _removingQuotes.add(quoteId);

    // Optimistic update
    final originalQuotes = state.quotes;
    state = state.copyWith(
      quotes: state.quotes.where((q) => q.id != quoteId).toList(),
      isRemovingQuote: true,
    );

    try {
      final repository = ref.read(collectionRepositoryProvider);
      await repository.removeQuoteFromCollection(
        collectionId: collectionId,
        quoteId: quoteId,
      );

      // Update collection quote count
      if (state.collection != null) {
        state = state.copyWith(
          collection: state.collection!.copyWith(
            quoteCount: state.collection!.quoteCount - 1,
          ),
          isRemovingQuote: false,
        );
      }
    } catch (e) {
      // Revert optimistic update
      state = state.copyWith(
        quotes: originalQuotes,
        isRemovingQuote: false,
        errorMessage: 'Failed to remove quote: $e',
      );
    } finally {
      _removingQuotes.remove(quoteId);
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Controller for Favorites (special collection using user_favorites table)
@riverpod
class FavoritesController extends _$FavoritesController {
  static const int _pageSize = 20;

  @override
  FavoritesState build() {
    _loadFavorites();
    return const FavoritesState(isLoading: true);
  }

  Future<void> _loadFavorites() async {
    try {
      final repository = ref.read(collectionRepositoryProvider);

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

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
