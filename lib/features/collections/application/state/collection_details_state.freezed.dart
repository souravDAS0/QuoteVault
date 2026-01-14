// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollectionDetailsState {

 Collection? get collection; List<Quote> get quotes; bool get isLoading; bool get isLoadingMore; bool get isAddingQuote; bool get isRemovingQuote; bool get isEditingName; bool get hasReachedEnd; int get currentPage; String? get errorMessage;
/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionDetailsStateCopyWith<CollectionDetailsState> get copyWith => _$CollectionDetailsStateCopyWithImpl<CollectionDetailsState>(this as CollectionDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionDetailsState&&(identical(other.collection, collection) || other.collection == collection)&&const DeepCollectionEquality().equals(other.quotes, quotes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isAddingQuote, isAddingQuote) || other.isAddingQuote == isAddingQuote)&&(identical(other.isRemovingQuote, isRemovingQuote) || other.isRemovingQuote == isRemovingQuote)&&(identical(other.isEditingName, isEditingName) || other.isEditingName == isEditingName)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,collection,const DeepCollectionEquality().hash(quotes),isLoading,isLoadingMore,isAddingQuote,isRemovingQuote,isEditingName,hasReachedEnd,currentPage,errorMessage);

@override
String toString() {
  return 'CollectionDetailsState(collection: $collection, quotes: $quotes, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isAddingQuote: $isAddingQuote, isRemovingQuote: $isRemovingQuote, isEditingName: $isEditingName, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CollectionDetailsStateCopyWith<$Res>  {
  factory $CollectionDetailsStateCopyWith(CollectionDetailsState value, $Res Function(CollectionDetailsState) _then) = _$CollectionDetailsStateCopyWithImpl;
@useResult
$Res call({
 Collection? collection, List<Quote> quotes, bool isLoading, bool isLoadingMore, bool isAddingQuote, bool isRemovingQuote, bool isEditingName, bool hasReachedEnd, int currentPage, String? errorMessage
});


$CollectionCopyWith<$Res>? get collection;

}
/// @nodoc
class _$CollectionDetailsStateCopyWithImpl<$Res>
    implements $CollectionDetailsStateCopyWith<$Res> {
  _$CollectionDetailsStateCopyWithImpl(this._self, this._then);

  final CollectionDetailsState _self;
  final $Res Function(CollectionDetailsState) _then;

/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collection = freezed,Object? quotes = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isAddingQuote = null,Object? isRemovingQuote = null,Object? isEditingName = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Collection?,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isAddingQuote: null == isAddingQuote ? _self.isAddingQuote : isAddingQuote // ignore: cast_nullable_to_non_nullable
as bool,isRemovingQuote: null == isRemovingQuote ? _self.isRemovingQuote : isRemovingQuote // ignore: cast_nullable_to_non_nullable
as bool,isEditingName: null == isEditingName ? _self.isEditingName : isEditingName // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionCopyWith<$Res>? get collection {
    if (_self.collection == null) {
    return null;
  }

  return $CollectionCopyWith<$Res>(_self.collection!, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}


/// Adds pattern-matching-related methods to [CollectionDetailsState].
extension CollectionDetailsStatePatterns on CollectionDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _CollectionDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Collection? collection,  List<Quote> quotes,  bool isLoading,  bool isLoadingMore,  bool isAddingQuote,  bool isRemovingQuote,  bool isEditingName,  bool hasReachedEnd,  int currentPage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionDetailsState() when $default != null:
return $default(_that.collection,_that.quotes,_that.isLoading,_that.isLoadingMore,_that.isAddingQuote,_that.isRemovingQuote,_that.isEditingName,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Collection? collection,  List<Quote> quotes,  bool isLoading,  bool isLoadingMore,  bool isAddingQuote,  bool isRemovingQuote,  bool isEditingName,  bool hasReachedEnd,  int currentPage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CollectionDetailsState():
return $default(_that.collection,_that.quotes,_that.isLoading,_that.isLoadingMore,_that.isAddingQuote,_that.isRemovingQuote,_that.isEditingName,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Collection? collection,  List<Quote> quotes,  bool isLoading,  bool isLoadingMore,  bool isAddingQuote,  bool isRemovingQuote,  bool isEditingName,  bool hasReachedEnd,  int currentPage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CollectionDetailsState() when $default != null:
return $default(_that.collection,_that.quotes,_that.isLoading,_that.isLoadingMore,_that.isAddingQuote,_that.isRemovingQuote,_that.isEditingName,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CollectionDetailsState implements CollectionDetailsState {
  const _CollectionDetailsState({this.collection, final  List<Quote> quotes = const [], this.isLoading = false, this.isLoadingMore = false, this.isAddingQuote = false, this.isRemovingQuote = false, this.isEditingName = false, this.hasReachedEnd = false, this.currentPage = 0, this.errorMessage}): _quotes = quotes;
  

@override final  Collection? collection;
 final  List<Quote> _quotes;
@override@JsonKey() List<Quote> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isAddingQuote;
@override@JsonKey() final  bool isRemovingQuote;
@override@JsonKey() final  bool isEditingName;
@override@JsonKey() final  bool hasReachedEnd;
@override@JsonKey() final  int currentPage;
@override final  String? errorMessage;

/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionDetailsStateCopyWith<_CollectionDetailsState> get copyWith => __$CollectionDetailsStateCopyWithImpl<_CollectionDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionDetailsState&&(identical(other.collection, collection) || other.collection == collection)&&const DeepCollectionEquality().equals(other._quotes, _quotes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isAddingQuote, isAddingQuote) || other.isAddingQuote == isAddingQuote)&&(identical(other.isRemovingQuote, isRemovingQuote) || other.isRemovingQuote == isRemovingQuote)&&(identical(other.isEditingName, isEditingName) || other.isEditingName == isEditingName)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,collection,const DeepCollectionEquality().hash(_quotes),isLoading,isLoadingMore,isAddingQuote,isRemovingQuote,isEditingName,hasReachedEnd,currentPage,errorMessage);

@override
String toString() {
  return 'CollectionDetailsState(collection: $collection, quotes: $quotes, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isAddingQuote: $isAddingQuote, isRemovingQuote: $isRemovingQuote, isEditingName: $isEditingName, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CollectionDetailsStateCopyWith<$Res> implements $CollectionDetailsStateCopyWith<$Res> {
  factory _$CollectionDetailsStateCopyWith(_CollectionDetailsState value, $Res Function(_CollectionDetailsState) _then) = __$CollectionDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 Collection? collection, List<Quote> quotes, bool isLoading, bool isLoadingMore, bool isAddingQuote, bool isRemovingQuote, bool isEditingName, bool hasReachedEnd, int currentPage, String? errorMessage
});


@override $CollectionCopyWith<$Res>? get collection;

}
/// @nodoc
class __$CollectionDetailsStateCopyWithImpl<$Res>
    implements _$CollectionDetailsStateCopyWith<$Res> {
  __$CollectionDetailsStateCopyWithImpl(this._self, this._then);

  final _CollectionDetailsState _self;
  final $Res Function(_CollectionDetailsState) _then;

/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collection = freezed,Object? quotes = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isAddingQuote = null,Object? isRemovingQuote = null,Object? isEditingName = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? errorMessage = freezed,}) {
  return _then(_CollectionDetailsState(
collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Collection?,quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isAddingQuote: null == isAddingQuote ? _self.isAddingQuote : isAddingQuote // ignore: cast_nullable_to_non_nullable
as bool,isRemovingQuote: null == isRemovingQuote ? _self.isRemovingQuote : isRemovingQuote // ignore: cast_nullable_to_non_nullable
as bool,isEditingName: null == isEditingName ? _self.isEditingName : isEditingName // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CollectionDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionCopyWith<$Res>? get collection {
    if (_self.collection == null) {
    return null;
  }

  return $CollectionCopyWith<$Res>(_self.collection!, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}

/// @nodoc
mixin _$FavoritesState {

 List<Quote> get quotes; int get totalCount; bool get isLoading; bool get isLoadingMore; bool get hasReachedEnd; int get currentPage; String? get errorMessage;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&const DeepCollectionEquality().equals(other.quotes, quotes)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(quotes),totalCount,isLoading,isLoadingMore,hasReachedEnd,currentPage,errorMessage);

@override
String toString() {
  return 'FavoritesState(quotes: $quotes, totalCount: $totalCount, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 List<Quote> quotes, int totalCount, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? errorMessage
});




}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quotes = null,Object? totalCount = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesState value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Quote> quotes,  int totalCount,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.quotes,_that.totalCount,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Quote> quotes,  int totalCount,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _FavoritesState():
return $default(_that.quotes,_that.totalCount,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Quote> quotes,  int totalCount,  bool isLoading,  bool isLoadingMore,  bool hasReachedEnd,  int currentPage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.quotes,_that.totalCount,_that.isLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.currentPage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FavoritesState implements FavoritesState {
  const _FavoritesState({final  List<Quote> quotes = const [], this.totalCount = 0, this.isLoading = false, this.isLoadingMore = false, this.hasReachedEnd = false, this.currentPage = 0, this.errorMessage}): _quotes = quotes;
  

 final  List<Quote> _quotes;
@override@JsonKey() List<Quote> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasReachedEnd;
@override@JsonKey() final  int currentPage;
@override final  String? errorMessage;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&const DeepCollectionEquality().equals(other._quotes, _quotes)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_quotes),totalCount,isLoading,isLoadingMore,hasReachedEnd,currentPage,errorMessage);

@override
String toString() {
  return 'FavoritesState(quotes: $quotes, totalCount: $totalCount, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Quote> quotes, int totalCount, bool isLoading, bool isLoadingMore, bool hasReachedEnd, int currentPage, String? errorMessage
});




}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quotes = null,Object? totalCount = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? errorMessage = freezed,}) {
  return _then(_FavoritesState(
quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
