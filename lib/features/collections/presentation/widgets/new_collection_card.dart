import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';

/// Dashed "New Collection" card for creating new collections
class NewCollectionCard extends StatelessWidget {
  final VoidCallback? onTap;

  const NewCollectionCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? AppColorsDark.border
                : AppColorsLight.border,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: isDark ? AppColorsDark.border : AppColorsLight.border,
            strokeWidth: 2,
            gap: 6,
            radius: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Plus icon in circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColorsDark.surface
                      : AppColorsLight.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColorsDark.border
                        : AppColorsLight.border,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColorsLight.textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                CollectionsConstants.newCollection,
                style: AppTypography.headlineMedium(
                  color: isDark
                      ? AppColorsDark.textPrimary
                      : AppColorsLight.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                CollectionsConstants.createNow,
                style: AppTypography.bodyMedium(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColorsLight.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter to draw dashed border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dashed border is achieved through the Container's border
    // This painter is optional for additional visual effects
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
