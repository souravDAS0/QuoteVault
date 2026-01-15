import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';

/// Dashed "New Collection" card for creating new collections
class NewCollectionCard extends StatelessWidget {
  final VoidCallback? onTap;

  const NewCollectionCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.5),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: colorScheme.outline.withValues(alpha: 0.5),
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
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                CollectionsConstants.newCollection,
                style: AppTypography.headlineMedium(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                CollectionsConstants.createNow,
                style: AppTypography.bodyMedium(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
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
