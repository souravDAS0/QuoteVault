import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';
import '../../application/controllers/collections_controller.dart';
import '../../application/providers/collection_providers.dart';
import '../../domain/entities/collection.dart';
import 'create_collection_dialog.dart';

/// Bottom sheet for adding a quote to one or more collections
class AddToCollectionSheet extends ConsumerStatefulWidget {
  final String quoteId;
  final VoidCallback? onComplete;

  const AddToCollectionSheet({
    super.key,
    required this.quoteId,
    this.onComplete,
  });

  /// Shows the sheet and returns true if any collections were modified
  static Future<bool?> show(
    BuildContext context, {
    required String quoteId,
    VoidCallback? onComplete,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AddToCollectionSheet(quoteId: quoteId, onComplete: onComplete),
    );
  }

  @override
  ConsumerState<AddToCollectionSheet> createState() =>
      _AddToCollectionSheetState();
}

class _AddToCollectionSheetState extends ConsumerState<AddToCollectionSheet> {
  final Set<String> _selectedCollections = {};
  final Set<String> _initialCollections = {};
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadExistingCollections();
  }

  Future<void> _loadExistingCollections() async {
    try {
      final repository = ref.read(collectionRepositoryProvider);
      final collections = await repository.getCollectionsForQuote(
        widget.quoteId,
      );

      setState(() {
        _initialCollections.addAll(collections.map((c) => c.id));
        _selectedCollections.addAll(_initialCollections);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final collectionsState = ref.watch(collectionsControllerProvider);
    final collectionsController = ref.read(
      collectionsControllerProvider.notifier,
    );

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.divider : AppColorsLight.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add to Collection',
                  style: AppTypography.headlineLarge(
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColorsLight.textPrimary,
                  ),
                ),
                // Create new collection button
                TextButton.icon(
                  onPressed: () async {
                    final name = await CreateCollectionDialog.show(context);
                    if (name != null && name.isNotEmpty) {
                      await collectionsController.createCollection(name: name);
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                  label: Text(
                    'New',
                    style: AppTypography.bodyMedium(
                      color: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Collections list
          Flexible(
            child: _isLoading || collectionsState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : collectionsState.collections.isEmpty
                ? _buildEmptyState(isDark)
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: collectionsState.collections.length,
                    itemBuilder: (context, index) {
                      final collection = collectionsState.collections[index];
                      return _buildCollectionTile(collection, isDark);
                    },
                  ),
          ),

          // Action buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: isDark
                            ? AppColorsDark.border
                            : AppColorsLight.border,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      CollectionsConstants.cancel,
                      style: AppTypography.bodyMedium(
                        color: isDark
                            ? AppColorsDark.textSecondary
                            : AppColorsLight.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _isSaving ? null : _saveSelections,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            CollectionsConstants.save,
                            style: AppTypography.bodyMedium(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionTile(Collection collection, bool isDark) {
    final isSelected = _selectedCollections.contains(collection.id);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDark
              ? AppColorsDark.primaryNavy.withValues(alpha: 0.3)
              : AppColorsLight.primaryNavy.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.collections_bookmark_outlined,
          color: isDark
              ? AppColorsDark.textTertiary
              : AppColorsLight.textTertiary,
        ),
      ),
      title: Text(
        collection.name,
        style: AppTypography.bodyLarge(
          color: isDark
              ? AppColorsDark.textPrimary
              : AppColorsLight.textPrimary,
        ),
      ),
      subtitle: Text(
        '${collection.quoteCount} quotes',
        style: AppTypography.caption(
          color: isDark
              ? AppColorsDark.textSecondary
              : AppColorsLight.textSecondary,
        ),
      ),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _selectedCollections.add(collection.id);
            } else {
              _selectedCollections.remove(collection.id);
            }
          });
        },
        activeColor: isDark
            ? AppColorsDark.accentTeal
            : AppColorsLight.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedCollections.remove(collection.id);
          } else {
            _selectedCollections.add(collection.id);
          }
        });
      },
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.collections_bookmark_outlined,
              size: 48,
              color: isDark
                  ? AppColorsDark.textTertiary
                  : AppColorsLight.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              CollectionsConstants.noCollections,
              style: AppTypography.headlineMedium(
                color: isDark
                    ? AppColorsDark.textPrimary
                    : AppColorsLight.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a collection first',
              style: AppTypography.bodyMedium(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSelections() async {
    setState(() => _isSaving = true);

    try {
      final repository = ref.read(collectionRepositoryProvider);

      // Find collections to add to (newly selected)
      final toAdd = _selectedCollections.difference(_initialCollections);

      // Find collections to remove from (deselected)
      final toRemove = _initialCollections.difference(_selectedCollections);

      // Add to new collections
      for (final collectionId in toAdd) {
        try {
          await repository.addQuoteToCollection(
            collectionId: collectionId,
            quoteId: widget.quoteId,
          );
        } catch (e) {
          // Ignore "already in collection" errors
          if (!e.toString().contains('already in collection')) {
            rethrow;
          }
        }
      }

      // Remove from deselected collections
      for (final collectionId in toRemove) {
        await repository.removeQuoteFromCollection(
          collectionId: collectionId,
          quoteId: widget.quoteId,
        );
      }

      // Refresh collections to update counts
      ref.read(collectionsControllerProvider.notifier).refresh();

      if (mounted) {
        widget.onComplete?.call();
        Navigator.pop(context, true);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Collections updated')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update collections: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
