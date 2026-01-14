import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';

class PasswordRequirementsCard extends StatelessWidget {
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSymbol;

  const PasswordRequirementsCard({
    super.key,
    required this.hasMinLength,
    required this.hasNumber,
    required this.hasSymbol,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColorsDark.border : AppColorsLight.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthConstants.requirementsTitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColorsLight.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 12),
          _RequirementItem(
            text: AuthConstants.requirement8Chars,
            isMet: hasMinLength,
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _RequirementItem(
            text: AuthConstants.requirementNumber,
            isMet: hasNumber,
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _RequirementItem(
            text: AuthConstants.requirementSymbol,
            isMet: hasSymbol,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;
  final bool isDark;

  const _RequirementItem({
    required this.text,
    required this.isMet,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 20,
          color: isMet
              ? (isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal)
              : (isDark
                  ? AppColorsDark.textTertiary
                  : AppColorsLight.textTertiary),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
        ),
      ],
    );
  }
}
