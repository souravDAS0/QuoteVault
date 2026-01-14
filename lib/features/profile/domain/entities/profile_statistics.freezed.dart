// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileStatistics {

 int get favoritesCount; int get collectionsCount;
/// Create a copy of ProfileStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStatisticsCopyWith<ProfileStatistics> get copyWith => _$ProfileStatisticsCopyWithImpl<ProfileStatistics>(this as ProfileStatistics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStatistics&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.collectionsCount, collectionsCount) || other.collectionsCount == collectionsCount));
}


@override
int get hashCode => Object.hash(runtimeType,favoritesCount,collectionsCount);

@override
String toString() {
  return 'ProfileStatistics(favoritesCount: $favoritesCount, collectionsCount: $collectionsCount)';
}


}

/// @nodoc
abstract mixin class $ProfileStatisticsCopyWith<$Res>  {
  factory $ProfileStatisticsCopyWith(ProfileStatistics value, $Res Function(ProfileStatistics) _then) = _$ProfileStatisticsCopyWithImpl;
@useResult
$Res call({
 int favoritesCount, int collectionsCount
});




}
/// @nodoc
class _$ProfileStatisticsCopyWithImpl<$Res>
    implements $ProfileStatisticsCopyWith<$Res> {
  _$ProfileStatisticsCopyWithImpl(this._self, this._then);

  final ProfileStatistics _self;
  final $Res Function(ProfileStatistics) _then;

/// Create a copy of ProfileStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoritesCount = null,Object? collectionsCount = null,}) {
  return _then(_self.copyWith(
favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,collectionsCount: null == collectionsCount ? _self.collectionsCount : collectionsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileStatistics].
extension ProfileStatisticsPatterns on ProfileStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileStatistics value)  $default,){
final _that = this;
switch (_that) {
case _ProfileStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int favoritesCount,  int collectionsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileStatistics() when $default != null:
return $default(_that.favoritesCount,_that.collectionsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int favoritesCount,  int collectionsCount)  $default,) {final _that = this;
switch (_that) {
case _ProfileStatistics():
return $default(_that.favoritesCount,_that.collectionsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int favoritesCount,  int collectionsCount)?  $default,) {final _that = this;
switch (_that) {
case _ProfileStatistics() when $default != null:
return $default(_that.favoritesCount,_that.collectionsCount);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileStatistics implements ProfileStatistics {
  const _ProfileStatistics({required this.favoritesCount, required this.collectionsCount});
  

@override final  int favoritesCount;
@override final  int collectionsCount;

/// Create a copy of ProfileStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStatisticsCopyWith<_ProfileStatistics> get copyWith => __$ProfileStatisticsCopyWithImpl<_ProfileStatistics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileStatistics&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.collectionsCount, collectionsCount) || other.collectionsCount == collectionsCount));
}


@override
int get hashCode => Object.hash(runtimeType,favoritesCount,collectionsCount);

@override
String toString() {
  return 'ProfileStatistics(favoritesCount: $favoritesCount, collectionsCount: $collectionsCount)';
}


}

/// @nodoc
abstract mixin class _$ProfileStatisticsCopyWith<$Res> implements $ProfileStatisticsCopyWith<$Res> {
  factory _$ProfileStatisticsCopyWith(_ProfileStatistics value, $Res Function(_ProfileStatistics) _then) = __$ProfileStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int favoritesCount, int collectionsCount
});




}
/// @nodoc
class __$ProfileStatisticsCopyWithImpl<$Res>
    implements _$ProfileStatisticsCopyWith<$Res> {
  __$ProfileStatisticsCopyWithImpl(this._self, this._then);

  final _ProfileStatistics _self;
  final $Res Function(_ProfileStatistics) _then;

/// Create a copy of ProfileStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoritesCount = null,Object? collectionsCount = null,}) {
  return _then(_ProfileStatistics(
favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,collectionsCount: null == collectionsCount ? _self.collectionsCount : collectionsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
