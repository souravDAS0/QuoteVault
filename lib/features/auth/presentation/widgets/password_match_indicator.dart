import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';

class PasswordMatchIndicator extends StatelessWidget {
  final bool passwordsMatch;
  final bool showIndicator;

  const PasswordMatchIndicator({
    super.key,
    required this.passwordsMatch,
    required this.showIndicator,
  });

  @override
  Widget build(BuildContext context) {
    if (!showIndicator) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          passwordsMatch ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: passwordsMatch
              ? (isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal)
              : (isDark ? AppColorsDark.error : AppColorsLight.error),
        ),
        const SizedBox(width: 8),
        Text(
          passwordsMatch
              ? AuthConstants.passwordsMatch
              : AuthConstants.passwordsDoNotMatch,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: passwordsMatch
                ? (isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal)
                : (isDark ? AppColorsDark.error : AppColorsLight.error),
          ),
        ),
      ],
    );
  }
}
