import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/collection.dart';
import '../../../home_feed/domain/entities/quote.dart';

part 'collection_details_state.freezed.dart';

/// State for the Collection Details screen
@freezed
abstract class CollectionDetailsState with _$CollectionDetailsState {
  const factory CollectionDetailsState({
    Collection? collection,
    @Default([]) List<Quote> quotes,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isAddingQuote,
    @Default(false) bool isRemovingQuote,
    @Default(false) bool isEditingName,
    @Default(false) bool hasReachedEnd,
    @Default(0) int currentPage,
    String? errorMessage,
  }) = _CollectionDetailsState;
}

/// State for the Favorites screen
@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default([]) List<Quote> quotes,
    @Default(0) int totalCount,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    @Default(0) int currentPage,
    String? errorMessage,
  }) = _FavoritesState;
}
