import 'package:flutter/material.dart';
import 'package:quote_vault/features/sharing/presentation/widgets/watermarked_quote_card.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';
import 'template_scale_helper.dart';

/// Classic template for sharing quotes
/// Gradient background with quote mark icon
class QuoteCardTemplateClassic extends StatelessWidget {
  final Quote quote;
  final ColorScheme colorScheme;
  final double width;
  final double height;

  const QuoteCardTemplateClassic({
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
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * scale),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface.withValues(alpha: 0.8),
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
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          // Quote mark
          Icon(
            Icons.format_quote_rounded,
            size: 48 * scale,
            color: colorScheme.tertiary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16 * scale),
          // Quote text
          Text(
            quote.text,
            style: AppTypography.headlineLarge(
              color: Colors.white,
            ).copyWith(fontSize: 28 * scale),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8 * scale),
          Divider(color: Colors.white24, height: 20 * scale, thickness: scale),
          // Author name
          Text(
            quote.authorName,
            style: AppTypography.bodyLarge(
              color: Colors.white,
            ).copyWith(fontSize: 18 * scale),
          ),
        ],
      ),
    );
  }
}
