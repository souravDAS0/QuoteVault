import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Provider for managing theme mode (light/dark/system)
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    // Default to system theme
    return ThemeMode.system;
  }

  /// Set light mode
  void setLightMode() {
    state = ThemeMode.light;
  }

  /// Set dark mode
  void setDarkMode() {
    state = ThemeMode.dark;
  }

  /// Set system mode (follow device settings)
  void setSystemMode() {
    state = ThemeMode.system;
  }

  /// Toggle between light and dark mode
  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      // If system, switch to light
      state = ThemeMode.light;
    }
  }
}
