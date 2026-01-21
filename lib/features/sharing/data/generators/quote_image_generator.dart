import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../../home_feed/domain/entities/quote.dart';
import '../../domain/entities/share_template.dart';
import '../../domain/entities/share_destination.dart';
import '../../presentation/widgets/quote_card_template_classic.dart';
import '../../presentation/widgets/quote_card_template_minimal.dart';
import '../../presentation/widgets/quote_card_template_gradient.dart';

/// Generates images from quote templates
/// This class bridges the data and presentation layers for image generation
class QuoteImageGenerator {
  final ScreenshotController _screenshotController = ScreenshotController();

  /// Generate image bytes from quote and template
  /// Returns null if generation fails
  Future<Uint8List?> generateImage(
    Quote quote,
    ShareTemplate template,
    ShareDestination destination, {
    required ColorScheme colorScheme,
  }) async {
    try {
      // Get the appropriate template widget
      final widget = getTemplateWidget(
        quote,
        template,
        destination,
        colorScheme,
      );

      // Debug logging to verify dimensions
      debugPrint('=== Image Generation Debug ===');
      debugPrint('Destination: ${destination.runtimeType}');
      debugPrint('Physical: ${destination.width}×${destination.height}');
      debugPrint(
        'Logical: ${destination.logicalWidth}×${destination.logicalHeight}',
      );
      debugPrint('PixelRatio: ${destination.pixelRatio}');
      debugPrint('=============================');

      // Capture the widget as an image
      final imageBytes = await _screenshotController.captureFromWidget(
        widget,
        pixelRatio: destination.pixelRatio, // Use destination's pixelRatio
        delay: const Duration(milliseconds: 100),
      );

      return imageBytes;
    } catch (e) {
      // Return null if generation fails
      return null;
    }
  }

  /// Get the appropriate template widget for the given template type
  Widget getTemplateWidget(
    Quote quote,
    ShareTemplate template,
    ShareDestination destination,
    ColorScheme colorScheme,
  ) {
    return template.map(
      classic: (_) => QuoteCardTemplateClassic(
        quote: quote,
        colorScheme: colorScheme,
        width: destination.logicalWidth,
        height: destination.logicalHeight,
      ),
      minimal: (_) => QuoteCardTemplateMinimal(
        quote: quote,
        colorScheme: colorScheme,
        width: destination.logicalWidth,
        height: destination.logicalHeight,
      ),
      gradient: (_) => QuoteCardTemplateGradient(
        quote: quote,
        colorScheme: colorScheme,
        width: destination.logicalWidth,
        height: destination.logicalHeight,
      ),
    );
  }
}
