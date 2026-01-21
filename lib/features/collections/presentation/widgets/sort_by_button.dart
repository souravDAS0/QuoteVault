import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';
import '../../application/state/collections_state.dart';

/// Sort by button that shows sorting options
class SortByButton extends StatelessWidget {
  final CollectionSortBy currentSort;
  final ValueChanged<CollectionSortBy> onSortChanged;

  const SortByButton({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextButton(
      onPressed: () => _showSortOptions(context),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        CollectionsConstants.sortBy,
        style: AppTypography.bodyMedium(
          color: colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  CollectionsConstants.sortBy,
                  style: AppTypography.headlineMedium(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                // Options
                _SortOption(
                  label: CollectionsConstants.sortByName,
                  isSelected: currentSort == CollectionSortBy.name,
                  onTap: () {
                    Navigator.pop(context);
                    onSortChanged(CollectionSortBy.name);
                  },
                  colorScheme: colorScheme,
                ),
                _SortOption(
                  label: CollectionsConstants.sortByDate,
                  isSelected: currentSort == CollectionSortBy.dateCreated,
                  onTap: () {
                    Navigator.pop(context);
                    onSortChanged(CollectionSortBy.dateCreated);
                  },
                  colorScheme: colorScheme,
                ),
                _SortOption(
                  label: CollectionsConstants.sortByCount,
                  isSelected: currentSort == CollectionSortBy.quoteCount,
                  onTap: () {
                    Navigator.pop(context);
                    onSortChanged(CollectionSortBy.quoteCount);
                  },
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SortOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _SortOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: AppTypography.bodyLarge(color: colorScheme.onSurface),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: colorScheme.onSurface)
          : null,
    );
  }
}
