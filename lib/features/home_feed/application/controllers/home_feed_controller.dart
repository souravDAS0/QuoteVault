import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/home_feed_state.dart';
import '../providers/quote_providers.dart';
import '../../domain/entities/category.dart';

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
    return const HomeFeedState(isLoading: true);
  }

  Future<void> _loadInitialData() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);

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

    // Find the current quote to get its state
    final currentQuote = state.quotes.firstWhere(
      (q) => q.id == quoteId,
      orElse: () => throw Exception('Quote not found'),
    );

    // Optimistic update - toggle immediately in UI
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

    try {
      final repository = ref.read(quoteRepositoryProvider);
      final updatedQuote = await repository.toggleFavorite(quoteId: quoteId);

      // Update with server response
      final updatedQuotes = state.quotes.map((q) {
        return q.id == quoteId ? updatedQuote : q;
      }).toList();

      state = state.copyWith(quotes: updatedQuotes);
    } catch (e) {
      // Revert optimistic update on error
      final revertedQuotes = state.quotes.map((q) {
        return q.id == quoteId ? currentQuote : q;
      }).toList();

      state = state.copyWith(
        quotes: revertedQuotes,
        errorMessage: 'Failed to update favorite: $e',
      );
    } finally {
      _togglingFavorites.remove(quoteId);
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
