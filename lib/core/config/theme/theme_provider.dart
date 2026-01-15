import 'package:flutter/material.dart';
import 'package:quote_vault/core/config/theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/settings/application/controllers/settings_controller.dart';
import '../../../features/settings/domain/entities/user_settings.dart';

part 'theme_provider.g.dart';

/// Provider for AppThemeMode from settings
@riverpod
AppThemeMode appThemeMode(Ref ref) {
  final settingsState = ref.watch(settingsControllerProvider);
  return settingsState.settings.themeMode;
}

/// Provider for the effective ThemeMode passed to MaterialApp
///
/// This handles the logic where generic Light/Dark/System map to ThemeMode,
/// but custom color themes (Blue/Violet) are forced as ThemeMode.light
/// so we can provide our custom ThemeData.
@riverpod
ThemeMode effectiveFlutterThemeMode(Ref ref) {
  final mode = ref.watch(appThemeModeProvider);
  switch (mode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
    // For custom themes, we force 'light' mode in Flutter's system
    // but provide our custom theme data as the 'theme'
    case AppThemeMode.blue:
    case AppThemeMode.violet:
      return ThemeMode.light;
  }
}

/// Provider for the effective ThemeData (light/custom)
@riverpod
ThemeData effectiveTheme(Ref ref) {
  final mode = ref.watch(appThemeModeProvider);

  switch (mode) {
    case AppThemeMode.blue:
      return AppTheme.blue();
    case AppThemeMode.violet:
      return AppTheme.violet();
    case AppThemeMode.light:
    case AppThemeMode.dark:
    case AppThemeMode.system:
      return AppTheme.light();
  }
}

/// Provider for the effective DarkThemeData
/// This is only used when we are in Light/Dark/System mode.
/// When in Blue/Violet, we force Light mode so this is ignored,
/// but we provide standard dark theme for System/Dark modes.
@riverpod
ThemeData effectiveDarkTheme(Ref ref) {
  return AppTheme.dark();
}

/// Provider for current font size preset
@riverpod
FontSizePreset fontSizePreset(Ref ref) {
  final settingsState = ref.watch(settingsControllerProvider);
  return settingsState.settings.fontSizePreset;
}

/// Provider for current font family
@riverpod
FontFamily fontFamily(Ref ref) {
  final settingsState = ref.watch(settingsControllerProvider);
  return settingsState.settings.fontFamily;
}
