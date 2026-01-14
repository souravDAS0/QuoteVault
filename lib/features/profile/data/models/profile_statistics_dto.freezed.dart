// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_statistics_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileStatisticsDto {

 int get favoritesCount; int get collectionsCount;
/// Create a copy of ProfileStatisticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStatisticsDtoCopyWith<ProfileStatisticsDto> get copyWith => _$ProfileStatisticsDtoCopyWithImpl<ProfileStatisticsDto>(this as ProfileStatisticsDto, _$identity);

  /// Serializes this ProfileStatisticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStatisticsDto&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.collectionsCount, collectionsCount) || other.collectionsCount == collectionsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favoritesCount,collectionsCount);

@override
String toString() {
  return 'ProfileStatisticsDto(favoritesCount: $favoritesCount, collectionsCount: $collectionsCount)';
}


}

/// @nodoc
abstract mixin class $ProfileStatisticsDtoCopyWith<$Res>  {
  factory $ProfileStatisticsDtoCopyWith(ProfileStatisticsDto value, $Res Function(ProfileStatisticsDto) _then) = _$ProfileStatisticsDtoCopyWithImpl;
@useResult
$Res call({
 int favoritesCount, int collectionsCount
});




}
/// @nodoc
class _$ProfileStatisticsDtoCopyWithImpl<$Res>
    implements $ProfileStatisticsDtoCopyWith<$Res> {
  _$ProfileStatisticsDtoCopyWithImpl(this._self, this._then);

  final ProfileStatisticsDto _self;
  final $Res Function(ProfileStatisticsDto) _then;

/// Create a copy of ProfileStatisticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoritesCount = null,Object? collectionsCount = null,}) {
  return _then(_self.copyWith(
favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,collectionsCount: null == collectionsCount ? _self.collectionsCount : collectionsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileStatisticsDto].
extension ProfileStatisticsDtoPatterns on ProfileStatisticsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileStatisticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileStatisticsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileStatisticsDto value)  $default,){
final _that = this;
switch (_that) {
case _ProfileStatisticsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileStatisticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileStatisticsDto() when $default != null:
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
case _ProfileStatisticsDto() when $default != null:
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
case _ProfileStatisticsDto():
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
case _ProfileStatisticsDto() when $default != null:
return $default(_that.favoritesCount,_that.collectionsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileStatisticsDto extends ProfileStatisticsDto {
  const _ProfileStatisticsDto({required this.favoritesCount, required this.collectionsCount}): super._();
  factory _ProfileStatisticsDto.fromJson(Map<String, dynamic> json) => _$ProfileStatisticsDtoFromJson(json);

@override final  int favoritesCount;
@override final  int collectionsCount;

/// Create a copy of ProfileStatisticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStatisticsDtoCopyWith<_ProfileStatisticsDto> get copyWith => __$ProfileStatisticsDtoCopyWithImpl<_ProfileStatisticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileStatisticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileStatisticsDto&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.collectionsCount, collectionsCount) || other.collectionsCount == collectionsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favoritesCount,collectionsCount);

@override
String toString() {
  return 'ProfileStatisticsDto(favoritesCount: $favoritesCount, collectionsCount: $collectionsCount)';
}


}

/// @nodoc
abstract mixin class _$ProfileStatisticsDtoCopyWith<$Res> implements $ProfileStatisticsDtoCopyWith<$Res> {
  factory _$ProfileStatisticsDtoCopyWith(_ProfileStatisticsDto value, $Res Function(_ProfileStatisticsDto) _then) = __$ProfileStatisticsDtoCopyWithImpl;
@override @useResult
$Res call({
 int favoritesCount, int collectionsCount
});




}
/// @nodoc
class __$ProfileStatisticsDtoCopyWithImpl<$Res>
    implements _$ProfileStatisticsDtoCopyWith<$Res> {
  __$ProfileStatisticsDtoCopyWithImpl(this._self, this._then);

  final _ProfileStatisticsDto _self;
  final $Res Function(_ProfileStatisticsDto) _then;

/// Create a copy of ProfileStatisticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoritesCount = null,Object? collectionsCount = null,}) {
  return _then(_ProfileStatisticsDto(
favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,collectionsCount: null == collectionsCount ? _self.collectionsCount : collectionsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
