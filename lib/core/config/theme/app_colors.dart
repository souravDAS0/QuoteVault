import 'package:flutter/material.dart';

/// Theme extension for app-specific colors not in ColorScheme
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color textTertiary;
  final Color border;

  const AppColorsExtension({
    required this.textTertiary,
    required this.border,
  });

  @override
  AppColorsExtension copyWith({
    Color? textTertiary,
    Color? border,
  }) {
    return AppColorsExtension(
      textTertiary: textTertiary ?? this.textTertiary,
      border: border ?? this.border,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }

  // Light theme extension
  static const light = AppColorsExtension(
    textTertiary: AppColorsLight.textTertiary,
    border: AppColorsLight.border,
  );

  // Dark theme extension
  static const dark = AppColorsExtension(
    textTertiary: AppColorsDark.textTertiary,
    border: AppColorsDark.border,
  );

  // Blue theme extension
  static const blue = AppColorsExtension(
    textTertiary: AppColorsBlue.textSecondary,
    border: AppColorsBlue.border,
  );

  // Violet theme extension
  static const violet = AppColorsExtension(
    textTertiary: AppColorsViolet.textSecondary,
    border: AppColorsViolet.border,
  );
}

/// Light mode color palette
abstract class AppColorsLight {
  // Brand colors
  static const Color primaryNavy = Color.fromARGB(255, 6, 30, 41);
  static const Color secondary = Color(0xFF10646D);
  static const Color accentTeal = Color(0xFF5F9598);

  // Background colors
  static const Color background = Color(0xFFF3F4F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color.fromARGB(255, 225, 225, 225);
  static const Color outlineVariant = Color.fromARGB(255, 32, 55, 66);

  // Text colors
  static const Color textPrimary = Color(0xFF061E29);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Semantic colors
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color.fromARGB(255, 243, 149, 125);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Border and divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFD1D5DB);
}

/// Dark mode color palette
abstract class AppColorsDark {
  // Brand colors (adjusted for dark mode)
  static const Color secondary = Color(0xFF0A2A38);
  static const Color primaryNavy = Color(0xFF1A7A87);
  static const Color accentTeal = Color(0xFF7FADB0);

  // Background colors
  static const Color background = Color(0xFF0F1419);
  static const Color surface = Color(0xFF1A1F24);
  static const Color surfaceContainer = Color.fromARGB(255, 43, 51, 59);
  static const Color outlineVariant = Color.fromARGB(255, 32, 55, 66);

  // Text colors
  static const Color textPrimary = Color(0xFFF3F4F4);
  static const Color textSecondary = Color(0xFFB0B8C1);
  static const Color textTertiary = Color(0xFF6B7280);

  // Semantic colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color.fromARGB(255, 243, 149, 125);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color info = Color(0xFF60A5FA);

  // Border and divider
  static const Color border = Color(0xFF374151);
  static const Color divider = Color(0xFF4B5563);
}

/// Blue Theme (Standalone)
abstract class AppColorsBlue {
  static const Color primary = Color(0xFF715AFF);
  static const Color secondary = Color(0xFF286571);
  static const Color tertiary = Color(0xFF329CB0);
  static const Color accent = Color(0xFFAFCAD1);

  static const Color background = Color(0xFF1A1F2E);
  static const Color surface = Color(0xFF242B3D);
  static const Color surfaceContainer = Color.fromARGB(255, 65, 76, 104);
  static const Color outlineVariant = Color.fromARGB(255, 179, 66, 224);

  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFB8C0D4);

  static const Color border = Color(0xFF2E364A);
  static const Color divider = Color(0xFF3A445C);

  // Reuse semantic colors from Dark mainly or define specific if needed
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color.fromARGB(255, 243, 149, 125);
  static const Color success = Color(0xFF10B981);
}

/// Violet Theme (Standalone)
abstract class AppColorsViolet {
  static const Color primary = Color(0xFF845EC2);
  static const Color secondary = Color(0xFF009EFA);
  static const Color tertiary = Color(0xFF00D2FC);
  static const Color accent = Color(0xFF4FFBDF);

  static const Color background = Color(0xFF1E1A2E);
  static const Color surface = Color(0xFF2A2640);
  static const Color surfaceContainer = Color.fromARGB(255, 64, 57, 100);
  static const Color outlineVariant = Color.fromARGB(255, 140, 110, 190);

  static const Color textPrimary = Color(0xFFF8F7FA);
  static const Color textSecondary = Color(0xFFC4BED4);

  static const Color border = Color(0xFF3D3654);
  static const Color divider = Color(0xFF4B4366);

  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color.fromARGB(255, 243, 149, 125);
  static const Color success = Color(0xFF10B981);
}
