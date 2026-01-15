import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/home_feed_constants.dart';
import '../../domain/entities/author.dart';

class AuthorFilterSheet extends StatelessWidget {
  final List<Author> authors;
  final String? selectedAuthorId;
  final ValueChanged<String?> onAuthorSelected;
  final VoidCallback onApply;

  const AuthorFilterSheet({
    super.key,
    required this.authors,
    required this.selectedAuthorId,
    required this.onAuthorSelected,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Title
          Text(
            HomeFeedConstants.filterByAuthor,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(child: _buildAuthorList(context)),
          ),
          const SizedBox(height: 20),
          // Apply button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onApply,
              child: Text(
                HomeFeedConstants.applyFilters,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorList(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // All Authors option
        _buildAuthorOption(
          context,
          id: null,
          name: HomeFeedConstants.allAuthors,
          initials: 'ALL',
          colorScheme: colorScheme,
        ),
        // Author list
        ...authors.map((author) {
          return _buildAuthorOption(
            context,
            id: author.id,
            name: author.name,
            initials: _getInitials(author.name),
            color: _getAuthorColor(author.id),
            colorScheme: colorScheme,
          );
        }),
      ],
    );
  }

  Widget _buildAuthorOption(
    BuildContext context, {
    required String? id,
    required String name,
    required String initials,
    Color? color,
    required ColorScheme colorScheme,
  }) {
    final isSelected = selectedAuthorId == id;

    return InkWell(
      onTap: () => onAuthorSelected(id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                  width: 2,
                ),
                color: isSelected ? colorScheme.tertiary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            // Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color ?? colorScheme.outline,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Name
            Text(name, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    return name
        .split(' ')
        .take(2)
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() : '')
        .join();
  }

  Color _getAuthorColor(String id) {
    // Generate a consistent color based on the author ID
    final hash = id.hashCode;
    final colors = [
      const Color(0xFF5F9598), // Teal
      const Color(0xFF9B59B6), // Purple
      const Color(0xFFE67E22), // Orange
      const Color(0xFF3498DB), // Blue
      const Color(0xFF1ABC9C), // Turquoise
    ];
    return colors[hash.abs() % colors.length];
  }
}
