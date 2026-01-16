import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Application theme configuration
abstract class AppTheme {
  /// Light theme configuration
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: AppColorsLight.primaryNavy,
        secondary: AppColorsLight.secondary,
        tertiary: AppColorsLight.accentTeal,
        surface: AppColorsLight.surface,
        surfaceContainer: AppColorsLight.surfaceContainer,
        outlineVariant: AppColorsLight.outlineVariant,
        error: AppColorsLight.error,
        errorContainer: AppColorsLight.errorContainer,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColorsLight.textPrimary,
        onSurfaceVariant: AppColorsLight.textSecondary,
        onTertiary: AppColorsLight.textTertiary,
        onError: Colors.white,
        outline: AppColorsLight.divider,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColorsLight.background,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsLight.surface,
        foregroundColor: AppColorsLight.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium(
          color: AppColorsLight.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColorsLight.textPrimary),
      ),

      // Text theme
      textTheme: AppTextTheme.light(),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColorsLight.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsLight.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsLight.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColorsLight.primaryNavy,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsLight.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.primaryNavy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.bodyLarge(color: Colors.white),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColorsLight.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: AppColorsDark.primaryNavy,
        secondary: AppColorsDark.secondary,
        tertiary: AppColorsDark.accentTeal,
        surface: AppColorsDark.surface,
        surfaceContainer: AppColorsDark.surfaceContainer,
        outlineVariant: AppColorsDark.outlineVariant,
        error: AppColorsDark.error,
        errorContainer: AppColorsDark.errorContainer,
        onPrimary: AppColorsDark.textPrimary,
        onSecondary: AppColorsDark.textPrimary,
        onSurface: AppColorsDark.textPrimary,
        onSurfaceVariant: AppColorsDark.textSecondary,
        onTertiary: AppColorsDark.textTertiary,
        onError: Colors.white,
        outline: AppColorsDark.divider,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColorsDark.background,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsDark.surface,
        foregroundColor: AppColorsDark.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium(
          color: AppColorsDark.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColorsDark.textPrimary),
      ),

      // Text theme
      textTheme: AppTextTheme.dark(),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColorsDark.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsDark.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsDark.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColorsDark.accentTeal,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsDark.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.accentTeal,
          foregroundColor: AppColorsDark.primaryNavy,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.bodyLarge(color: AppColorsDark.primaryNavy),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColorsDark.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Blue theme configuration
  static ThemeData blue() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.dark(
        primary: AppColorsBlue.primary,
        secondary: AppColorsBlue.secondary,
        tertiary: AppColorsBlue.tertiary,
        surface: AppColorsBlue.surface,
        surfaceContainer: AppColorsBlue.surfaceContainer,
        outlineVariant: AppColorsBlue.outlineVariant,
        error: AppColorsBlue.error,
        errorContainer: AppColorsBlue.errorContainer,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColorsBlue.textPrimary,
        onSurfaceVariant: AppColorsBlue.textSecondary,
        onTertiary: AppColorsBlue.textTertiary,
        onError: Colors.white,
        outline: AppColorsBlue.divider,
      ),

      scaffoldBackgroundColor: AppColorsBlue.background,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsBlue.surface,
        foregroundColor: AppColorsBlue.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium(
          color: AppColorsBlue.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColorsBlue.textPrimary),
      ),

      textTheme: AppTextTheme.blue(),

      cardTheme: CardThemeData(
        color: AppColorsBlue.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsBlue.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsBlue.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsBlue.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsBlue.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsBlue.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsBlue.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.bodyLarge(color: Colors.white),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColorsBlue.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Violet theme configuration
  static ThemeData violet() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.dark(
        primary: AppColorsViolet.primary,
        secondary: AppColorsViolet.secondary,
        tertiary: AppColorsViolet.tertiary,
        surface: AppColorsViolet.surface,
        surfaceContainer: AppColorsViolet.surfaceContainer,
        outlineVariant: AppColorsViolet.outlineVariant,
        error: AppColorsViolet.error,
        errorContainer: AppColorsViolet.errorContainer,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColorsViolet.textPrimary,
        onSurfaceVariant: AppColorsViolet.textSecondary,
        onTertiary: AppColorsViolet.textTertiary,
        onError: Colors.white,
        outline: AppColorsViolet.divider,
      ),

      scaffoldBackgroundColor: AppColorsViolet.background,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsViolet.surface,
        foregroundColor: AppColorsViolet.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium(
          color: AppColorsViolet.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColorsViolet.textPrimary),
      ),

      textTheme: AppTextTheme.violet(),

      cardTheme: CardThemeData(
        color: AppColorsViolet.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsViolet.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsViolet.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsViolet.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColorsViolet.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColorsViolet.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsViolet.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTypography.bodyLarge(color: Colors.white),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColorsViolet.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
