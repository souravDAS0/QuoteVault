// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qv_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QvUser {

 String get id; String get email; String? get displayName; String? get photoUrl; DateTime? get createdAt;
/// Create a copy of QvUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QvUserCopyWith<QvUser> get copyWith => _$QvUserCopyWithImpl<QvUser>(this as QvUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QvUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoUrl,createdAt);

@override
String toString() {
  return 'QvUser(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QvUserCopyWith<$Res>  {
  factory $QvUserCopyWith(QvUser value, $Res Function(QvUser) _then) = _$QvUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? displayName, String? photoUrl, DateTime? createdAt
});




}
/// @nodoc
class _$QvUserCopyWithImpl<$Res>
    implements $QvUserCopyWith<$Res> {
  _$QvUserCopyWithImpl(this._self, this._then);

  final QvUser _self;
  final $Res Function(QvUser) _then;

/// Create a copy of QvUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QvUser].
extension QvUserPatterns on QvUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QvUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QvUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QvUser value)  $default,){
final _that = this;
switch (_that) {
case _QvUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QvUser value)?  $default,){
final _that = this;
switch (_that) {
case _QvUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoUrl,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QvUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? displayName,  String? photoUrl,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _QvUser():
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? displayName,  String? photoUrl,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QvUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _QvUser implements QvUser {
  const _QvUser({required this.id, required this.email, this.displayName, this.photoUrl, this.createdAt});
  

@override final  String id;
@override final  String email;
@override final  String? displayName;
@override final  String? photoUrl;
@override final  DateTime? createdAt;

/// Create a copy of QvUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QvUserCopyWith<_QvUser> get copyWith => __$QvUserCopyWithImpl<_QvUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QvUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoUrl,createdAt);

@override
String toString() {
  return 'QvUser(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QvUserCopyWith<$Res> implements $QvUserCopyWith<$Res> {
  factory _$QvUserCopyWith(_QvUser value, $Res Function(_QvUser) _then) = __$QvUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? displayName, String? photoUrl, DateTime? createdAt
});




}
/// @nodoc
class __$QvUserCopyWithImpl<$Res>
    implements _$QvUserCopyWith<$Res> {
  __$QvUserCopyWithImpl(this._self, this._then);

  final _QvUser _self;
  final $Res Function(_QvUser) _then;

/// Create a copy of QvUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_QvUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
