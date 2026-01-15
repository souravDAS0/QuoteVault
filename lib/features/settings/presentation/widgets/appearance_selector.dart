import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/settings_constants.dart';
import '../../domain/entities/user_settings.dart';
import '../../application/controllers/settings_controller.dart';

/// Appearance section with theme mode and accent color selection
class AppearanceSelector extends ConsumerWidget {
  const AppearanceSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final controller = ref.read(settingsControllerProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Light mode
          _ThemeModeButton(
            icon: Icons.light_mode_outlined,
            label: SettingsConstants.lightLabel,
            isSelected: settings.themeMode == AppThemeMode.light,
            onTap: () => controller.setThemeMode(AppThemeMode.light),
          ),
          // Dark mode
          _ThemeModeButton(
            icon: Icons.dark_mode,
            label: SettingsConstants.darkLabel,
            isSelected: settings.themeMode == AppThemeMode.dark,
            onTap: () => controller.setThemeMode(AppThemeMode.dark),
          ),
          // System mode
          _ThemeModeButton(
            icon: Icons.settings_suggest_outlined,
            label: SettingsConstants.systemLabel,
            isSelected: settings.themeMode == AppThemeMode.system,
            onTap: () => controller.setThemeMode(AppThemeMode.system),
          ),
          // Blue mode
          _ColorThemeButton(
            color: const Color(0xFF715AFF),
            label: 'Blue',
            isSelected: settings.themeMode == AppThemeMode.blue,
            onTap: () => controller.setThemeMode(AppThemeMode.blue),
          ),
          // Violet mode
          _ColorThemeButton(
            color: const Color(0xFF845EC2),
            label: 'Violet',
            isSelected: settings.themeMode == AppThemeMode.violet,
            onTap: () => controller.setThemeMode(AppThemeMode.violet),
          ),
        ],
      ),
    );
  }
}

class _ColorThemeButton extends StatelessWidget {
  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorThemeButton({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.surface.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: color.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? color
                    : (isDark
                          ? colorScheme.onSurface.withValues(alpha: 0.7)
                          : colorScheme.onSurface.withValues(alpha: 0.7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeModeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // For icon and text color in unselected state
    final unselectedColor = colorScheme.onSurface.withValues(alpha: 0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme
                    .primary // Use primary color for selected state
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.onPrimary : unselectedColor,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? colorScheme.onPrimary : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
