import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? AppColorsDark.accentTeal : AppColorsLight.secondary,
          foregroundColor:
              isDark ? AppColorsDark.primaryNavy : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? AppColorsDark.primaryNavy : Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColorsDark.primaryNavy : Colors.white,
                    ),
              ),
      ),
    );
  }
}
