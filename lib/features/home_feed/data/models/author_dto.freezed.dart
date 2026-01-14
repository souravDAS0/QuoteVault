// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthorDto {

 String get id; String get name; String? get description;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of AuthorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorDtoCopyWith<AuthorDto> get copyWith => _$AuthorDtoCopyWithImpl<AuthorDto>(this as AuthorDto, _$identity);

  /// Serializes this AuthorDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,avatarUrl);

@override
String toString() {
  return 'AuthorDto(id: $id, name: $name, description: $description, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AuthorDtoCopyWith<$Res>  {
  factory $AuthorDtoCopyWith(AuthorDto value, $Res Function(AuthorDto) _then) = _$AuthorDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$AuthorDtoCopyWithImpl<$Res>
    implements $AuthorDtoCopyWith<$Res> {
  _$AuthorDtoCopyWithImpl(this._self, this._then);

  final AuthorDto _self;
  final $Res Function(AuthorDto) _then;

/// Create a copy of AuthorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthorDto].
extension AuthorDtoPatterns on AuthorDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthorDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthorDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthorDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthorDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthorDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthorDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthorDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _AuthorDto():
return $default(_that.id,_that.name,_that.description,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _AuthorDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthorDto extends AuthorDto {
  const _AuthorDto({required this.id, required this.name, this.description, @JsonKey(name: 'avatar_url') this.avatarUrl}): super._();
  factory _AuthorDto.fromJson(Map<String, dynamic> json) => _$AuthorDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of AuthorDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorDtoCopyWith<_AuthorDto> get copyWith => __$AuthorDtoCopyWithImpl<_AuthorDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthorDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,avatarUrl);

@override
String toString() {
  return 'AuthorDto(id: $id, name: $name, description: $description, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$AuthorDtoCopyWith<$Res> implements $AuthorDtoCopyWith<$Res> {
  factory _$AuthorDtoCopyWith(_AuthorDto value, $Res Function(_AuthorDto) _then) = __$AuthorDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$AuthorDtoCopyWithImpl<$Res>
    implements _$AuthorDtoCopyWith<$Res> {
  __$AuthorDtoCopyWithImpl(this._self, this._then);

  final _AuthorDto _self;
  final $Res Function(_AuthorDto) _then;

/// Create a copy of AuthorDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? avatarUrl = freezed,}) {
  return _then(_AuthorDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
