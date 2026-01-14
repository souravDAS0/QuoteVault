import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool hasError;
  final FocusNode? focusNode;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.hasError = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = hasError
        ? (isDark ? AppColorsDark.error : AppColorsLight.error)
        : (isDark ? AppColorsDark.border : AppColorsLight.border);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: isDark
              ? AppColorsDark.accentTeal
              : AppColorsLight.accentTeal,
          onChanged: onChanged,
          keyboardType: keyboardType,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColorsDark.textTertiary
                  : AppColorsLight.textTertiary,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? AppColorsDark.surface : AppColorsLight.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark
                    ? AppColorsDark.accentTeal
                    : AppColorsLight.accentTeal,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColorsDark.error : AppColorsLight.error,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
