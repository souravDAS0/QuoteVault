// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) =>
    _UserSettings(
      themeMode:
          $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
          AppThemeMode.system,
      fontSizePreset:
          $enumDecodeNullable(
            _$FontSizePresetEnumMap,
            json['fontSizePreset'],
          ) ??
          FontSizePreset.medium,
      fontFamily:
          $enumDecodeNullable(_$FontFamilyEnumMap, json['fontFamily']) ??
          FontFamily.jakarta,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      notificationHour: (json['notificationHour'] as num?)?.toInt() ?? 8,
      notificationMinute: (json['notificationMinute'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$UserSettingsToJson(_UserSettings instance) =>
    <String, dynamic>{
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'fontSizePreset': _$FontSizePresetEnumMap[instance.fontSizePreset]!,
      'fontFamily': _$FontFamilyEnumMap[instance.fontFamily]!,
      'notificationsEnabled': instance.notificationsEnabled,
      'notificationHour': instance.notificationHour,
      'notificationMinute': instance.notificationMinute,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
  AppThemeMode.blue: 'blue',
  AppThemeMode.violet: 'violet',
};

const _$FontSizePresetEnumMap = {
  FontSizePreset.extraSmall: 'extraSmall',
  FontSizePreset.small: 'small',
  FontSizePreset.medium: 'medium',
  FontSizePreset.large: 'large',
  FontSizePreset.extraLarge: 'extraLarge',
};

const _$FontFamilyEnumMap = {
  FontFamily.jakarta: 'jakarta',
  FontFamily.serif: 'serif',
  FontFamily.mono: 'mono',
};
