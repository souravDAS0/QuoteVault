import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Gradient template for sharing quotes
/// Vibrant gradient background
class QuoteCardTemplateGradient extends StatelessWidget {
  final Quote quote;
  final bool isDark;

  const QuoteCardTemplateGradient({
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
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColorsDark.secondary,
                    AppColorsDark.primaryNavy,
                    AppColorsDark.accentTeal.withValues(alpha: 0.7),
                  ]
                : [
                    AppColorsLight.secondary,
                    AppColorsLight.primaryNavy,
                    AppColorsLight.accentTeal.withValues(alpha: 0.8),
                  ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  quote.categoryName.toUpperCase(),
                  style: AppTypography.caption(
                    color: Colors.white,
                  ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
                ),
              ),
              const SizedBox(height: 32),
              // Quote text
              Text(
                quote.text,
                style: AppTypography.headlineLarge(
                  color: Colors.white,
                ).copyWith(fontSize: 26, height: 1.4),
                maxLines: 5,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 32),
              // Author name
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    quote.authorName,
                    style: AppTypography.bodyLarge(
                      color: Colors.white,
                    ).copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
