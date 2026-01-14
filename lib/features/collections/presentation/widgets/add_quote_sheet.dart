import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';
import '../../../home_feed/domain/entities/quote.dart';
import '../../../home_feed/data/datasources/supabase_quote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../application/providers/collection_providers.dart';

/// Bottom sheet for adding quotes to a collection
class AddQuoteSheet extends ConsumerStatefulWidget {
  final String collectionId;
  final VoidCallback? onComplete;

  const AddQuoteSheet({
    super.key,
    required this.collectionId,
    this.onComplete,
  });

  /// Shows the sheet and returns true if quotes were added
  static Future<bool?> show(
    BuildContext context, {
    required String collectionId,
    VoidCallback? onComplete,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddQuoteSheet(
        collectionId: collectionId,
        onComplete: onComplete,
      ),
    );
  }

  @override
  ConsumerState<AddQuoteSheet> createState() => _AddQuoteSheetState();
}

class _AddQuoteSheetState extends ConsumerState<AddQuoteSheet> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedQuotes = {};
  final Set<String> _existingQuotes = {};

  List<Quote> _availableQuotes = [];
  bool _isLoading = true;
  bool _isSaving = false;
  String? _searchQuery;

  late final SupabaseQuoteDatasource _quoteDatasource;

  @override
  void initState() {
    super.initState();
    _quoteDatasource = SupabaseQuoteDatasource(supabase.Supabase.instance.client);
    _loadQuotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadQuotes() async {
    setState(() => _isLoading = true);

    try {
      // Load existing quotes in collection
      final repository = ref.read(collectionRepositoryProvider);
      final existingQuotesInCollection = await repository.getCollectionQuotes(
        collectionId: widget.collectionId,
        page: 0,
        pageSize: 1000, // Get all existing quotes
      );
      _existingQuotes.addAll(existingQuotesInCollection.map((q) => q.id));

      // Load available quotes
      final quoteDtos = _searchQuery != null && _searchQuery!.isNotEmpty
          ? await _quoteDatasource.searchQuotes(
              query: _searchQuery!,
              page: 0,
              pageSize: 50,
            )
          : await _quoteDatasource.getQuotes(page: 0, pageSize: 50);

      setState(() {
        _availableQuotes = quoteDtos.map((dto) => dto.toDomain()).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    _searchQuery = query.isEmpty ? null : query;
    _loadQuotes();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CollectionsConstants.addQuote,
                  style: AppTypography.headlineLarge(
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColorsLight.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                // Search field
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: AppTypography.bodyMedium(
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColorsLight.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search quotes...',
                    hintStyle: AppTypography.bodyMedium(
                      color: isDark
                          ? AppColorsDark.textTertiary
                          : AppColorsLight.textTertiary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark
                          ? AppColorsDark.textTertiary
                          : AppColorsLight.textTertiary,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? AppColorsDark.background
                        : AppColorsLight.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quotes list
          Flexible(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _availableQuotes.isEmpty
                    ? _buildEmptyState(isDark)
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _availableQuotes.length,
                        itemBuilder: (context, index) {
                          final quote = _availableQuotes[index];
                          return _buildQuoteTile(quote, isDark);
                        },
                      ),
          ),

          // Selected count and action buttons
          if (_selectedQuotes.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColorsDark.background
                    : AppColorsLight.background,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColorsDark.border : AppColorsLight.border,
                  ),
                ),
              ),
              child: Text(
                '${_selectedQuotes.length} quote${_selectedQuotes.length > 1 ? 's' : ''} selected',
                style: AppTypography.bodyMedium(
                  color: isDark
                      ? AppColorsDark.textSecondary
                      : AppColorsLight.textSecondary,
                ),
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
                    onPressed: _isSaving || _selectedQuotes.isEmpty
                        ? null
                        : _addSelectedQuotes,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.secondary,
                      disabledBackgroundColor: isDark
                          ? AppColorsDark.border
                          : AppColorsLight.border,
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
                            'Add ${_selectedQuotes.isNotEmpty ? '(${_selectedQuotes.length})' : ''}',
                            style: AppTypography.bodyMedium(color: Colors.white),
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

  Widget _buildQuoteTile(Quote quote, bool isDark) {
    final isSelected = _selectedQuotes.contains(quote.id);
    final alreadyInCollection = _existingQuotes.contains(quote.id);

    return Opacity(
      opacity: alreadyInCollection ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppColorsDark.accentTeal.withValues(alpha: 0.1)
                  : AppColorsLight.accentTeal.withValues(alpha: 0.1))
              : (isDark ? AppColorsDark.background : AppColorsLight.background),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            quote.text,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColorsDark.textPrimary
                  : AppColorsLight.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '— ${quote.authorName}',
              style: AppTypography.caption(
                color: isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textSecondary,
              ),
            ),
          ),
          trailing: alreadyInCollection
              ? Icon(
                  Icons.check_circle,
                  color: isDark
                      ? AppColorsDark.success
                      : AppColorsLight.success,
                )
              : Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedQuotes.add(quote.id);
                      } else {
                        _selectedQuotes.remove(quote.id);
                      }
                    });
                  },
                  activeColor: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
          onTap: alreadyInCollection
              ? null
              : () {
                  setState(() {
                    if (isSelected) {
                      _selectedQuotes.remove(quote.id);
                    } else {
                      _selectedQuotes.add(quote.id);
                    }
                  });
                },
        ),
      ),
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
              Icons.format_quote,
              size: 48,
              color: isDark
                  ? AppColorsDark.textTertiary
                  : AppColorsLight.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No quotes found',
              style: AppTypography.headlineMedium(
                color: isDark
                    ? AppColorsDark.textPrimary
                    : AppColorsLight.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search',
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

  Future<void> _addSelectedQuotes() async {
    if (_selectedQuotes.isEmpty) return;

    setState(() => _isSaving = true);

    try {
      final repository = ref.read(collectionRepositoryProvider);

      int addedCount = 0;
      for (final quoteId in _selectedQuotes) {
        try {
          await repository.addQuoteToCollection(
            collectionId: widget.collectionId,
            quoteId: quoteId,
          );
          addedCount++;
        } catch (e) {
          // Ignore "already in collection" errors
          if (!e.toString().contains('already in collection')) {
            rethrow;
          }
        }
      }

      if (mounted) {
        widget.onComplete?.call();
        Navigator.pop(context, true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$addedCount quote${addedCount > 1 ? 's' : ''} added to collection',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add quotes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
