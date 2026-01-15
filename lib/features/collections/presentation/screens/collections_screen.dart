import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refresh,
          color: colorScheme.primary,
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    CollectionsConstants.myCollections,
                    style: AppTypography.displayLarge(
                      color: colorScheme.onSurface,
                    ),
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
                          color: colorScheme.onBackground,
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
                          color: colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.errorMessage!,
                          style: AppTypography.bodyMedium(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
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
                    delegate: SliverChildBuilderDelegate((context, index) {
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
                          context.push('/collections/${collection.id}');
                        },
                        onLongPress: () {
                          _showDeleteConfirmation(
                            context,
                            controller,
                            collection.id,
                            collection.name,
                            colorScheme,
                          );
                        },
                      );
                    }, childCount: state.collections.length + 1),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      // FAB for creating new collection
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context, controller),
        backgroundColor: colorScheme.secondary,
        child: Icon(Icons.add, color: colorScheme.onSecondary),
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
    ColorScheme colorScheme,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          CollectionsConstants.deleteCollectionTitle,
          style: AppTypography.headlineLarge(color: colorScheme.onSurface),
        ),
        content: Text(
          CollectionsConstants.deleteCollectionMessage,
          style: AppTypography.bodyMedium(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              CollectionsConstants.cancel,
              style: AppTypography.bodyMedium(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteCollection(collectionId);
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              CollectionsConstants.delete,
              style: AppTypography.bodyMedium(color: colorScheme.onError),
            ),
          ),
        ],
      ),
    );
  }
}
