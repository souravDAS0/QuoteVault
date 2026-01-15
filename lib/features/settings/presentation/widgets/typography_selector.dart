import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/settings_constants.dart';
import '../../domain/entities/user_settings.dart';
import '../../application/controllers/settings_controller.dart';

/// Typography section with font size slider and font family selection
class TypographySelector extends ConsumerWidget {
  const TypographySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Font size buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FontSizeButton(
                label: 'XS',
                preset: FontSizePreset.extraSmall,
                isSelected:
                    settings.fontSizePreset == FontSizePreset.extraSmall,
                onTap: () =>
                    controller.setFontSizePreset(FontSizePreset.extraSmall),
              ),
              _FontSizeButton(
                label: 'S',
                preset: FontSizePreset.small,
                isSelected: settings.fontSizePreset == FontSizePreset.small,
                onTap: () => controller.setFontSizePreset(FontSizePreset.small),
              ),
              _FontSizeButton(
                label: 'M',
                preset: FontSizePreset.medium,
                isSelected: settings.fontSizePreset == FontSizePreset.medium,
                onTap: () =>
                    controller.setFontSizePreset(FontSizePreset.medium),
              ),
              _FontSizeButton(
                label: 'L',
                preset: FontSizePreset.large,
                isSelected: settings.fontSizePreset == FontSizePreset.large,
                onTap: () => controller.setFontSizePreset(FontSizePreset.large),
              ),
              _FontSizeButton(
                label: 'XL',
                preset: FontSizePreset.extraLarge,
                isSelected:
                    settings.fontSizePreset == FontSizePreset.extraLarge,
                onTap: () =>
                    controller.setFontSizePreset(FontSizePreset.extraLarge),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Font family label
          Text(
            SettingsConstants.fontFamilyLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: isDark
                  ? AppColorsDark.textSecondary
                  : AppColorsLight.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          // Font family selection
          Row(
            children: [
              Expanded(
                child: _FontFamilyButton(
                  label: SettingsConstants.jakartaLabel,
                  fontFamily: FontFamily.jakarta,
                  isSelected: settings.fontFamily == FontFamily.jakarta,
                  onTap: () => controller.setFontFamily(FontFamily.jakarta),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FontFamilyButton(
                  label: SettingsConstants.serifLabel,
                  fontFamily: FontFamily.serif,
                  isSelected: settings.fontFamily == FontFamily.serif,
                  onTap: () => controller.setFontFamily(FontFamily.serif),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FontFamilyButton(
                  label: SettingsConstants.monoLabel,
                  fontFamily: FontFamily.mono,
                  isSelected: settings.fontFamily == FontFamily.mono,
                  onTap: () => controller.setFontFamily(FontFamily.mono),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FontFamilyButton extends StatelessWidget {
  final String label;
  final FontFamily fontFamily;
  final bool isSelected;
  final VoidCallback onTap;

  const _FontFamilyButton({
    required this.label,
    required this.fontFamily,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.background : AppColorsLight.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : (isDark ? AppColorsDark.border : AppColorsLight.border),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text('Aa', style: _getFontStyle(fontFamily, isDark)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getFontStyle(FontFamily family, bool isDark) {
    final color = isDark
        ? AppColorsDark.textPrimary
        : AppColorsLight.textPrimary;

    switch (family) {
      case FontFamily.jakarta:
        return GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
        );
      case FontFamily.serif:
        return GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: color,
        );
      case FontFamily.mono:
        return GoogleFonts.jetBrainsMono(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: color,
        );
    }
  }
}

class _FontSizeButton extends StatelessWidget {
  final String label;
  final FontSizePreset preset;
  final bool isSelected;
  final VoidCallback onTap;

  const _FontSizeButton({
    required this.label,
    required this.preset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? primaryColor
                  : (isDark
                        ? AppColorsDark.textSecondary
                        : AppColorsLight.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
