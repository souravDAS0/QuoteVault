import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';

/// Featured Favorites card displayed at the top of Collections screen
class FavoritesCard extends StatelessWidget {
  final int quoteCount;
  final VoidCallback? onTap;

  const FavoritesCard({
    super.key,
    required this.quoteCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark
                  ? AppColorsDark.primaryNavy.withValues(alpha: 0.9)
                  : AppColorsLight.primaryNavy.withValues(alpha: 0.9),
              isDark ? AppColorsDark.primaryNavy : AppColorsLight.primaryNavy,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative heart shape in background
            Positioned(
              top: -20,
              right: -20,
              child: Icon(
                Icons.favorite,
                size: 200,
                color: Colors.red.withValues(alpha: 0.15),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Featured badge row
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: isDark
                            ? AppColorsDark.accentTeal
                            : AppColorsLight.accentTeal,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColorsDark.accentTeal.withValues(alpha: 0.2)
                              : AppColorsLight.accentTeal.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          CollectionsConstants.featured,
                          style: AppTypography.labelSmall(
                            color: isDark
                                ? AppColorsDark.accentTeal
                                : AppColorsLight.accentTeal,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    CollectionsConstants.favorites,
                    style: AppTypography.displayLarge(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  // Quote count
                  Text(
                    '$quoteCount ${CollectionsConstants.savedQuotes}',
                    style: AppTypography.bodyMedium(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow icon
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: isDark
                      ? AppColorsDark.primaryNavy
                      : AppColorsLight.primaryNavy,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
