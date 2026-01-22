// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_logs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugLogsState {

 List<LogEntry> get logs; LogLevel? get filter; bool get isLoading; bool get isClearing; String? get errorMessage;
/// Create a copy of DebugLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugLogsStateCopyWith<DebugLogsState> get copyWith => _$DebugLogsStateCopyWithImpl<DebugLogsState>(this as DebugLogsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugLogsState&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isClearing, isClearing) || other.isClearing == isClearing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(logs),filter,isLoading,isClearing,errorMessage);

@override
String toString() {
  return 'DebugLogsState(logs: $logs, filter: $filter, isLoading: $isLoading, isClearing: $isClearing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DebugLogsStateCopyWith<$Res>  {
  factory $DebugLogsStateCopyWith(DebugLogsState value, $Res Function(DebugLogsState) _then) = _$DebugLogsStateCopyWithImpl;
@useResult
$Res call({
 List<LogEntry> logs, LogLevel? filter, bool isLoading, bool isClearing, String? errorMessage
});




}
/// @nodoc
class _$DebugLogsStateCopyWithImpl<$Res>
    implements $DebugLogsStateCopyWith<$Res> {
  _$DebugLogsStateCopyWithImpl(this._self, this._then);

  final DebugLogsState _self;
  final $Res Function(DebugLogsState) _then;

/// Create a copy of DebugLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logs = null,Object? filter = freezed,Object? isLoading = null,Object? isClearing = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LogLevel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isClearing: null == isClearing ? _self.isClearing : isClearing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebugLogsState].
extension DebugLogsStatePatterns on DebugLogsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugLogsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugLogsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugLogsState value)  $default,){
final _that = this;
switch (_that) {
case _DebugLogsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugLogsState value)?  $default,){
final _that = this;
switch (_that) {
case _DebugLogsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LogEntry> logs,  LogLevel? filter,  bool isLoading,  bool isClearing,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugLogsState() when $default != null:
return $default(_that.logs,_that.filter,_that.isLoading,_that.isClearing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LogEntry> logs,  LogLevel? filter,  bool isLoading,  bool isClearing,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DebugLogsState():
return $default(_that.logs,_that.filter,_that.isLoading,_that.isClearing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LogEntry> logs,  LogLevel? filter,  bool isLoading,  bool isClearing,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DebugLogsState() when $default != null:
return $default(_that.logs,_that.filter,_that.isLoading,_that.isClearing,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DebugLogsState extends DebugLogsState {
  const _DebugLogsState({final  List<LogEntry> logs = const [], this.filter = null, this.isLoading = false, this.isClearing = false, this.errorMessage}): _logs = logs,super._();
  

 final  List<LogEntry> _logs;
@override@JsonKey() List<LogEntry> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override@JsonKey() final  LogLevel? filter;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isClearing;
@override final  String? errorMessage;

/// Create a copy of DebugLogsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugLogsStateCopyWith<_DebugLogsState> get copyWith => __$DebugLogsStateCopyWithImpl<_DebugLogsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugLogsState&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isClearing, isClearing) || other.isClearing == isClearing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),filter,isLoading,isClearing,errorMessage);

@override
String toString() {
  return 'DebugLogsState(logs: $logs, filter: $filter, isLoading: $isLoading, isClearing: $isClearing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DebugLogsStateCopyWith<$Res> implements $DebugLogsStateCopyWith<$Res> {
  factory _$DebugLogsStateCopyWith(_DebugLogsState value, $Res Function(_DebugLogsState) _then) = __$DebugLogsStateCopyWithImpl;
@override @useResult
$Res call({
 List<LogEntry> logs, LogLevel? filter, bool isLoading, bool isClearing, String? errorMessage
});




}
/// @nodoc
class __$DebugLogsStateCopyWithImpl<$Res>
    implements _$DebugLogsStateCopyWith<$Res> {
  __$DebugLogsStateCopyWithImpl(this._self, this._then);

  final _DebugLogsState _self;
  final $Res Function(_DebugLogsState) _then;

/// Create a copy of DebugLogsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? filter = freezed,Object? isLoading = null,Object? isClearing = null,Object? errorMessage = freezed,}) {
  return _then(_DebugLogsState(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<LogEntry>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LogLevel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isClearing: null == isClearing ? _self.isClearing : isClearing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
