import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../domain/entities/quote.dart';
import '../../../settings/application/controllers/settings_controller.dart';

class QuoteCard extends ConsumerWidget {
  final Quote quote;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCollection;
  final VoidCallback? onDelete;

  const QuoteCard({
    super.key,
    required this.quote,
    this.onFavorite,
    this.onShare,
    this.onCopy,
    this.onTap,
    this.onAddToCollection,
    this.onDelete,
  });

  @override
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsControllerProvider).settings;

    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface.withValues(alpha: 0.8),
              colorScheme.surface,
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
                    color: colorScheme.tertiary,
                  ),
                  _buildCategoryTag(context),
                ],
              ),

              const SizedBox(height: 8),
              // Quote text
              Text(
                quote.text,
                style: AppTypography.headlineLarge(
                  color: colorScheme.onSurface,
                ).copyWith(fontSize: settings.fontSizePreset.value),
              ),
              Divider(
                color: colorScheme.onSurface.withValues(alpha: 0.24),
                height: 32,
              ),
              Row(
                children: [
                  // Author avatar
                  _buildAuthorAvatar(context, light: true),
                  const SizedBox(width: 12),
                  // Author name
                  Expanded(
                    child: Text(
                      quote.authorName,
                      style: AppTypography.bodyLarge(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  // Like count
                  GestureDetector(
                    onTap: onFavorite,
                    child: Icon(
                      quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: colorScheme.tertiary,
                      size: 20,
                    ),
                  ),
                  if (onAddToCollection != null) ...[
                    const SizedBox(width: 16),
                    // Add to collection
                    GestureDetector(
                      onTap: onAddToCollection,
                      child: Icon(
                        quote.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ],

                  const SizedBox(width: 16),
                  // Share
                  GestureDetector(
                    onTap: onShare,
                    child: Icon(
                      Icons.share,
                      color: colorScheme.onSurface,
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
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                  ),
                  if (onDelete != null) ...[
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete_outline,
                        color: colorScheme.error.withValues(alpha: 0.7),
                        size: 20,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTag(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        quote.categoryName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.tertiary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar(BuildContext context, {bool light = false}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
            ? colorScheme.onSurface.withValues(alpha: 0.2)
            : colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: light
              ? colorScheme.onSurface.withValues(alpha: 0.3)
              : colorScheme.outline,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTypography.caption(
            color: light ? colorScheme.onSurface : colorScheme.onPrimary,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
