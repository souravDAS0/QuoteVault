import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../domain/entities/quote.dart';

class SearchQuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback? onFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onShare;

  const SearchQuoteCard({
    super.key,
    required this.quote,
    this.onFavorite,
    this.onTap,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (quote.isFeatured) {
      return _buildFeaturedSearchCard(context, isDark);
    }

    return _buildSimpleSearchCard(context, isDark);
  }

  Widget _buildFeaturedSearchCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark
                  ? AppColorsDark.secondary.withValues(alpha: 0.8)
                  : AppColorsLight.secondary.withValues(alpha: 0.8),
              isDark ? AppColorsDark.primaryNavy : AppColorsLight.primaryNavy,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColorsDark.accentTeal.withValues(alpha: 0.3)
                        : AppColorsLight.accentTeal.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Featured',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isDark
                              ? AppColorsDark.accentTeal
                              : AppColorsLight.accentTeal,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: onFavorite,
                  child: Icon(
                    quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '"${quote.text}"',
              style: AppTypography.headlineMedium(color: Colors.white),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildAuthorAvatar(context),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    quote.authorName,
                    style: AppTypography.bodyMedium(
                      color: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal,
                    ),
                  ),
                ),
                if (onShare != null)
                  GestureDetector(
                    onTap: onShare,
                    child: const Icon(
                      Icons.share,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleSearchCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.surface.withValues(alpha: 0.8)
              : AppColorsLight.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? AppColorsDark.border : AppColorsLight.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"${quote.text}"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  quote.authorName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                GestureDetector(
                  onTap: onFavorite,
                  child: Icon(
                    quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar(BuildContext context) {
    final initials = quote.authorName
        .split(' ')
        .take(2)
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join();

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTypography.caption(color: Colors.white)
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
