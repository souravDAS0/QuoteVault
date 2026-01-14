// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collections_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollectionsState {

 List<Collection> get collections; int get favoritesCount; bool get isLoading; bool get isCreating; bool get isDeleting; CollectionSortBy get sortBy; String? get errorMessage;
/// Create a copy of CollectionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionsStateCopyWith<CollectionsState> get copyWith => _$CollectionsStateCopyWithImpl<CollectionsState>(this as CollectionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionsState&&const DeepCollectionEquality().equals(other.collections, collections)&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(collections),favoritesCount,isLoading,isCreating,isDeleting,sortBy,errorMessage);

@override
String toString() {
  return 'CollectionsState(collections: $collections, favoritesCount: $favoritesCount, isLoading: $isLoading, isCreating: $isCreating, isDeleting: $isDeleting, sortBy: $sortBy, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CollectionsStateCopyWith<$Res>  {
  factory $CollectionsStateCopyWith(CollectionsState value, $Res Function(CollectionsState) _then) = _$CollectionsStateCopyWithImpl;
@useResult
$Res call({
 List<Collection> collections, int favoritesCount, bool isLoading, bool isCreating, bool isDeleting, CollectionSortBy sortBy, String? errorMessage
});




}
/// @nodoc
class _$CollectionsStateCopyWithImpl<$Res>
    implements $CollectionsStateCopyWith<$Res> {
  _$CollectionsStateCopyWithImpl(this._self, this._then);

  final CollectionsState _self;
  final $Res Function(CollectionsState) _then;

/// Create a copy of CollectionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collections = null,Object? favoritesCount = null,Object? isLoading = null,Object? isCreating = null,Object? isDeleting = null,Object? sortBy = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
collections: null == collections ? _self.collections : collections // ignore: cast_nullable_to_non_nullable
as List<Collection>,favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as CollectionSortBy,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionsState].
extension CollectionsStatePatterns on CollectionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionsState value)  $default,){
final _that = this;
switch (_that) {
case _CollectionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionsState value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Collection> collections,  int favoritesCount,  bool isLoading,  bool isCreating,  bool isDeleting,  CollectionSortBy sortBy,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionsState() when $default != null:
return $default(_that.collections,_that.favoritesCount,_that.isLoading,_that.isCreating,_that.isDeleting,_that.sortBy,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Collection> collections,  int favoritesCount,  bool isLoading,  bool isCreating,  bool isDeleting,  CollectionSortBy sortBy,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CollectionsState():
return $default(_that.collections,_that.favoritesCount,_that.isLoading,_that.isCreating,_that.isDeleting,_that.sortBy,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Collection> collections,  int favoritesCount,  bool isLoading,  bool isCreating,  bool isDeleting,  CollectionSortBy sortBy,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CollectionsState() when $default != null:
return $default(_that.collections,_that.favoritesCount,_that.isLoading,_that.isCreating,_that.isDeleting,_that.sortBy,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CollectionsState implements CollectionsState {
  const _CollectionsState({final  List<Collection> collections = const [], this.favoritesCount = 0, this.isLoading = false, this.isCreating = false, this.isDeleting = false, this.sortBy = CollectionSortBy.dateCreated, this.errorMessage}): _collections = collections;
  

 final  List<Collection> _collections;
@override@JsonKey() List<Collection> get collections {
  if (_collections is EqualUnmodifiableListView) return _collections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collections);
}

@override@JsonKey() final  int favoritesCount;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool isDeleting;
@override@JsonKey() final  CollectionSortBy sortBy;
@override final  String? errorMessage;

/// Create a copy of CollectionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionsStateCopyWith<_CollectionsState> get copyWith => __$CollectionsStateCopyWithImpl<_CollectionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionsState&&const DeepCollectionEquality().equals(other._collections, _collections)&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_collections),favoritesCount,isLoading,isCreating,isDeleting,sortBy,errorMessage);

@override
String toString() {
  return 'CollectionsState(collections: $collections, favoritesCount: $favoritesCount, isLoading: $isLoading, isCreating: $isCreating, isDeleting: $isDeleting, sortBy: $sortBy, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CollectionsStateCopyWith<$Res> implements $CollectionsStateCopyWith<$Res> {
  factory _$CollectionsStateCopyWith(_CollectionsState value, $Res Function(_CollectionsState) _then) = __$CollectionsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Collection> collections, int favoritesCount, bool isLoading, bool isCreating, bool isDeleting, CollectionSortBy sortBy, String? errorMessage
});




}
/// @nodoc
class __$CollectionsStateCopyWithImpl<$Res>
    implements _$CollectionsStateCopyWith<$Res> {
  __$CollectionsStateCopyWithImpl(this._self, this._then);

  final _CollectionsState _self;
  final $Res Function(_CollectionsState) _then;

/// Create a copy of CollectionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collections = null,Object? favoritesCount = null,Object? isLoading = null,Object? isCreating = null,Object? isDeleting = null,Object? sortBy = null,Object? errorMessage = freezed,}) {
  return _then(_CollectionsState(
collections: null == collections ? _self._collections : collections // ignore: cast_nullable_to_non_nullable
as List<Collection>,favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as CollectionSortBy,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
