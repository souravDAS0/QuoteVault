import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../domain/entities/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final VoidCallback? onAddToCollection;

  const QuoteCard({
    super.key,
    required this.quote,
    this.onFavorite,
    this.onShare,
    this.onCopy,
    this.onTap,
    this.onMore,
    this.onAddToCollection,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDark
                  ? AppColorsDark.primaryNavy.withValues(alpha: 0.8)
                  : AppColorsLight.primaryNavy.withValues(alpha: 0.8),
              isDark ? AppColorsDark.primaryNavy : AppColorsLight.primaryNavy,
            ],
          ),
          image: quote.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(quote.imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.4),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quote mark
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.format_quote_rounded,
                    size: 36,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                  _buildCategoryTag(context),
                ],
              ),

              const SizedBox(height: 8),
              // Quote text
              Expanded(
                child: Text(
                  quote.text,
                  style: AppTypography.headlineLarge(color: Colors.white),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(color: Colors.white24, height: 32),
              Row(
                children: [
                  // Author avatar
                  _buildAuthorAvatar(context, light: true),
                  const SizedBox(width: 12),
                  // Author name
                  Expanded(
                    child: Text(
                      quote.authorName,
                      style: AppTypography.bodyLarge(color: Colors.white),
                    ),
                  ),
                  // Like count
                  GestureDetector(
                    onTap: onFavorite,
                    child: Icon(
                      quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add to collection
                  GestureDetector(
                    onTap: onAddToCollection,
                    child: Icon(
                      quote.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Share
                  GestureDetector(
                    onTap: onShare,
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 16),

                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: '"${quote.text}" - ${quote.authorName}',
                        ),
                      );
                      if (onCopy != null) onCopy!();
                    },
                    child: Icon(
                      Icons.copy,
                      color: isDark
                          ? AppColorsDark.textTertiary
                          : AppColorsLight.textTertiary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTag(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColorsDark.accentTeal.withValues(alpha: 0.2)
            : AppColorsLight.accentTeal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        quote.categoryName,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar(BuildContext context, {bool light = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final initials = quote.authorName
        .split(' ')
        .take(2)
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join();

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: light
            ? Colors.white.withValues(alpha: 0.2)
            : (isDark ? AppColorsDark.surface : AppColorsLight.surface),
        shape: BoxShape.circle,
        border: Border.all(
          color: light
              ? Colors.white30
              : (isDark ? AppColorsDark.border : AppColorsLight.border),
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTypography.caption(
            color: light
                ? Colors.white
                : (isDark
                      ? AppColorsDark.textPrimary
                      : AppColorsLight.textPrimary),
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
