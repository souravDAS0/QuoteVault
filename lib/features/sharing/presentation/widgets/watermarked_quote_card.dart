import 'package:flutter/material.dart';
import 'package:quote_vault/features/sharing/presentation/widgets/quote_card_watermark.dart';
import 'package:quote_vault/features/sharing/presentation/widgets/template_scale_helper.dart';

/// Reusable Watermarked Card.
/// Needs a [decoration], [child], [width] and [height].
class WatermarkedQuoteCard extends StatelessWidget {
  final double width;
  final double height;
  final BoxDecoration decoration;

  /// child is the content of the quote card (i.e. optimally a Column)
  final Widget child;

  /// Reusable Watermarked Card
  /// Needs a [decoration], [child], [width] and [height].
  const WatermarkedQuoteCard({
    super.key,
    required this.decoration,
    required this.child,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate scale factor based on width
    final scale = TemplateScaleHelper.calculateScale(width);

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        decoration: decoration,
        padding: EdgeInsets.all(32 * scale),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(child: child),
            SizedBox(height: 16 * scale),
            // Watermark
            Align(
              alignment: Alignment.centerRight,
              child: QuoteCardWatermark(color: Colors.white70, scale: scale),
            ),
          ],
        ),
      ),
    );
  }
}
