import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Minimal template for sharing quotes
/// Clean, simple design with white background
class QuoteCardTemplateMinimal extends StatelessWidget {
  final Quote quote;
  final bool isDark;

  const QuoteCardTemplateMinimal({
    super.key,
    required this.quote,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: 400,
        height: 500,
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColorsDark.border : AppColorsLight.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quote text with quotation mark
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u201C',
                      style: AppTypography.displayLarge(
                        color: isDark
                            ? AppColorsDark.accentTeal
                            : AppColorsLight.accentTeal,
                      ).copyWith(fontSize: 64, height: 1),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Text(
                        quote.text,
                        style: AppTypography.bodyLarge(
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ).copyWith(fontSize: 20, height: 1.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 40, color: Colors.transparent),
              // Author name
              Text(
                '\u2014 ${quote.authorName.toUpperCase()}',
                style:
                    AppTypography.caption(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColorsLight.textSecondary,
                    ).copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
