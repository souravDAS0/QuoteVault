import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/features/settings/domain/entities/user_settings.dart';

import '../../../../core/constants/settings_constants.dart';
import '../../application/controllers/settings_controller.dart';
import '../widgets/appearance_selector.dart';
import '../widgets/notification_settings.dart';
import '../widgets/quote_preview_card.dart';
import '../widgets/typography_selector.dart';

/// Personalization/Settings screen
class PersonalizationScreen extends ConsumerWidget {
  const PersonalizationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: colorScheme.onSurface,
            size: 28,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          SettingsConstants.screenTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: settingsState.isLoading
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
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
                  ),
                  const SizedBox(height: 12),
                  const QuotePreviewCard(),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      SettingsConstants.previewHint,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Appearance Section
                  _SectionHeader(
                    icon: Icons.palette_outlined,
                    title: SettingsConstants.appearanceSection,
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
                  ),
                  const SizedBox(height: 12),
                  const TypographySelector(),
                  const SizedBox(height: 24),
                  // Notifications Section
                  _SectionHeader(
                    icon: Icons.notifications_outlined,
                    title: SettingsConstants.notificationsSection,
                  ),
                  const SizedBox(height: 12),
                  const NotificationSettings(),

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

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
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

  const _SectionHeaderWithValue({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
