import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';

/// List item for account settings options
class AccountSettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showTrailingIcon;
  final bool isLogout;

  const AccountSettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textColor,
    this.showTrailingIcon = true,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? isLogout
                      ? AppColorsDark.error.withValues(alpha: 0.3)
                      : AppColorsDark.surface
                : isLogout
                ? AppColorsLight.error.withValues(alpha: 0.3)
                : AppColorsLight.surface,
          ),
          color: isDark
              ? isLogout
                    ? AppColorsDark.errorContainer.withValues(alpha: 0.1)
                    : AppColorsDark.surface
              : isLogout
              ? AppColorsLight.errorContainer.withValues(alpha: 0.1)
              : AppColorsLight.surface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                    iconColor?.withValues(alpha: 0.1) ??
                    (isDark
                        ? AppColorsDark.accentTeal.withValues(alpha: 0.1)
                        : AppColorsLight.accentTeal.withValues(alpha: 0.1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color:
                    iconColor ??
                    (isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color:
                      textColor ??
                      (isDark
                          ? AppColorsDark.textPrimary
                          : AppColorsLight.textPrimary),
                ),
              ),
            ),
            if (showTrailingIcon)
              Icon(
                Icons.chevron_right,
                color: isDark
                    ? AppColorsDark.textTertiary
                    : AppColorsLight.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}
