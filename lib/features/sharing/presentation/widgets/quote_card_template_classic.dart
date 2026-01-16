import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Classic template for sharing quotes
/// Gradient background with quote mark icon
class QuoteCardTemplateClassic extends StatelessWidget {
  final Quote quote;
  final ColorScheme colorScheme;

  const QuoteCardTemplateClassic({
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
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withValues(alpha: 0.8),
              colorScheme.primary,
            ],
          ),
          image: quote.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(quote.imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.4),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quote mark
              Icon(
                Icons.format_quote_rounded,
                size: 48,
                color: colorScheme.tertiary,
              ),
              const SizedBox(height: 24),
              // Quote text
              Expanded(
                child: Text(
                  quote.text,
                  style: AppTypography.headlineLarge(
                    color: Colors.white,
                  ).copyWith(fontSize: 28),
                  maxLines: 6,
                  overflow: TextOverflow.visible,
                ),
              ),
              const Divider(color: Colors.white24, height: 40),
              // Author name
              Text(
                quote.authorName,
                style: AppTypography.bodyLarge(
                  color: Colors.white,
                ).copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
