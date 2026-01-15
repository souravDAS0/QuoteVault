import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/home_feed_state.dart';
import '../providers/quote_providers.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/author.dart';
import '../../domain/entities/quote.dart';

import '../../../../core/domain/entities/retryable_operation.dart';
import '../../../../core/mixins/offline_aware_mixin.dart';

part 'home_feed_controller.g.dart';

@riverpod
class HomeFeedController extends _$HomeFeedController {
  static const int _pageSize = 10;

  /// Track quotes currently being toggled to prevent race conditions
  final Set<String> _togglingFavorites = {};

  @override
  HomeFeedState build() {
    // Load initial data
    _loadInitialData();
    return const HomeFeedState(isLoading: true, isDailyQuoteLoading: true);
  }

  Future<void> _loadInitialData() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);

      // Load daily quote (non-blocking, scheduled after state init)
      Future.microtask(() => _loadDailyQuote());

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
      final allCategory = Category(id: 'all', name: 'All', isSelected: true);
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
      try {
        quotes = await repository.getQuotes(page: 0, pageSize: _pageSize);
        print('Loaded ${quotes.length} quotes');
      } catch (e) {
        print('Failed to load quotes: $e');
        rethrow; // Rethrow quote errors as they are critical
      }

      state = state.copyWith(
        categories: categories,
        authors: authors,
        quotes: quotes.cast(),
        isLoading: false,
        hasReachedEnd: quotes.length < _pageSize,
      );
    } catch (e) {
      print('Error in _loadInitialData: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load feed: $e',
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

      List<dynamic> newQuotes;

      newQuotes = await repository.getQuotes(
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
        hasReachedEnd: newQuotes.length < _pageSize,
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

      List<dynamic> quotes;

      quotes = await repository.getQuotes(
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
      return;
    }

    _togglingFavorites.remove(quoteId);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Load today's quote of the day
  Future<void> _loadDailyQuote() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);
      final dailyQuote = await repository.getDailyQuote();

      state = state.copyWith(
        dailyQuote: dailyQuote,
        isDailyQuoteLoading: false,
      );
    } catch (e) {
      print('Error loading daily quote: $e');
      state = state.copyWith(isDailyQuoteLoading: false);
    }
  }
}
