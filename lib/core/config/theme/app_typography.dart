import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale for the application
abstract class AppTypography {
  // Albert Sans styles
  static TextStyle displayLarge({Color? color}) => GoogleFonts.albertSans(
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    color: color,
    letterSpacing: -0.5,
  );

  static TextStyle headlineLarge({Color? color}) => GoogleFonts.albertSans(
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semibold
    color: color,
    letterSpacing: -0.25,
  );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.albertSans(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    color: color,
  );

  // Barlow styles
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.barlow(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: color,
    height: 1.5,
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.barlow(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.5,
  );

  static TextStyle bodyItalic({Color? color}) => GoogleFonts.barlow(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: color,
    height: 1.6,
  );

  static TextStyle caption({Color? color}) => GoogleFonts.barlow(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
    letterSpacing: 0.4,
  );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.barlow(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 0.5,
    textBaseline: TextBaseline.alphabetic,
  );
}

/// Helper class to build TextTheme for Material ThemeData
class AppTextTheme {
  static TextTheme light() {
    return TextTheme(
      displayLarge: AppTypography.displayLarge(
        color: AppColorsLight.textPrimary,
      ),
      headlineLarge: AppTypography.headlineLarge(
        color: AppColorsLight.textPrimary,
      ),
      headlineMedium: AppTypography.headlineMedium(
        color: AppColorsLight.textPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge(color: AppColorsLight.textPrimary),
      bodyMedium: AppTypography.bodyMedium(color: AppColorsLight.textPrimary),
      labelSmall: AppTypography.caption(color: AppColorsLight.textSecondary),
    );
  }

  static TextTheme dark() {
    return TextTheme(
      displayLarge: AppTypography.displayLarge(
        color: AppColorsDark.textPrimary,
      ),
      headlineLarge: AppTypography.headlineLarge(
        color: AppColorsDark.textPrimary,
      ),
      headlineMedium: AppTypography.headlineMedium(
        color: AppColorsDark.textPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge(color: AppColorsDark.textPrimary),
      bodyMedium: AppTypography.bodyMedium(color: AppColorsDark.textPrimary),
      labelSmall: AppTypography.caption(color: AppColorsDark.textSecondary),
    );
  }

  static TextTheme blue() {
    return TextTheme(
      displayLarge: AppTypography.displayLarge(
        color: AppColorsBlue.textPrimary,
      ),
      headlineLarge: AppTypography.headlineLarge(
        color: AppColorsBlue.textPrimary,
      ),
      headlineMedium: AppTypography.headlineMedium(
        color: AppColorsBlue.textPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge(color: AppColorsBlue.textPrimary),
      bodyMedium: AppTypography.bodyMedium(color: AppColorsBlue.textPrimary),
      labelSmall: AppTypography.caption(color: AppColorsBlue.textSecondary),
    );
  }

  static TextTheme violet() {
    return TextTheme(
      displayLarge: AppTypography.displayLarge(
        color: AppColorsViolet.textPrimary,
      ),
      headlineLarge: AppTypography.headlineLarge(
        color: AppColorsViolet.textPrimary,
      ),
      headlineMedium: AppTypography.headlineMedium(
        color: AppColorsViolet.textPrimary,
      ),
      bodyLarge: AppTypography.bodyLarge(color: AppColorsViolet.textPrimary),
      bodyMedium: AppTypography.bodyMedium(color: AppColorsViolet.textPrimary),
      labelSmall: AppTypography.caption(color: AppColorsViolet.textSecondary),
    );
  }
}
