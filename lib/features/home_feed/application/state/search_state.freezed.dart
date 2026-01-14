// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 String get query; List<Quote> get results; List<Author> get authors; int get totalResults; bool get isLoading; bool get isLoadingMore; bool get hasReachedEnd; int get currentPage; String? get selectedAuthorId; String? get selectedCategoryId; SearchFilterType? get activeFilter; String? get sortBy; String? get errorMessage;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.authors, authors)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.selectedAuthorId, selectedAuthorId) || other.selectedAuthorId == selectedAuthorId)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(authors),totalResults,isLoading,isLoadingMore,hasReachedEnd,currentPage,selectedAuthorId,selectedCategoryId,activeFilter,sortBy,errorMessage);

@override
String toString() {
  return 'SearchState(query: $query, results: $results, authors: $authors, totalResults: $totalResults, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, selectedAuthorId: $selectedAuthorId, selectedCategoryId: $selectedCategoryId, activeFilter: $activeFilter, sortBy: $sortBy, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 String query, List<Quote> results, List<Author> authors, int totalResults, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? selectedAuthorId, String? selectedCategoryId, SearchFilterType? activeFilter, String? sortBy, String? errorMessage
});




}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? results = null,Object? authors = null,Object? totalResults = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? selectedAuthorId = freezed,Object? selectedCategoryId = freezed,Object? activeFilter = freezed,Object? sortBy = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Quote>,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<Author>,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,selectedAuthorId: freezed == selectedAuthorId ? _self.selectedAuthorId : selectedAuthorId // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as SearchFilterType?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<Quote> results,  List<Author> authors,  int totalResults,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedAuthorId,  String? selectedCategoryId,  SearchFilterType? activeFilter,  String? sortBy,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.query,_that.results,_that.authors,_that.totalResults,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedAuthorId,_that.selectedCategoryId,_that.activeFilter,_that.sortBy,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<Quote> results,  List<Author> authors,  int totalResults,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedAuthorId,  String? selectedCategoryId,  SearchFilterType? activeFilter,  String? sortBy,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.query,_that.results,_that.authors,_that.totalResults,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedAuthorId,_that.selectedCategoryId,_that.activeFilter,_that.sortBy,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<Quote> results,  List<Author> authors,  int totalResults,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedAuthorId,  String? selectedCategoryId,  SearchFilterType? activeFilter,  String? sortBy,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.query,_that.results,_that.authors,_that.totalResults,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedAuthorId,_that.selectedCategoryId,_that.activeFilter,_that.sortBy,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.query = '', final  List<Quote> results = const [], final  List<Author> authors = const [], this.totalResults = 0, this.isLoading = false, this.isLoadingMore = false, this.hasReachedEnd = false, this.currentPage = 0, this.selectedAuthorId, this.selectedCategoryId, this.activeFilter, this.sortBy, this.errorMessage}): _results = results,_authors = authors;
  

@override@JsonKey() final  String query;
 final  List<Quote> _results;
@override@JsonKey() List<Quote> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<Author> _authors;
@override@JsonKey() List<Author> get authors {
  if (_authors is EqualUnmodifiableListView) return _authors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authors);
}

@override@JsonKey() final  int totalResults;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasReachedEnd;
@override@JsonKey() final  int currentPage;
@override final  String? selectedAuthorId;
@override final  String? selectedCategoryId;
@override final  SearchFilterType? activeFilter;
@override final  String? sortBy;
@override final  String? errorMessage;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._authors, _authors)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.selectedAuthorId, selectedAuthorId) || other.selectedAuthorId == selectedAuthorId)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_authors),totalResults,isLoading,isLoadingMore,hasReachedEnd,currentPage,selectedAuthorId,selectedCategoryId,activeFilter,sortBy,errorMessage);

@override
String toString() {
  return 'SearchState(query: $query, results: $results, authors: $authors, totalResults: $totalResults, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, selectedAuthorId: $selectedAuthorId, selectedCategoryId: $selectedCategoryId, activeFilter: $activeFilter, sortBy: $sortBy, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, List<Quote> results, List<Author> authors, int totalResults, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? selectedAuthorId, String? selectedCategoryId, SearchFilterType? activeFilter, String? sortBy, String? errorMessage
});




}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? results = null,Object? authors = null,Object? totalResults = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? selectedAuthorId = freezed,Object? selectedCategoryId = freezed,Object? activeFilter = freezed,Object? sortBy = freezed,Object? errorMessage = freezed,}) {
  return _then(_SearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Quote>,authors: null == authors ? _self._authors : authors // ignore: cast_nullable_to_non_nullable
as List<Author>,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,selectedAuthorId: freezed == selectedAuthorId ? _self.selectedAuthorId : selectedAuthorId // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as SearchFilterType?,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
