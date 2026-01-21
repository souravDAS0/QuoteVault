import 'package:flutter/material.dart';
import 'package:quote_vault/core/constants/asset_constants.dart';

/// Reusable watermark widget displaying QuoteVault logo and text
/// Used across all quote card templates for branding
class QuoteCardWatermark extends StatelessWidget {
  /// Creates a watermark with customizable color and scale
  const QuoteCardWatermark({
    super.key,
    this.color = Colors.white70,
    this.scale = 1.0,
  });

  /// Color of the watermark text
  final Color color;

  /// Scale factor for sizing (multiplies base dimensions)
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo image
        Image.asset(
          AssetConstants.logoNoBg,
          width: 20 * scale,
          height: 20 * scale,
          fit: BoxFit.contain,
          colorBlendMode: BlendMode.srcIn,
          color: color,
        ),
        SizedBox(width: 6 * scale),
        // App name text
        Text(
          AssetConstants.appName,
          style: TextStyle(
            color: color,
            fontSize: 10 * scale,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2 * scale,
          ),
        ),
      ],
    );
  }
}
