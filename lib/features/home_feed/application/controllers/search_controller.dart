import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/search_state.dart';
import '../providers/quote_providers.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  static const int _pageSize = 10;

  @override
  SearchState build() {
    _loadAuthors();
    return const SearchState();
  }

  Future<void> _loadAuthors() async {
    try {
      final repository = ref.read(quoteRepositoryProvider);
      final authors = await repository.getAuthors();
      state = state.copyWith(authors: authors);
    } catch (e) {
      // Silently fail, authors list will be empty
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(
        query: '',
        results: [],
        totalResults: 0,
        currentPage: 0,
        hasReachedEnd: true,
      );
      return;
    }

    state = state.copyWith(
      query: query,
      isLoading: true,
      results: [],
      currentPage: 0,
      hasReachedEnd: false,
      errorMessage: null,
    );

    try {
      final repository = ref.read(quoteRepositoryProvider);

      final results = await Future.wait([
        repository.searchQuotes(
          query: query,
          page: 0,
          pageSize: _pageSize,
          authorId: state.selectedAuthorId,
          categoryId: state.selectedCategoryId,
          sortBy: state.sortBy,
        ),
        repository.getSearchResultsCount(
          query: query,
          authorId: state.selectedAuthorId,
          categoryId: state.selectedCategoryId,
        ),
      ]);

      final quotes = results[0] as List<dynamic>;
      final count = results[1] as int;

      state = state.copyWith(
        results: quotes.cast(),
        totalResults: count,
        isLoading: false,
        hasReachedEnd: quotes.length < _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Search failed: $e',
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd || state.query.isEmpty) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    try {
      final repository = ref.read(quoteRepositoryProvider);
      final nextPage = state.currentPage + 1;

      final quotes = await repository.searchQuotes(
        query: state.query,
        page: nextPage,
        pageSize: _pageSize,
        authorId: state.selectedAuthorId,
        categoryId: state.selectedCategoryId,
        sortBy: state.sortBy,
      );

      state = state.copyWith(
        results: [...state.results, ...quotes],
        currentPage: nextPage,
        isLoadingMore: false,
        hasReachedEnd: quotes.length < _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more results: $e',
      );
    }
  }

  void setActiveFilter(SearchFilterType? filter) {
    state = state.copyWith(activeFilter: filter);
  }

  Future<void> setAuthorFilter(String? authorId) async {
    state = state.copyWith(
      selectedAuthorId: authorId,
      activeFilter: null,
    );

    if (state.query.isNotEmpty) {
      await search(state.query);
    }
  }

  Future<void> setCategoryFilter(String? categoryId) async {
    state = state.copyWith(
      selectedCategoryId: categoryId,
      activeFilter: null,
    );

    if (state.query.isNotEmpty) {
      await search(state.query);
    }
  }

  Future<void> setSortBy(String? sortBy) async {
    state = state.copyWith(
      sortBy: sortBy,
      activeFilter: null,
    );

    if (state.query.isNotEmpty) {
      await search(state.query);
    }
  }

  void clearFilters() {
    state = state.copyWith(
      selectedAuthorId: null,
      selectedCategoryId: null,
      sortBy: null,
      activeFilter: null,
    );

    if (state.query.isNotEmpty) {
      search(state.query);
    }
  }

  void clearSearch() {
    state = const SearchState();
    _loadAuthors();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
