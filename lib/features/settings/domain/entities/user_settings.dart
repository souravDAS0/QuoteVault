import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

/// Theme mode options
enum AppThemeMode { light, dark, system, blue, violet }

/// Font size presets with pixel values
enum FontSizePreset {
  extraSmall(12),
  small(16),
  medium(18), // Previous default was 18
  large(24),
  extraLarge(28);

  final double value;
  const FontSizePreset(this.value);
}

/// Domain entity representing user personalization settings
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(FontSizePreset.medium) FontSizePreset fontSizePreset,
    @Default(true) bool notificationsEnabled,
    @Default(8) int notificationHour,
    @Default(30) int notificationMinute,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
