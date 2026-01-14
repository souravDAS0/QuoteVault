import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';
import '../../application/controllers/collection_details_controller.dart';
import '../widgets/collection_quote_card.dart';
import '../widgets/add_quote_sheet.dart';
import '../../../sharing/presentation/screens/share_quote_sheet.dart';

/// Collection details screen showing quotes in a collection
/// Also used for Favorites when [isFavorites] is true
class CollectionDetailsScreen extends ConsumerWidget {
  final String? collectionId;
  final bool isFavorites;

  const CollectionDetailsScreen({
    super.key,
    this.collectionId,
    this.isFavorites = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use different controller for favorites vs regular collections
    if (isFavorites) {
      return _buildFavoritesScreen(context, ref, isDark);
    }

    if (collectionId == null) {
      return const Scaffold(body: Center(child: Text('Collection not found')));
    }

    return _buildCollectionScreen(context, ref, isDark, collectionId!);
  }

  Widget _buildFavoritesScreen(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    final state = ref.watch(favoritesControllerProvider);
    final controller = ref.read(favoritesControllerProvider.notifier);

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      appBar: _buildAppBar(
        context,
        isDark,
        title: CollectionsConstants.favorites,
        subtitle: '${state.totalCount} ${CollectionsConstants.quotes}',
        showEditButton: false,
        onEdit: null,
        isFavourites: true,
        isLoading: state.isLoading,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? _buildErrorState(state.errorMessage!, controller.refresh, isDark)
          : state.quotes.isEmpty
          ? _buildEmptyState(
              CollectionsConstants.noFavorites,
              CollectionsConstants.startFavoriting,
              isDark,
            )
          : RefreshIndicator(
              onRefresh: controller.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.quotes.length + (state.hasReachedEnd ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == state.quotes.length) {
                    // Load more indicator
                    controller.loadMore();
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final quote = state.quotes[index];
                  return CollectionQuoteCard(
                    quote: quote,
                    onCopy: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(CollectionsConstants.quoteCopied),
                        ),
                      );
                    },
                    onShare: () {
                      ShareQuoteSheet.show(context, quote: quote);
                    },
                    onDelete: null, // Can't delete from favorites here
                  );
                },
              ),
            ),
    );
  }

  Widget _buildCollectionScreen(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
    String collectionId,
  ) {
    final state = ref.watch(collectionDetailsControllerProvider(collectionId));
    final controller = ref.read(
      collectionDetailsControllerProvider(collectionId).notifier,
    );

    final createdDate = state.collection?.createdAt != null
        ? DateFormat('MMM d').format(state.collection!.createdAt!)
        : '';

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      appBar: _buildAppBar(
        context,
        isDark,
        title: state.collection?.name ?? '',
        subtitle:
            '${state.collection?.quoteCount ?? 0} ${CollectionsConstants.quotes} \u2022 ${CollectionsConstants.createdOn} $createdDate',
        showEditButton: true,
        onEdit: () => _showRenameDialog(
          context,
          controller,
          state.collection?.name ?? '',
        ),
        isFavourites: false,
        isLoading: state.isLoading,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? _buildErrorState(state.errorMessage!, controller.refresh, isDark)
          : state.quotes.isEmpty
          ? _buildEmptyState(
              CollectionsConstants.noQuotesInCollection,
              CollectionsConstants.addQuotesToCollection,
              isDark,
            )
          : RefreshIndicator(
              onRefresh: controller.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                itemCount: state.quotes.length + (state.hasReachedEnd ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == state.quotes.length) {
                    // Load more indicator
                    controller.loadMore();
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final quote = state.quotes[index];
                  return CollectionQuoteCard(
                    quote: quote,
                    onCopy: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(CollectionsConstants.quoteCopied),
                        ),
                      );
                    },
                    onShare: () {
                      ShareQuoteSheet.show(context, quote: quote);
                    },
                    onDelete: () {
                      _showRemoveQuoteConfirmation(
                        context,
                        controller,
                        quote.id,
                        isDark,
                      );
                    },
                  );
                },
              ),
            ),
      floatingActionButton: isFavorites
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                final result = await AddQuoteSheet.show(
                  context,
                  collectionId: collectionId,
                  onComplete: () {
                    ref
                        .read(
                          collectionDetailsControllerProvider(
                            collectionId,
                          ).notifier,
                        )
                        .refresh();
                  },
                );
                if (result == true) {
                  ref
                      .read(
                        collectionDetailsControllerProvider(
                          collectionId,
                        ).notifier,
                      )
                      .refresh();
                }
              },
              backgroundColor: isDark
                  ? AppColorsDark.accentTeal
                  : AppColorsLight.accentTeal,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                CollectionsConstants.addQuote,
                style: AppTypography.bodyMedium(color: Colors.white),
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    bool isDark, {
    required String title,
    required String subtitle,
    required bool showEditButton,
    required VoidCallback? onEdit,
    required bool isFavourites,
    required bool isLoading,
  }) {
    return AppBar(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isDark
              ? AppColorsDark.textPrimary
              : AppColorsLight.textPrimary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: (!isFavourites && isLoading)
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: AppTypography.headlineLarge(
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (showEditButton) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onEdit,
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: isDark
                              ? AppColorsDark.accentTeal
                              : AppColorsLight.accentTeal,
                        ),
                      ),
                    ],
                  ],
                ),
                !isLoading
                    ? Text(
                        subtitle,
                        style: AppTypography.caption(
                          color: isDark
                              ? AppColorsDark.textSecondary
                              : AppColorsLight.textSecondary,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
      actions: [
        // IconButton(
        //   icon: Icon(
        //     Icons.more_vert,
        //     color: isDark
        //         ? AppColorsDark.textPrimary
        //         : AppColorsLight.textPrimary,
        //   ),
        //   onPressed: () {
        //     // More options menu
        //   },
        // ),
      ],
    );
  }

  Widget _buildErrorState(String error, VoidCallback onRetry, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: isDark ? AppColorsDark.error : AppColorsLight.error,
          ),
          const SizedBox(height: 16),
          Text(
            error,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColorsDark.textSecondary
                  : AppColorsLight.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.collections_bookmark_outlined,
            size: 64,
            color: isDark
                ? AppColorsDark.textTertiary
                : AppColorsLight.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTypography.headlineMedium(
              color: isDark
                  ? AppColorsDark.textPrimary
                  : AppColorsLight.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColorsDark.textSecondary
                  : AppColorsLight.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    CollectionDetailsController controller,
    String currentName,
  ) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textController = TextEditingController(text: currentName);

    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppColorsDark.surface
            : AppColorsLight.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          CollectionsConstants.renameCollection,
          style: AppTypography.headlineLarge(
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          style: AppTypography.bodyLarge(
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
          decoration: InputDecoration(
            labelText: CollectionsConstants.collectionName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColorsDark.border : AppColorsLight.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark
                    ? AppColorsDark.accentTeal
                    : AppColorsLight.accentTeal,
                width: 2,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              CollectionsConstants.cancel,
              style: AppTypography.bodyMedium(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, textController.text),
            style: FilledButton.styleFrom(
              backgroundColor: isDark
                  ? AppColorsDark.accentTeal
                  : AppColorsLight.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              CollectionsConstants.save,
              style: AppTypography.bodyMedium(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty && newName != currentName) {
      await controller.updateCollectionName(newName);
    }
  }

  void _showRemoveQuoteConfirmation(
    BuildContext context,
    CollectionDetailsController controller,
    String quoteId,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark
            ? AppColorsDark.surface
            : AppColorsLight.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          CollectionsConstants.removeQuoteTitle,
          style: AppTypography.headlineLarge(
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
        ),
        content: Text(
          CollectionsConstants.removeQuoteMessage,
          style: AppTypography.bodyMedium(
            color: isDark
                ? AppColorsDark.textSecondary
                : AppColorsLight.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              CollectionsConstants.cancel,
              style: AppTypography.bodyMedium(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              controller.removeQuote(quoteId);
            },
            style: FilledButton.styleFrom(
              backgroundColor: isDark
                  ? AppColorsDark.error
                  : AppColorsLight.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              CollectionsConstants.delete,
              style: AppTypography.bodyMedium(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
