import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quote.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String query,
    @Default([]) List<Quote> results,
    @Default(0) int totalResults,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    @Default(0) int currentPage,
    String? errorMessage,
  }) = _SearchState;
}
