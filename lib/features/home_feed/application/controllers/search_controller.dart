import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/search_state.dart';
import '../providers/quote_providers.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  static const int _pageSize = 10;

  @override
  SearchState build() {
    return const SearchState();
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
        repository.searchQuotes(query: query, page: 0, pageSize: _pageSize),
        repository.getSearchResultsCount(query: query),
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

  void clearFilters() {
    if (state.query.isNotEmpty) {
      search(state.query);
    }
  }

  void clearSearch() {
    state = const SearchState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
