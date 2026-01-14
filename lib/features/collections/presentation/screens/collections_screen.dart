import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';
import '../../application/controllers/collections_controller.dart';
import '../widgets/favorites_card.dart';
import '../widgets/collection_card.dart';
import '../widgets/new_collection_card.dart';
import '../widgets/sort_by_button.dart';
import '../widgets/create_collection_dialog.dart';

/// My Collections screen displaying favorites and custom collections
class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectionsControllerProvider);
    final controller = ref.read(collectionsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refresh,
          color: isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal,
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CollectionsConstants.myCollections,
                        style: AppTypography.displayLarge(
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Settings action
                        },
                        icon: Icon(
                          Icons.settings_outlined,
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Favorites card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FavoritesCard(
                    quoteCount: state.favoritesCount,
                    onTap: () {
                      context.push(CollectionsConstants.favoritesRoute);
                    },
                  ),
                ),
              ),

              // Custom Collections header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CollectionsConstants.customCollections,
                        style: AppTypography.headlineMedium(
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ),
                      ),
                      SortByButton(
                        currentSort: state.sortBy,
                        onSortChanged: controller.setSortBy,
                      ),
                    ],
                  ),
                ),
              ),

              // Loading state
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              // Error state
              else if (state.errorMessage != null)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: isDark
                              ? AppColorsDark.error
                              : AppColorsLight.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.errorMessage!,
                          style: AppTypography.bodyMedium(
                            color: isDark
                                ? AppColorsDark.textSecondary
                                : AppColorsLight.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: controller.refresh,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              // Collections grid
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Last item is always "New Collection" card
                        if (index == state.collections.length) {
                          return NewCollectionCard(
                            onTap: () => _showCreateDialog(context, controller),
                          );
                        }

                        final collection = state.collections[index];
                        return CollectionCard(
                          collection: collection,
                          onTap: () {
                            context.push(
                              '/collections/${collection.id}',
                            );
                          },
                          onLongPress: () {
                            _showDeleteConfirmation(
                              context,
                              controller,
                              collection.id,
                              collection.name,
                              isDark,
                            );
                          },
                        );
                      },
                      childCount: state.collections.length + 1,
                    ),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
      // FAB for creating new collection
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, controller),
        backgroundColor:
            isDark ? AppColorsDark.secondary : AppColorsLight.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _showCreateDialog(
    BuildContext context,
    CollectionsController controller,
  ) async {
    final name = await CreateCollectionDialog.show(context);
    if (name != null && name.isNotEmpty) {
      await controller.createCollection(name: name);
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    CollectionsController controller,
    String collectionId,
    String collectionName,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColorsDark.surface : AppColorsLight.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          CollectionsConstants.deleteCollectionTitle,
          style: AppTypography.headlineLarge(
            color: isDark
                ? AppColorsDark.textPrimary
                : AppColorsLight.textPrimary,
          ),
        ),
        content: Text(
          CollectionsConstants.deleteCollectionMessage,
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
              controller.deleteCollection(collectionId);
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
