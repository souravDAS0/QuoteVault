import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/collection.dart';

part 'collections_state.freezed.dart';

/// Sorting options for collections
enum CollectionSortBy {
  name,
  dateCreated,
  quoteCount,
}

/// State for the My Collections screen
@freezed
abstract class CollectionsState with _$CollectionsState {
  const factory CollectionsState({
    @Default([]) List<Collection> collections,
    @Default(0) int favoritesCount,
    @Default(false) bool isLoading,
    @Default(false) bool isCreating,
    @Default(false) bool isDeleting,
    @Default(CollectionSortBy.dateCreated) CollectionSortBy sortBy,
    String? errorMessage,
  }) = _CollectionsState;
}
