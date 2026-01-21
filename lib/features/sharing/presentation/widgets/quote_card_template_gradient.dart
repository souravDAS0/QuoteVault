import 'package:flutter/material.dart';
import 'package:quote_vault/features/sharing/presentation/widgets/watermarked_quote_card.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';
import 'template_scale_helper.dart';

/// Gradient template for sharing quotes
/// Vibrant gradient background
class QuoteCardTemplateGradient extends StatelessWidget {
  final Quote quote;
  final ColorScheme colorScheme;
  final double width;
  final double height;

  const QuoteCardTemplateGradient({
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

    // Check if using a dark theme (dark, blue, violet all use Brightness.dark)
    final isDarkTheme = colorScheme.brightness == Brightness.dark;

    return WatermarkedQuoteCard(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.5)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkTheme
              ? [
                  // Dark themes (dark, blue, violet): use semi-transparent colors
                  colorScheme.primary.withValues(alpha: 0.9),
                  colorScheme.secondary.withValues(alpha: 0.9),
                  colorScheme.primary.withValues(alpha: 0.6),
                  colorScheme.secondary.withValues(alpha: 0.6),
                  colorScheme.primary.withValues(alpha: 0.6),
                  colorScheme.secondary.withValues(alpha: 0.6),
                ]
              : [
                  // Light theme: use opaque colors blended with white
                  // This prevents darkening in screenshots
                  Color.lerp(colorScheme.outlineVariant, Colors.white, 0.1)!,
                  Color.lerp(colorScheme.surface, Colors.white, 0.1)!,
                  Color.lerp(colorScheme.outlineVariant, Colors.white, 0.4)!,
                  Color.lerp(colorScheme.surface, Colors.white, 0.4)!,
                  Color.lerp(colorScheme.outlineVariant, Colors.white, 0.4)!,
                  Color.lerp(colorScheme.surface, Colors.white, 0.4)!,
                ],
        ),
      ),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        children: [
          // Quote icon
          Icon(
            Icons.format_quote,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
            size: 40 * scale,
          ),
          SizedBox(height: 32 * scale),
          // Quote text
          Text(
            quote.text,
            style: AppTypography.headlineLarge(
              color: colorScheme.onSurface,
            ).copyWith(fontSize: 26 * scale, height: 1.4),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 32 * scale),
          // Author name
          Row(
            children: [
              Container(
                width: 4 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2 * scale),
                ),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Text(
                  quote.authorName,
                  style: AppTypography.bodyLarge(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ).copyWith(fontSize: 18 * scale, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
