import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Quote card displayed in collection details screen
/// Different styling from home feed QuoteCard
class CollectionQuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback? onCopy;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;

  const CollectionQuoteCard({
    super.key,
    required this.quote,
    this.onCopy,
    this.onShare,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Accent bar on left
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColorsDark.accentTeal
                    : AppColorsLight.accentTeal,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote text with quotation mark
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\u201C',
                          style: AppTypography.displayLarge(
                            color: isDark
                                ? AppColorsDark.accentTeal
                                : AppColorsLight.accentTeal,
                          ).copyWith(fontSize: 28, height: 1),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              quote.text,
                              style: AppTypography.bodyLarge(
                                color: isDark
                                    ? AppColorsDark.textPrimary
                                    : AppColorsLight.textPrimary,
                              ).copyWith(height: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Divider
                    Divider(
                      height: 1,
                      color: isDark
                          ? AppColorsDark.divider
                          : AppColorsLight.divider,
                    ),
                    const SizedBox(height: 12),
                    // Author and actions row
                    Row(
                      children: [
                        // Author name
                        Expanded(
                          child: Text(
                            '\u2014 ${quote.authorName.toUpperCase()}',
                            style: AppTypography.caption(
                              color: isDark
                                  ? AppColorsDark.textSecondary
                                  : AppColorsLight.textSecondary,
                            ).copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        // Action buttons
                        _ActionButton(
                          icon: Icons.copy_outlined,
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: '"${quote.text}" - ${quote.authorName}',
                              ),
                            );
                            if (onCopy != null) onCopy!();
                          },
                          isDark: isDark,
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.share_outlined,
                          onTap: onShare,
                          isDark: isDark,
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.delete_outline,
                          onTap: onDelete,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDark;

  const _ActionButton({
    required this.icon,
    this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.background
              : AppColorsLight.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDark
              ? AppColorsDark.textSecondary
              : AppColorsLight.textSecondary,
        ),
      ),
    );
  }
}
