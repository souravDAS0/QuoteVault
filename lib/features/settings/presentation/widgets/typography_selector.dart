import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/controllers/settings_controller.dart';
import '../../domain/entities/user_settings.dart';

/// Typography section with font size slider and font family selection
class TypographySelector extends ConsumerWidget {
  const TypographySelector({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final controller = ref.read(settingsControllerProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
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
        ],
      ),
    );
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
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;

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
                  : colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}
