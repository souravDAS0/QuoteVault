// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettings {

 AppThemeMode get themeMode; FontSizePreset get fontSizePreset; FontFamily get fontFamily; bool get notificationsEnabled; int get notificationHour; int get notificationMinute;
/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsCopyWith<UserSettings> get copyWith => _$UserSettingsCopyWithImpl<UserSettings>(this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.fontSizePreset, fontSizePreset) || other.fontSizePreset == fontSizePreset)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.notificationHour, notificationHour) || other.notificationHour == notificationHour)&&(identical(other.notificationMinute, notificationMinute) || other.notificationMinute == notificationMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,fontSizePreset,fontFamily,notificationsEnabled,notificationHour,notificationMinute);

@override
String toString() {
  return 'UserSettings(themeMode: $themeMode, fontSizePreset: $fontSizePreset, fontFamily: $fontFamily, notificationsEnabled: $notificationsEnabled, notificationHour: $notificationHour, notificationMinute: $notificationMinute)';
}


}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res>  {
  factory $UserSettingsCopyWith(UserSettings value, $Res Function(UserSettings) _then) = _$UserSettingsCopyWithImpl;
@useResult
$Res call({
 AppThemeMode themeMode, FontSizePreset fontSizePreset, FontFamily fontFamily, bool notificationsEnabled, int notificationHour, int notificationMinute
});




}
/// @nodoc
class _$UserSettingsCopyWithImpl<$Res>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? fontSizePreset = null,Object? fontFamily = null,Object? notificationsEnabled = null,Object? notificationHour = null,Object? notificationMinute = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,fontSizePreset: null == fontSizePreset ? _self.fontSizePreset : fontSizePreset // ignore: cast_nullable_to_non_nullable
as FontSizePreset,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationHour: null == notificationHour ? _self.notificationHour : notificationHour // ignore: cast_nullable_to_non_nullable
as int,notificationMinute: null == notificationMinute ? _self.notificationMinute : notificationMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettings value)  $default,){
final _that = this;
switch (_that) {
case _UserSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettings value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppThemeMode themeMode,  FontSizePreset fontSizePreset,  FontFamily fontFamily,  bool notificationsEnabled,  int notificationHour,  int notificationMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.themeMode,_that.fontSizePreset,_that.fontFamily,_that.notificationsEnabled,_that.notificationHour,_that.notificationMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppThemeMode themeMode,  FontSizePreset fontSizePreset,  FontFamily fontFamily,  bool notificationsEnabled,  int notificationHour,  int notificationMinute)  $default,) {final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that.themeMode,_that.fontSizePreset,_that.fontFamily,_that.notificationsEnabled,_that.notificationHour,_that.notificationMinute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppThemeMode themeMode,  FontSizePreset fontSizePreset,  FontFamily fontFamily,  bool notificationsEnabled,  int notificationHour,  int notificationMinute)?  $default,) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.themeMode,_that.fontSizePreset,_that.fontFamily,_that.notificationsEnabled,_that.notificationHour,_that.notificationMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettings implements UserSettings {
  const _UserSettings({this.themeMode = AppThemeMode.system, this.fontSizePreset = FontSizePreset.medium, this.fontFamily = FontFamily.jakarta, this.notificationsEnabled = true, this.notificationHour = 8, this.notificationMinute = 30});
  factory _UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

@override@JsonKey() final  AppThemeMode themeMode;
@override@JsonKey() final  FontSizePreset fontSizePreset;
@override@JsonKey() final  FontFamily fontFamily;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  int notificationHour;
@override@JsonKey() final  int notificationMinute;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsCopyWith<_UserSettings> get copyWith => __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.fontSizePreset, fontSizePreset) || other.fontSizePreset == fontSizePreset)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.notificationHour, notificationHour) || other.notificationHour == notificationHour)&&(identical(other.notificationMinute, notificationMinute) || other.notificationMinute == notificationMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,fontSizePreset,fontFamily,notificationsEnabled,notificationHour,notificationMinute);

@override
String toString() {
  return 'UserSettings(themeMode: $themeMode, fontSizePreset: $fontSizePreset, fontFamily: $fontFamily, notificationsEnabled: $notificationsEnabled, notificationHour: $notificationHour, notificationMinute: $notificationMinute)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res> implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(_UserSettings value, $Res Function(_UserSettings) _then) = __$UserSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppThemeMode themeMode, FontSizePreset fontSizePreset, FontFamily fontFamily, bool notificationsEnabled, int notificationHour, int notificationMinute
});




}
/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? fontSizePreset = null,Object? fontFamily = null,Object? notificationsEnabled = null,Object? notificationHour = null,Object? notificationMinute = null,}) {
  return _then(_UserSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,fontSizePreset: null == fontSizePreset ? _self.fontSizePreset : fontSizePreset // ignore: cast_nullable_to_non_nullable
as FontSizePreset,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as FontFamily,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationHour: null == notificationHour ? _self.notificationHour : notificationHour // ignore: cast_nullable_to_non_nullable
as int,notificationMinute: null == notificationMinute ? _self.notificationMinute : notificationMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
