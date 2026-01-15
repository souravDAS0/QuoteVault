import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_vault/features/settings/application/controllers/settings_controller.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Quote card displayed in collection details screen
/// Different styling from home feed QuoteCard
class CollectionQuoteCard extends ConsumerWidget {
  final Quote quote;
  final VoidCallback? onCopy;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;

  const CollectionQuoteCard({
    super.key,
    required this.quote,
    this.onCopy,
    this.onShare,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final settings = ref.watch(settingsControllerProvider).settings;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface.withValues(alpha: 0.8),
            colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 40,
                margin: const EdgeInsets.only(top: 20, left: 0),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quote.text,
                        style:
                            AppTypography.bodyLarge(
                              color: colorScheme.onSurface,
                            ).copyWith(
                              height: 1.5,
                              fontSize: settings.fontSizePreset.value,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '— ${quote.authorName}',
                        style: AppTypography.bodyMedium(
                          color: colorScheme.onSurface,
                        ).copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.copy_outlined,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: quote.text));
                    if (onCopy != null) onCopy!();
                  },
                  tooltip: 'Copy',
                ),
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: onShare,
                  tooltip: 'Share',
                ),
                if (onDelete != null)
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: colorScheme.error.withValues(alpha: 0.7),
                    ),
                    onPressed: onDelete,
                    tooltip: 'Remove',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
