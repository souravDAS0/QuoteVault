import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quote_vault/core/config/theme/app_typography.dart';
import '../../../../core/constants/home_feed_constants.dart';
import '../../domain/entities/quote.dart';

class DailyQuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onAddToCollection;

  const DailyQuoteCard({
    super.key,
    required this.quote,
    required this.onFavorite,
    required this.onShare,
    required this.onCopy,
    required this.onAddToCollection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkTheme = colorScheme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkTheme
              ? [
                  colorScheme.primary.withValues(alpha: 0.9),
                  colorScheme.secondary.withValues(alpha: 0.9),
                  colorScheme.primary.withValues(alpha: 0.6),
                  colorScheme.secondary.withValues(alpha: 0.6),
                  colorScheme.primary.withValues(alpha: 0.6),
                  colorScheme.secondary.withValues(alpha: 0.6),
                ]
              : [
                  colorScheme.outlineVariant.withValues(alpha: 0.9),
                  colorScheme.surface.withValues(alpha: 0.9),
                  colorScheme.outlineVariant.withValues(alpha: 0.6),
                  colorScheme.surface.withValues(alpha: 0.6),
                  colorScheme.outlineVariant.withValues(alpha: 0.6),
                  colorScheme.surface.withValues(alpha: 0.6),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.wb_sunny_outlined,
                color: colorScheme.onSurface,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                HomeFeedConstants.quoteOfTheDay,
                style: AppTypography.bodyLarge().copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quote icon
          Icon(
            Icons.format_quote,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
            size: 40,
          ),
          const SizedBox(height: 8),

          Text(
            quote.text,
            style: AppTypography.headlineLarge().copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Author
          Text(
            '— ${quote.authorName}',
            style: AppTypography.bodyItalic().copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                label: quote.isFavorite ? 'Liked' : 'Like',
                onTap: onFavorite,
                color: quote.isFavorite ? Colors.red : colorScheme.onSurface,
              ),
              _ActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: onShare,
                color: colorScheme.onSurface,
              ),
              _ActionButton(
                icon: Icons.content_copy_outlined,
                label: 'Copy',
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: '${quote.text}\n— ${quote.authorName}'),
                  );
                  onCopy();
                },
                color: colorScheme.onSurface,
              ),
              _ActionButton(
                icon: Icons.bookmark_border_outlined,
                label: 'Save',
                onTap: onAddToCollection,
                color: colorScheme.onSurface,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
