// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShareTemplate {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareTemplate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShareTemplate()';
}


}

/// @nodoc
class $ShareTemplateCopyWith<$Res>  {
$ShareTemplateCopyWith(ShareTemplate _, $Res Function(ShareTemplate) __);
}


/// Adds pattern-matching-related methods to [ShareTemplate].
extension ShareTemplatePatterns on ShareTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClassicTemplate value)?  classic,TResult Function( MinimalTemplate value)?  minimal,TResult Function( GradientTemplate value)?  gradient,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClassicTemplate() when classic != null:
return classic(_that);case MinimalTemplate() when minimal != null:
return minimal(_that);case GradientTemplate() when gradient != null:
return gradient(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClassicTemplate value)  classic,required TResult Function( MinimalTemplate value)  minimal,required TResult Function( GradientTemplate value)  gradient,}){
final _that = this;
switch (_that) {
case ClassicTemplate():
return classic(_that);case MinimalTemplate():
return minimal(_that);case GradientTemplate():
return gradient(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClassicTemplate value)?  classic,TResult? Function( MinimalTemplate value)?  minimal,TResult? Function( GradientTemplate value)?  gradient,}){
final _that = this;
switch (_that) {
case ClassicTemplate() when classic != null:
return classic(_that);case MinimalTemplate() when minimal != null:
return minimal(_that);case GradientTemplate() when gradient != null:
return gradient(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  classic,TResult Function()?  minimal,TResult Function()?  gradient,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClassicTemplate() when classic != null:
return classic();case MinimalTemplate() when minimal != null:
return minimal();case GradientTemplate() when gradient != null:
return gradient();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  classic,required TResult Function()  minimal,required TResult Function()  gradient,}) {final _that = this;
switch (_that) {
case ClassicTemplate():
return classic();case MinimalTemplate():
return minimal();case GradientTemplate():
return gradient();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  classic,TResult? Function()?  minimal,TResult? Function()?  gradient,}) {final _that = this;
switch (_that) {
case ClassicTemplate() when classic != null:
return classic();case MinimalTemplate() when minimal != null:
return minimal();case GradientTemplate() when gradient != null:
return gradient();case _:
  return null;

}
}

}

/// @nodoc


class ClassicTemplate implements ShareTemplate {
  const ClassicTemplate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassicTemplate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShareTemplate.classic()';
}


}




/// @nodoc


class MinimalTemplate implements ShareTemplate {
  const MinimalTemplate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinimalTemplate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShareTemplate.minimal()';
}


}




/// @nodoc


class GradientTemplate implements ShareTemplate {
  const GradientTemplate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradientTemplate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShareTemplate.gradient()';
}


}




// dart format on
