import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/home_feed_state.dart';
import '../providers/quote_providers.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/author.dart';
import '../../domain/entities/quote.dart';

import '../../../../core/domain/entities/retryable_operation.dart';
import '../../../../core/mixins/offline_aware_mixin.dart';
import '../../../collections/application/controllers/collections_controller.dart';

part 'home_feed_controller.g.dart';

@riverpod
class HomeFeedController extends _$HomeFeedController {
  static const int _pageSize = 10;

  /// Track quotes currently being toggled to prevent race conditions
  final Set<String> _togglingFavorites = {};

  @override
  HomeFeedState build() {
    // Schedule initial data load after build completes
    Future.microtask(() => _loadInitialData());
    return const HomeFeedState(isLoading: true, isDailyQuoteLoading: true);
  }

  Future<void> _loadInitialData() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);

      // Load daily quote (non-blocking, scheduled after state init)
      Future.microtask(() => _loadDailyQuote());

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          // Load categories (may fail if table doesn't exist)
          List<Category> categories = [];
          try {
            categories = await repository.getCategories();
            print('Loaded ${categories.length} categories');
          } catch (e) {
            print('Failed to load categories (table may not exist): $e');
            // Continue without categories
          }

          // Add "all" category at the beginning
          final allCategory = Category(
            id: 'all',
            name: 'All',
            isSelected: true,
          );
          categories = [
            allCategory,
            ...categories.map((cat) => cat.copyWith(isSelected: false)),
          ].toList();

          // Load authors
          List<Author> authors = [];
          try {
            authors = await repository.getAuthors();
            print('Loaded ${authors.length} authors');
          } catch (e) {
            print('Failed to load authors: $e');
          }

          // Load quotes
          List<dynamic> quotes = [];
          quotes = await repository.getQuotes(page: 0, pageSize: _pageSize);
          print('Loaded ${quotes.length} quotes');

          state = state.copyWith(
            categories: categories,
            authors: authors,
            quotes: quotes.cast(),
            isLoading: false,
            hasReachedEnd: quotes.length < _pageSize,
            errorMessage: null, // Clear any previous error
          );
        },
        operationType: OperationType.fetchQuotes,
        payload: {'page': 0},
        onQueued: () {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Operation queued. Waiting for connection...',
          );
        },
      );
    } catch (e) {
      print('Error in _loadInitialData: $e');

      // Determine user-friendly error message
      String errorMessage = 'Failed to load feed';
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Network') ||
          e.toString().contains('No internet connection')) {
        errorMessage =
            'No internet connection. Please check your network settings.';
      } else {
        errorMessage = 'Failed to load feed: ${e.toString()}';
      }

      state = state.copyWith(
        isLoading: false,
        isDailyQuoteLoading: false,
        errorMessage: errorMessage,
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
    await _loadInitialData();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final repository = ref.read(quoteRepositoryProvider);
      final nextPage = state.currentPage + 1;

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          final newQuotes = await repository.getQuotes(
            page: nextPage,
            pageSize: _pageSize,
            categoryId: state.selectedCategoryId == 'all'
                ? null
                : state.selectedCategoryId,
            authorId: state.selectedAuthorId,
          );

          state = state.copyWith(
            quotes: [...state.quotes, ...newQuotes.cast()],
            currentPage: nextPage,
            isLoadingMore: false,
            hasReachedEnd: newQuotes.isEmpty || newQuotes.length < _pageSize,
          );
        },
        operationType: OperationType.fetchQuotes,
        payload: {'page': nextPage},
        onQueued: () {
          state = state.copyWith(isLoadingMore: false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more quotes: $e',
      );
    }
  }

  Future<void> selectAuthor(String? authorId) async {
    if (state.selectedAuthorId == authorId) return;

    state = state.copyWith(
      selectedAuthorId: authorId,
      quotes: [],
      currentPage: 0,
      hasReachedEnd: false,
      isLoading: true,
    );

    try {
      final repository = ref.read(quoteRepositoryProvider);

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          final quotes = await repository.getQuotes(
            page: 0,
            pageSize: _pageSize,
            categoryId: state.selectedCategoryId == 'all'
                ? null
                : state.selectedCategoryId,
            authorId: authorId,
          );

          state = state.copyWith(
            quotes: quotes.cast(),
            isLoading: false,
            hasReachedEnd: quotes.length < _pageSize,
          );
        },
        operationType: OperationType.fetchQuotes,
        payload: {'authorId': authorId},
        onQueued: () {
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load author quotes: $e',
      );
    }
  }

  Future<void> selectCategory(String categoryId) async {
    if (state.selectedCategoryId == categoryId) return;

    // Update selected category
    final updatedCategories = state.categories.map((cat) {
      return cat.copyWith(isSelected: cat.id == categoryId);
    }).toList();

    state = state.copyWith(
      categories: updatedCategories,
      selectedCategoryId: categoryId,
      quotes: [],
      currentPage: 0,
      hasReachedEnd: false,
      isLoading: true,
    );

    try {
      final repository = ref.read(quoteRepositoryProvider);

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          final quotes = await repository.getQuotes(
            page: 0,
            pageSize: _pageSize,
            categoryId: categoryId == 'all' ? null : categoryId,
            authorId: state.selectedAuthorId,
          );

          state = state.copyWith(
            quotes: quotes.cast(),
            isLoading: false,
            hasReachedEnd: quotes.length < _pageSize,
          );
        },
        operationType: OperationType.fetchQuotes,
        payload: {'categoryId': categoryId},
        onQueued: () {
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load category quotes: $e',
      );
    }
  }

  Future<void> toggleFavorite(String quoteId) async {
    // Prevent concurrent toggling of the same quote
    if (_togglingFavorites.contains(quoteId)) {
      return;
    }

    _togglingFavorites.add(quoteId);

    // Check if this is the daily quote or a regular quote
    final isDailyQuote = state.dailyQuote?.id == quoteId;

    Quote currentQuote;
    if (isDailyQuote && state.dailyQuote != null) {
      currentQuote = state.dailyQuote!;
    } else {
      // Find in regular quotes list
      try {
        currentQuote = state.quotes.firstWhere(
          (q) => q.id == quoteId,
          orElse: () => throw Exception('Quote not found'),
        );
      } catch (e) {
        _togglingFavorites.remove(quoteId);
        return;
      }
    }

    // Optimistic update
    if (isDailyQuote) {
      // Update daily quote
      state = state.copyWith(
        dailyQuote: currentQuote.copyWith(
          isFavorite: !currentQuote.isFavorite,
          likesCount: currentQuote.isFavorite
              ? currentQuote.likesCount - 1
              : currentQuote.likesCount + 1,
        ),
      );
    } else {
      // Update in quotes list
      final optimisticQuotes = state.quotes.map((q) {
        if (q.id == quoteId) {
          return q.copyWith(
            isFavorite: !q.isFavorite,
            likesCount: q.isFavorite ? q.likesCount - 1 : q.likesCount + 1,
          );
        }
        return q;
      }).toList();
      state = state.copyWith(quotes: optimisticQuotes);
    }

    // Use offline-aware execution
    final success = await ref.offlineAware.executeWithOfflineHandling(
      operation: () async {
        final repository = ref.read(quoteRepositoryProvider);
        final updatedQuote = await repository.toggleFavorite(quoteId: quoteId);

        // Update with server response
        if (isDailyQuote) {
          state = state.copyWith(dailyQuote: updatedQuote);
        } else {
          final updatedQuotes = state.quotes.map((q) {
            return q.id == quoteId ? updatedQuote : q;
          }).toList();
          state = state.copyWith(quotes: updatedQuotes);
        }
      },
      operationType: OperationType.toggleFavorite,
      payload: {'quoteId': quoteId},
      operationId: 'toggle_favorite_$quoteId',
      onQueued: () {
        // Keep optimistic update - will sync when online
      },
    );

    if (!success) {
      // Operation was queued, optimistic update is kept
      _togglingFavorites.remove(quoteId);
      // Still invalidate collections to update favorites count
      ref.invalidate(collectionsControllerProvider);
      return;
    }

    _togglingFavorites.remove(quoteId);
    // Invalidate collections to update favorites count
    ref.invalidate(collectionsControllerProvider);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Load today's quote of the day
  Future<void> _loadDailyQuote() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);

      await ref.offlineAware.executeWithOfflineHandling(
        operation: () async {
          final dailyQuote = await repository.getDailyQuote();
          state = state.copyWith(
            dailyQuote: dailyQuote,
            isDailyQuoteLoading: false,
          );
        },
        operationType: OperationType.fetchDailyQuote,
        payload: {},
        onQueued: () {
          state = state.copyWith(isDailyQuoteLoading: false);
        },
      );
    } catch (e) {
      print('Error loading daily quote: $e');
      state = state.copyWith(isDailyQuoteLoading: false);
    }
  }
}
