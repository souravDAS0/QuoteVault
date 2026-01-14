import 'package:flutter/material.dart';

/// Light mode color palette
abstract class AppColorsLight {
  // Brand colors
  static const Color primaryNavy = Color(0xFF061E29);
  static const Color secondary = Color(0xFF10646D);
  static const Color accentTeal = Color(0xFF5F9598);

  // Background colors
  static const Color background = Color(0xFFF3F4F4);
  static const Color surface = Color(0xFFFFFFFF);

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
  static const Color primaryNavy = Color(0xFF0A2A38);
  static const Color secondary = Color(0xFF1A7A87);
  static const Color accentTeal = Color(0xFF7FADB0);

  // Background colors
  static const Color background = Color(0xFF0F1419);
  static const Color surface = Color(0xFF1A1F24);

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
