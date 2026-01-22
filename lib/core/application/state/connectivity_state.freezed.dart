// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectivityState {

 bool get isConnected;// Default to offline until verified
 ConnectionType get connectionType; bool get isInitialized; bool get wasOffline; DateTime? get lastOnlineTime;
/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectivityStateCopyWith<ConnectivityState> get copyWith => _$ConnectivityStateCopyWithImpl<ConnectivityState>(this as ConnectivityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.wasOffline, wasOffline) || other.wasOffline == wasOffline)&&(identical(other.lastOnlineTime, lastOnlineTime) || other.lastOnlineTime == lastOnlineTime));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,connectionType,isInitialized,wasOffline,lastOnlineTime);

@override
String toString() {
  return 'ConnectivityState(isConnected: $isConnected, connectionType: $connectionType, isInitialized: $isInitialized, wasOffline: $wasOffline, lastOnlineTime: $lastOnlineTime)';
}


}

/// @nodoc
abstract mixin class $ConnectivityStateCopyWith<$Res>  {
  factory $ConnectivityStateCopyWith(ConnectivityState value, $Res Function(ConnectivityState) _then) = _$ConnectivityStateCopyWithImpl;
@useResult
$Res call({
 bool isConnected, ConnectionType connectionType, bool isInitialized, bool wasOffline, DateTime? lastOnlineTime
});




}
/// @nodoc
class _$ConnectivityStateCopyWithImpl<$Res>
    implements $ConnectivityStateCopyWith<$Res> {
  _$ConnectivityStateCopyWithImpl(this._self, this._then);

  final ConnectivityState _self;
  final $Res Function(ConnectivityState) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isConnected = null,Object? connectionType = null,Object? isInitialized = null,Object? wasOffline = null,Object? lastOnlineTime = freezed,}) {
  return _then(_self.copyWith(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,connectionType: null == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as ConnectionType,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,wasOffline: null == wasOffline ? _self.wasOffline : wasOffline // ignore: cast_nullable_to_non_nullable
as bool,lastOnlineTime: freezed == lastOnlineTime ? _self.lastOnlineTime : lastOnlineTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectivityState].
extension ConnectivityStatePatterns on ConnectivityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectivityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectivityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectivityState value)  $default,){
final _that = this;
switch (_that) {
case _ConnectivityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectivityState value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectivityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isConnected,  ConnectionType connectionType,  bool isInitialized,  bool wasOffline,  DateTime? lastOnlineTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectivityState() when $default != null:
return $default(_that.isConnected,_that.connectionType,_that.isInitialized,_that.wasOffline,_that.lastOnlineTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isConnected,  ConnectionType connectionType,  bool isInitialized,  bool wasOffline,  DateTime? lastOnlineTime)  $default,) {final _that = this;
switch (_that) {
case _ConnectivityState():
return $default(_that.isConnected,_that.connectionType,_that.isInitialized,_that.wasOffline,_that.lastOnlineTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isConnected,  ConnectionType connectionType,  bool isInitialized,  bool wasOffline,  DateTime? lastOnlineTime)?  $default,) {final _that = this;
switch (_that) {
case _ConnectivityState() when $default != null:
return $default(_that.isConnected,_that.connectionType,_that.isInitialized,_that.wasOffline,_that.lastOnlineTime);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectivityState implements ConnectivityState {
  const _ConnectivityState({this.isConnected = false, this.connectionType = ConnectionType.none, this.isInitialized = false, this.wasOffline = false, this.lastOnlineTime});
  

@override@JsonKey() final  bool isConnected;
// Default to offline until verified
@override@JsonKey() final  ConnectionType connectionType;
@override@JsonKey() final  bool isInitialized;
@override@JsonKey() final  bool wasOffline;
@override final  DateTime? lastOnlineTime;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectivityStateCopyWith<_ConnectivityState> get copyWith => __$ConnectivityStateCopyWithImpl<_ConnectivityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectivityState&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.wasOffline, wasOffline) || other.wasOffline == wasOffline)&&(identical(other.lastOnlineTime, lastOnlineTime) || other.lastOnlineTime == lastOnlineTime));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,connectionType,isInitialized,wasOffline,lastOnlineTime);

@override
String toString() {
  return 'ConnectivityState(isConnected: $isConnected, connectionType: $connectionType, isInitialized: $isInitialized, wasOffline: $wasOffline, lastOnlineTime: $lastOnlineTime)';
}


}

/// @nodoc
abstract mixin class _$ConnectivityStateCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$ConnectivityStateCopyWith(_ConnectivityState value, $Res Function(_ConnectivityState) _then) = __$ConnectivityStateCopyWithImpl;
@override @useResult
$Res call({
 bool isConnected, ConnectionType connectionType, bool isInitialized, bool wasOffline, DateTime? lastOnlineTime
});




}
/// @nodoc
class __$ConnectivityStateCopyWithImpl<$Res>
    implements _$ConnectivityStateCopyWith<$Res> {
  __$ConnectivityStateCopyWithImpl(this._self, this._then);

  final _ConnectivityState _self;
  final $Res Function(_ConnectivityState) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isConnected = null,Object? connectionType = null,Object? isInitialized = null,Object? wasOffline = null,Object? lastOnlineTime = freezed,}) {
  return _then(_ConnectivityState(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,connectionType: null == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as ConnectionType,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,wasOffline: null == wasOffline ? _self.wasOffline : wasOffline // ignore: cast_nullable_to_non_nullable
as bool,lastOnlineTime: freezed == lastOnlineTime ? _self.lastOnlineTime : lastOnlineTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
