/// Helper class for calculating scale factors and layout properties
/// for quote card templates across different share destinations.
///
/// Provides centralized logic for:
/// - Scale calculation based on logical width
/// - Maximum lines calculation based on logical height
class TemplateScaleHelper {
  /// Baseline width used for scale calculations (WhatsApp status width)
  static const double baselineWidth = 400.0;

  /// Calculates the scale factor for a given logical width.
  ///
  /// Scale is proportional to width relative to baseline, clamped between 0.5x and 3.0x.
  /// This ensures text and UI elements scale appropriately for different destinations.
  ///
  /// Examples:
  /// - 400px logical → 1.0x scale (baseline)
  /// - 360px logical → 0.9x scale (Instagram at 3× pixelRatio)
  /// - 200px logical → 0.5x scale (minimum)
  static double calculateScale(double logicalWidth) {
    return (logicalWidth / baselineWidth).clamp(0.5, 3.0);
  }

  /// Calculates the maximum number of lines for quote text based on logical height.
  ///
  /// Taller destinations get more lines to maintain readability and fill space.
  ///
  /// Height ranges:
  /// - >800px: 12 lines
  /// - 600-800px: 10 lines
  /// - 500-600px: 8 lines
  /// - <500px: 6 lines
  static int calculateMaxLines(double logicalHeight) {
    if (logicalHeight > 800) return 12;
    if (logicalHeight > 600) return 10;
    if (logicalHeight > 500) return 8;
    return 6;
  }
}
