import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/author.dart';

part 'search_state.freezed.dart';

enum SearchFilterType {
  author,
  category,
  popularity,
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String query,
    @Default([]) List<Quote> results,
    @Default([]) List<Author> authors,
    @Default(0) int totalResults,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    @Default(0) int currentPage,
    String? selectedAuthorId,
    String? selectedCategoryId,
    SearchFilterType? activeFilter,
    String? sortBy,
    String? errorMessage,
  }) = _SearchState;
}
