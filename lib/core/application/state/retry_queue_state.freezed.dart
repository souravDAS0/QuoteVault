// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'retry_queue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RetryQueueState {

 List<RetryableOperation> get pendingOperations; bool get isProcessing; List<String> get failedOperationIds;
/// Create a copy of RetryQueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryQueueStateCopyWith<RetryQueueState> get copyWith => _$RetryQueueStateCopyWithImpl<RetryQueueState>(this as RetryQueueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryQueueState&&const DeepCollectionEquality().equals(other.pendingOperations, pendingOperations)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other.failedOperationIds, failedOperationIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pendingOperations),isProcessing,const DeepCollectionEquality().hash(failedOperationIds));

@override
String toString() {
  return 'RetryQueueState(pendingOperations: $pendingOperations, isProcessing: $isProcessing, failedOperationIds: $failedOperationIds)';
}


}

/// @nodoc
abstract mixin class $RetryQueueStateCopyWith<$Res>  {
  factory $RetryQueueStateCopyWith(RetryQueueState value, $Res Function(RetryQueueState) _then) = _$RetryQueueStateCopyWithImpl;
@useResult
$Res call({
 List<RetryableOperation> pendingOperations, bool isProcessing, List<String> failedOperationIds
});




}
/// @nodoc
class _$RetryQueueStateCopyWithImpl<$Res>
    implements $RetryQueueStateCopyWith<$Res> {
  _$RetryQueueStateCopyWithImpl(this._self, this._then);

  final RetryQueueState _self;
  final $Res Function(RetryQueueState) _then;

/// Create a copy of RetryQueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingOperations = null,Object? isProcessing = null,Object? failedOperationIds = null,}) {
  return _then(_self.copyWith(
pendingOperations: null == pendingOperations ? _self.pendingOperations : pendingOperations // ignore: cast_nullable_to_non_nullable
as List<RetryableOperation>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,failedOperationIds: null == failedOperationIds ? _self.failedOperationIds : failedOperationIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryQueueState].
extension RetryQueueStatePatterns on RetryQueueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryQueueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryQueueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryQueueState value)  $default,){
final _that = this;
switch (_that) {
case _RetryQueueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryQueueState value)?  $default,){
final _that = this;
switch (_that) {
case _RetryQueueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RetryableOperation> pendingOperations,  bool isProcessing,  List<String> failedOperationIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryQueueState() when $default != null:
return $default(_that.pendingOperations,_that.isProcessing,_that.failedOperationIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RetryableOperation> pendingOperations,  bool isProcessing,  List<String> failedOperationIds)  $default,) {final _that = this;
switch (_that) {
case _RetryQueueState():
return $default(_that.pendingOperations,_that.isProcessing,_that.failedOperationIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RetryableOperation> pendingOperations,  bool isProcessing,  List<String> failedOperationIds)?  $default,) {final _that = this;
switch (_that) {
case _RetryQueueState() when $default != null:
return $default(_that.pendingOperations,_that.isProcessing,_that.failedOperationIds);case _:
  return null;

}
}

}

/// @nodoc


class _RetryQueueState implements RetryQueueState {
  const _RetryQueueState({final  List<RetryableOperation> pendingOperations = const [], this.isProcessing = false, final  List<String> failedOperationIds = const []}): _pendingOperations = pendingOperations,_failedOperationIds = failedOperationIds;
  

 final  List<RetryableOperation> _pendingOperations;
@override@JsonKey() List<RetryableOperation> get pendingOperations {
  if (_pendingOperations is EqualUnmodifiableListView) return _pendingOperations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingOperations);
}

@override@JsonKey() final  bool isProcessing;
 final  List<String> _failedOperationIds;
@override@JsonKey() List<String> get failedOperationIds {
  if (_failedOperationIds is EqualUnmodifiableListView) return _failedOperationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failedOperationIds);
}


/// Create a copy of RetryQueueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryQueueStateCopyWith<_RetryQueueState> get copyWith => __$RetryQueueStateCopyWithImpl<_RetryQueueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryQueueState&&const DeepCollectionEquality().equals(other._pendingOperations, _pendingOperations)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other._failedOperationIds, _failedOperationIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pendingOperations),isProcessing,const DeepCollectionEquality().hash(_failedOperationIds));

@override
String toString() {
  return 'RetryQueueState(pendingOperations: $pendingOperations, isProcessing: $isProcessing, failedOperationIds: $failedOperationIds)';
}


}

/// @nodoc
abstract mixin class _$RetryQueueStateCopyWith<$Res> implements $RetryQueueStateCopyWith<$Res> {
  factory _$RetryQueueStateCopyWith(_RetryQueueState value, $Res Function(_RetryQueueState) _then) = __$RetryQueueStateCopyWithImpl;
@override @useResult
$Res call({
 List<RetryableOperation> pendingOperations, bool isProcessing, List<String> failedOperationIds
});




}
/// @nodoc
class __$RetryQueueStateCopyWithImpl<$Res>
    implements _$RetryQueueStateCopyWith<$Res> {
  __$RetryQueueStateCopyWithImpl(this._self, this._then);

  final _RetryQueueState _self;
  final $Res Function(_RetryQueueState) _then;

/// Create a copy of RetryQueueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingOperations = null,Object? isProcessing = null,Object? failedOperationIds = null,}) {
  return _then(_RetryQueueState(
pendingOperations: null == pendingOperations ? _self._pendingOperations : pendingOperations // ignore: cast_nullable_to_non_nullable
as List<RetryableOperation>,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,failedOperationIds: null == failedOperationIds ? _self._failedOperationIds : failedOperationIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
