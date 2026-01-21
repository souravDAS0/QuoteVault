import 'package:flutter/material.dart';
import 'package:quote_vault/features/sharing/presentation/widgets/watermarked_quote_card.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';
import 'template_scale_helper.dart';

/// Minimal template for sharing quotes
/// Clean, simple design with white background
class QuoteCardTemplateMinimal extends StatelessWidget {
  final Quote quote;
  final ColorScheme colorScheme;
  final double width;
  final double height;

  const QuoteCardTemplateMinimal({
    super.key,
    required this.quote,
    required this.colorScheme,
    this.width = 400,
    this.height = 500,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scale factor based on width
    final scale = TemplateScaleHelper.calculateScale(width);
    final maxLines = TemplateScaleHelper.calculateMaxLines(height);

    return WatermarkedQuoteCard(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface.withValues(alpha: 0.8),
            colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: colorScheme.outline, width: 1 * scale),
      ),
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          Text(
            '\u201C',
            style: AppTypography.displayLarge(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ).copyWith(fontSize: 64 * scale, height: 1),
          ),
          SizedBox(height: 16 * scale),
          Text(
            quote.text,
            style: AppTypography.bodyLarge(
              color: colorScheme.onSurface,
            ).copyWith(fontSize: 20 * scale, height: 1.6),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(height: 80 * scale, color: Colors.transparent),
          // Author name
          Text(
            '\u2014 ${quote.authorName.toUpperCase()}',
            style: AppTypography.caption(color: colorScheme.onSurfaceVariant)
                .copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5 * scale,
                  fontSize: 14 * scale,
                ),
          ),
        ],
      ),
    );
  }
}
