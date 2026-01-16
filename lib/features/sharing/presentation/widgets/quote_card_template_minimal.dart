import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Minimal template for sharing quotes
/// Clean, simple design with white background
class QuoteCardTemplateMinimal extends StatelessWidget {
  final Quote quote;
  final ColorScheme colorScheme;

  const QuoteCardTemplateMinimal({
    super.key,
    required this.quote,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: 400,
        height: 500,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline, width: 1),
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
                        color: colorScheme.tertiary,
                      ).copyWith(fontSize: 64, height: 1),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Text(
                        quote.text,
                        style: AppTypography.bodyLarge(
                          color: colorScheme.onSurface,
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
                      color: colorScheme.onSurfaceVariant,
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
