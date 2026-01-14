// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeFeedState {

 List<Quote> get quotes; List<Category> get categories; List<Author> get authors; bool get isLoading; bool get isLoadingMore; bool get hasReachedEnd; int get currentPage; String? get selectedCategoryId; String? get selectedAuthorId; String? get errorMessage;
/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedStateCopyWith<HomeFeedState> get copyWith => _$HomeFeedStateCopyWithImpl<HomeFeedState>(this as HomeFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeedState&&const DeepCollectionEquality().equals(other.quotes, quotes)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.authors, authors)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedAuthorId, selectedAuthorId) || other.selectedAuthorId == selectedAuthorId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(quotes),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(authors),isLoading,isLoadingMore,hasReachedEnd,currentPage,selectedCategoryId,selectedAuthorId,errorMessage);

@override
String toString() {
  return 'HomeFeedState(quotes: $quotes, categories: $categories, authors: $authors, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, selectedCategoryId: $selectedCategoryId, selectedAuthorId: $selectedAuthorId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $HomeFeedStateCopyWith<$Res>  {
  factory $HomeFeedStateCopyWith(HomeFeedState value, $Res Function(HomeFeedState) _then) = _$HomeFeedStateCopyWithImpl;
@useResult
$Res call({
 List<Quote> quotes, List<Category> categories, List<Author> authors, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? selectedCategoryId, String? selectedAuthorId, String? errorMessage
});




}
/// @nodoc
class _$HomeFeedStateCopyWithImpl<$Res>
    implements $HomeFeedStateCopyWith<$Res> {
  _$HomeFeedStateCopyWithImpl(this._self, this._then);

  final HomeFeedState _self;
  final $Res Function(HomeFeedState) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quotes = null,Object? categories = null,Object? authors = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? selectedCategoryId = freezed,Object? selectedAuthorId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<Author>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,selectedAuthorId: freezed == selectedAuthorId ? _self.selectedAuthorId : selectedAuthorId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeFeedState].
extension HomeFeedStatePatterns on HomeFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeFeedState value)  $default,){
final _that = this;
switch (_that) {
case _HomeFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Quote> quotes,  List<Category> categories,  List<Author> authors,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedCategoryId,  String? selectedAuthorId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeFeedState() when $default != null:
return $default(_that.quotes,_that.categories,_that.authors,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedCategoryId,_that.selectedAuthorId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Quote> quotes,  List<Category> categories,  List<Author> authors,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedCategoryId,  String? selectedAuthorId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HomeFeedState():
return $default(_that.quotes,_that.categories,_that.authors,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedCategoryId,_that.selectedAuthorId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Quote> quotes,  List<Category> categories,  List<Author> authors,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? selectedCategoryId,  String? selectedAuthorId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HomeFeedState() when $default != null:
return $default(_that.quotes,_that.categories,_that.authors,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.selectedCategoryId,_that.selectedAuthorId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeFeedState implements HomeFeedState {
  const _HomeFeedState({final  List<Quote> quotes = const [], final  List<Category> categories = const [], final  List<Author> authors = const [], this.isLoading = false, this.isLoadingMore = false, this.hasReachedEnd = false, this.currentPage = 0, this.selectedCategoryId, this.selectedAuthorId, this.errorMessage}): _quotes = quotes,_categories = categories,_authors = authors;
  

 final  List<Quote> _quotes;
@override@JsonKey() List<Quote> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}

 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Author> _authors;
@override@JsonKey() List<Author> get authors {
  if (_authors is EqualUnmodifiableListView) return _authors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authors);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasReachedEnd;
@override@JsonKey() final  int currentPage;
@override final  String? selectedCategoryId;
@override final  String? selectedAuthorId;
@override final  String? errorMessage;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeFeedStateCopyWith<_HomeFeedState> get copyWith => __$HomeFeedStateCopyWithImpl<_HomeFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeFeedState&&const DeepCollectionEquality().equals(other._quotes, _quotes)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._authors, _authors)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedAuthorId, selectedAuthorId) || other.selectedAuthorId == selectedAuthorId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_quotes),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_authors),isLoading,isLoadingMore,hasReachedEnd,currentPage,selectedCategoryId,selectedAuthorId,errorMessage);

@override
String toString() {
  return 'HomeFeedState(quotes: $quotes, categories: $categories, authors: $authors, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, selectedCategoryId: $selectedCategoryId, selectedAuthorId: $selectedAuthorId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeFeedStateCopyWith<$Res> implements $HomeFeedStateCopyWith<$Res> {
  factory _$HomeFeedStateCopyWith(_HomeFeedState value, $Res Function(_HomeFeedState) _then) = __$HomeFeedStateCopyWithImpl;
@override @useResult
$Res call({
 List<Quote> quotes, List<Category> categories, List<Author> authors, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? selectedCategoryId, String? selectedAuthorId, String? errorMessage
});




}
/// @nodoc
class __$HomeFeedStateCopyWithImpl<$Res>
    implements _$HomeFeedStateCopyWith<$Res> {
  __$HomeFeedStateCopyWithImpl(this._self, this._then);

  final _HomeFeedState _self;
  final $Res Function(_HomeFeedState) _then;

/// Create a copy of HomeFeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quotes = null,Object? categories = null,Object? authors = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? selectedCategoryId = freezed,Object? selectedAuthorId = freezed,Object? errorMessage = freezed,}) {
  return _then(_HomeFeedState(
quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,authors: null == authors ? _self._authors : authors // ignore: cast_nullable_to_non_nullable
as List<Author>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,selectedAuthorId: freezed == selectedAuthorId ? _self.selectedAuthorId : selectedAuthorId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
