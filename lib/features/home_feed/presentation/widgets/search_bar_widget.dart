import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/home_feed_constants.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool showBackButton;
  final VoidCallback? onBack;
  final FocusNode? focusNode;

  const SearchBarWidget({
    super.key,
    this.onTap,
    this.readOnly = true,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.showBackButton = false,
    this.onBack,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        if (showBackButton) ...[
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back,
              color: isDark
                  ? AppColorsDark.textPrimary
                  : AppColorsLight.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: GestureDetector(
            onTap: readOnly ? onTap : null,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    readOnly: readOnly,
                    enabled: !readOnly,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    onTapOutside: (event) => focusNode?.unfocus(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColorsLight.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: HomeFeedConstants.searchHint,
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: isDark
                                ? AppColorsDark.textTertiary
                                : AppColorsLight.textTertiary,
                          ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDark
                            ? AppColorsDark.textTertiary
                            : AppColorsLight.textTertiary,
                        size: 20,
                      ),
                      suffixIcon:
                          !readOnly && controller?.text.isNotEmpty == true
                          ? GestureDetector(
                              onTap: onClear,
                              child: Icon(
                                Icons.close,
                                color: isDark
                                    ? AppColorsDark.textTertiary
                                    : AppColorsLight.textTertiary,
                                size: 20,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: isDark
                          ? AppColorsDark.surface
                          : AppColorsLight.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.border
                              : AppColorsLight.border,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.border
                              : AppColorsLight.border,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.accentTeal
                              : AppColorsLight.accentTeal,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColorsDark.error
                              : AppColorsLight.error,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
