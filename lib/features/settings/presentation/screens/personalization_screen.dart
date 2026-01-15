import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/features/settings/domain/entities/user_settings.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/settings_constants.dart';
import '../../application/controllers/settings_controller.dart';
import '../widgets/quote_preview_card.dart';
import '../widgets/appearance_selector.dart';
import '../widgets/typography_selector.dart';
import '../widgets/notification_settings.dart';

/// Personalization/Settings screen
class PersonalizationScreen extends ConsumerWidget {
  const PersonalizationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColorsDark.background
            : AppColorsLight.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
            size: 28,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          SettingsConstants.screenTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: settingsState.isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Preview Section
                  _SectionHeader(
                    icon: Icons.visibility_outlined,
                    title: SettingsConstants.previewSection,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  const QuotePreviewCard(),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      SettingsConstants.previewHint,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColorsDark.textTertiary
                            : AppColorsLight.textTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Appearance Section
                  _SectionHeader(
                    icon: Icons.palette_outlined,
                    title: SettingsConstants.appearanceSection,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  const AppearanceSelector(),
                  const SizedBox(height: 24),
                  // Typography Section
                  _SectionHeaderWithValue(
                    icon: Icons.text_fields,
                    title: SettingsConstants.typographySection,
                    value: _getFontSizeLabel(
                      settingsState.settings.fontSizePreset,
                    ),
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  const TypographySelector(),
                  const SizedBox(height: 24),
                  // Notifications Section
                  _SectionHeader(
                    icon: Icons.notifications_outlined,
                    title: SettingsConstants.notificationsSection,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 12),
                  const NotificationSettings(),
                  // const SizedBox(height: 24),
                  // Background Styles
                  // const BackgroundStylesButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  String _getFontSizeLabel(FontSizePreset preset) {
    switch (preset) {
      case FontSizePreset.extraSmall:
        return 'Extra Small';
      case FontSizePreset.small:
        return 'Small';
      case FontSizePreset.medium:
        return 'Medium';
      case FontSizePreset.large:
        return 'Large';
      case FontSizePreset.extraLarge:
        return 'Extra Large';
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SectionHeaderWithValue extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _SectionHeaderWithValue({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColorsDark.textPrimary
                  : AppColorsLight.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
