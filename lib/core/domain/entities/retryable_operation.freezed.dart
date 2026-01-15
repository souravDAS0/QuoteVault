// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'retryable_operation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RetryableOperation {

 String get id; OperationType get type; Map<String, dynamic> get payload; DateTime get createdAt; int get retryCount; int get maxRetries; String? get lastError;
/// Create a copy of RetryableOperation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryableOperationCopyWith<RetryableOperation> get copyWith => _$RetryableOperationCopyWithImpl<RetryableOperation>(this as RetryableOperation, _$identity);

  /// Serializes this RetryableOperation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryableOperation&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(payload),createdAt,retryCount,maxRetries,lastError);

@override
String toString() {
  return 'RetryableOperation(id: $id, type: $type, payload: $payload, createdAt: $createdAt, retryCount: $retryCount, maxRetries: $maxRetries, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class $RetryableOperationCopyWith<$Res>  {
  factory $RetryableOperationCopyWith(RetryableOperation value, $Res Function(RetryableOperation) _then) = _$RetryableOperationCopyWithImpl;
@useResult
$Res call({
 String id, OperationType type, Map<String, dynamic> payload, DateTime createdAt, int retryCount, int maxRetries, String? lastError
});




}
/// @nodoc
class _$RetryableOperationCopyWithImpl<$Res>
    implements $RetryableOperationCopyWith<$Res> {
  _$RetryableOperationCopyWithImpl(this._self, this._then);

  final RetryableOperation _self;
  final $Res Function(RetryableOperation) _then;

/// Create a copy of RetryableOperation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? payload = null,Object? createdAt = null,Object? retryCount = null,Object? maxRetries = null,Object? lastError = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OperationType,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryableOperation].
extension RetryableOperationPatterns on RetryableOperation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryableOperation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryableOperation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryableOperation value)  $default,){
final _that = this;
switch (_that) {
case _RetryableOperation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryableOperation value)?  $default,){
final _that = this;
switch (_that) {
case _RetryableOperation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  OperationType type,  Map<String, dynamic> payload,  DateTime createdAt,  int retryCount,  int maxRetries,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryableOperation() when $default != null:
return $default(_that.id,_that.type,_that.payload,_that.createdAt,_that.retryCount,_that.maxRetries,_that.lastError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  OperationType type,  Map<String, dynamic> payload,  DateTime createdAt,  int retryCount,  int maxRetries,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _RetryableOperation():
return $default(_that.id,_that.type,_that.payload,_that.createdAt,_that.retryCount,_that.maxRetries,_that.lastError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  OperationType type,  Map<String, dynamic> payload,  DateTime createdAt,  int retryCount,  int maxRetries,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _RetryableOperation() when $default != null:
return $default(_that.id,_that.type,_that.payload,_that.createdAt,_that.retryCount,_that.maxRetries,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetryableOperation implements RetryableOperation {
  const _RetryableOperation({required this.id, required this.type, required final  Map<String, dynamic> payload, required this.createdAt, this.retryCount = 0, this.maxRetries = 3, this.lastError}): _payload = payload;
  factory _RetryableOperation.fromJson(Map<String, dynamic> json) => _$RetryableOperationFromJson(json);

@override final  String id;
@override final  OperationType type;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  DateTime createdAt;
@override@JsonKey() final  int retryCount;
@override@JsonKey() final  int maxRetries;
@override final  String? lastError;

/// Create a copy of RetryableOperation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryableOperationCopyWith<_RetryableOperation> get copyWith => __$RetryableOperationCopyWithImpl<_RetryableOperation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetryableOperationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryableOperation&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_payload),createdAt,retryCount,maxRetries,lastError);

@override
String toString() {
  return 'RetryableOperation(id: $id, type: $type, payload: $payload, createdAt: $createdAt, retryCount: $retryCount, maxRetries: $maxRetries, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$RetryableOperationCopyWith<$Res> implements $RetryableOperationCopyWith<$Res> {
  factory _$RetryableOperationCopyWith(_RetryableOperation value, $Res Function(_RetryableOperation) _then) = __$RetryableOperationCopyWithImpl;
@override @useResult
$Res call({
 String id, OperationType type, Map<String, dynamic> payload, DateTime createdAt, int retryCount, int maxRetries, String? lastError
});




}
/// @nodoc
class __$RetryableOperationCopyWithImpl<$Res>
    implements _$RetryableOperationCopyWith<$Res> {
  __$RetryableOperationCopyWithImpl(this._self, this._then);

  final _RetryableOperation _self;
  final $Res Function(_RetryableOperation) _then;

/// Create a copy of RetryableOperation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? payload = null,Object? createdAt = null,Object? retryCount = null,Object? maxRetries = null,Object? lastError = freezed,}) {
  return _then(_RetryableOperation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OperationType,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
