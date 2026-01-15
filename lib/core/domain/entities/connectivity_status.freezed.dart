// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectivityStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityStatus()';
}


}

/// @nodoc
class $ConnectivityStatusCopyWith<$Res>  {
$ConnectivityStatusCopyWith(ConnectivityStatus _, $Res Function(ConnectivityStatus) __);
}


/// Adds pattern-matching-related methods to [ConnectivityStatus].
extension ConnectivityStatusPatterns on ConnectivityStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConnectedStatus value)?  connected,TResult Function( DisconnectedStatus value)?  disconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConnectedStatus() when connected != null:
return connected(_that);case DisconnectedStatus() when disconnected != null:
return disconnected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConnectedStatus value)  connected,required TResult Function( DisconnectedStatus value)  disconnected,}){
final _that = this;
switch (_that) {
case ConnectedStatus():
return connected(_that);case DisconnectedStatus():
return disconnected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConnectedStatus value)?  connected,TResult? Function( DisconnectedStatus value)?  disconnected,}){
final _that = this;
switch (_that) {
case ConnectedStatus() when connected != null:
return connected(_that);case DisconnectedStatus() when disconnected != null:
return disconnected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ConnectionType type)?  connected,TResult Function()?  disconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConnectedStatus() when connected != null:
return connected(_that.type);case DisconnectedStatus() when disconnected != null:
return disconnected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ConnectionType type)  connected,required TResult Function()  disconnected,}) {final _that = this;
switch (_that) {
case ConnectedStatus():
return connected(_that.type);case DisconnectedStatus():
return disconnected();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ConnectionType type)?  connected,TResult? Function()?  disconnected,}) {final _that = this;
switch (_that) {
case ConnectedStatus() when connected != null:
return connected(_that.type);case DisconnectedStatus() when disconnected != null:
return disconnected();case _:
  return null;

}
}

}

/// @nodoc


class ConnectedStatus implements ConnectivityStatus {
  const ConnectedStatus({required this.type});
  

 final  ConnectionType type;

/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectedStatusCopyWith<ConnectedStatus> get copyWith => _$ConnectedStatusCopyWithImpl<ConnectedStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectedStatus&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'ConnectivityStatus.connected(type: $type)';
}


}

/// @nodoc
abstract mixin class $ConnectedStatusCopyWith<$Res> implements $ConnectivityStatusCopyWith<$Res> {
  factory $ConnectedStatusCopyWith(ConnectedStatus value, $Res Function(ConnectedStatus) _then) = _$ConnectedStatusCopyWithImpl;
@useResult
$Res call({
 ConnectionType type
});




}
/// @nodoc
class _$ConnectedStatusCopyWithImpl<$Res>
    implements $ConnectedStatusCopyWith<$Res> {
  _$ConnectedStatusCopyWithImpl(this._self, this._then);

  final ConnectedStatus _self;
  final $Res Function(ConnectedStatus) _then;

/// Create a copy of ConnectivityStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(ConnectedStatus(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConnectionType,
  ));
}


}

/// @nodoc


class DisconnectedStatus implements ConnectivityStatus {
  const DisconnectedStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisconnectedStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityStatus.disconnected()';
}


}




// dart format on
