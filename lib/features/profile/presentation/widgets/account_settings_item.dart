import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isLogout
                ? colorScheme.error.withValues(alpha: 0.3)
                : colorScheme.primary.withValues(alpha: 0.4),
          ),
          color: isLogout
              ? colorScheme.errorContainer.withValues(alpha: 0.1)
              : colorScheme.surface,
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
                    colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: iconColor ?? colorScheme.primary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor ?? colorScheme.onSurface,
                ),
              ),
            ),
            if (showTrailingIcon)
              Icon(Icons.chevron_right, color: colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}
