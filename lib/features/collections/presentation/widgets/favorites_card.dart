import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';

/// Featured Favorites card displayed at the top of Collections screen
class FavoritesCard extends StatelessWidget {
  final int quoteCount;
  final VoidCallback? onTap;

  const FavoritesCard({super.key, required this.quoteCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              colorScheme.primary.withValues(alpha: 0.8),
              colorScheme.primary,
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
                color: colorScheme.onPrimary.withValues(alpha: 0.1),
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
                        color: colorScheme.onPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          CollectionsConstants.featured,
                          style: AppTypography.labelSmall(
                            color: colorScheme.onPrimary,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    CollectionsConstants.favorites,
                    style: AppTypography.displayLarge(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Quote count
                  Text(
                    '$quoteCount ${CollectionsConstants.savedQuotes}',
                    style: AppTypography.bodyMedium(
                      color: colorScheme.onPrimary.withValues(alpha: 0.7),
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
                  color: colorScheme.onPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: colorScheme.primary,
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
