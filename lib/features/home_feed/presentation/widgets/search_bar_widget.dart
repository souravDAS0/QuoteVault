import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;

    return Row(
      children: [
        if (showBackButton) ...[
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
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
                    cursorColor: primaryColor,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    onTapOutside: (event) => focusNode?.unfocus(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: HomeFeedConstants.searchHint,
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                        size: 20,
                      ),
                      suffixIcon:
                          !readOnly && controller?.text.isNotEmpty == true
                          ? GestureDetector(
                              onTap: onClear,
                              child: Icon(
                                Icons.close,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                                size: 20,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.error,
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
