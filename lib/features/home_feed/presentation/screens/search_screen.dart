import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/features/home_feed/presentation/widgets/quote_card.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/home_feed_constants.dart';
import '../../application/controllers/search_controller.dart';
import '../../application/state/search_state.dart';
import '../widgets/author_filter_sheet.dart';
import '../widgets/category_chip.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/search_bar_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Auto focus on search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchControllerProvider.notifier).loadMore();
    }
  }

  void _showAuthorFilter() {
    final searchState = ref.read(searchControllerProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            String? tempSelectedAuthorId = searchState.selectedAuthorId;

            return AuthorFilterSheet(
              authors: searchState.authors,
              selectedAuthorId: tempSelectedAuthorId,
              onAuthorSelected: (authorId) {
                setModalState(() {
                  tempSelectedAuthorId = authorId;
                });
              },
              onApply: () {
                ref
                    .read(searchControllerProvider.notifier)
                    .setAuthorFilter(tempSelectedAuthorId);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar with back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBarWidget(
                readOnly: false,
                showBackButton: true,
                controller: _searchController,
                focusNode: _focusNode,
                onBack: () => context.pop(),
                onChanged: (value) {
                  // Debounce search
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (_searchController.text == value) {
                      ref.read(searchControllerProvider.notifier).search(value);
                    }
                  });
                },
                onSubmitted: (value) {
                  ref.read(searchControllerProvider.notifier).search(value);
                },
                onClear: () {
                  _searchController.clear();
                  ref.read(searchControllerProvider.notifier).clearSearch();
                },
              ),
            ),
            // Filter chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CategoryChip(
                    label: HomeFeedConstants.byAuthor,
                    isSelected:
                        searchState.activeFilter == SearchFilterType.author,
                    onTap: () {
                      if (searchState.activeFilter == SearchFilterType.author) {
                        ref
                            .read(searchControllerProvider.notifier)
                            .setActiveFilter(null);
                      } else {
                        _showAuthorFilter();
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  CategoryChip(
                    label: HomeFeedConstants.byCategory,
                    isSelected:
                        searchState.activeFilter == SearchFilterType.category,
                    onTap: () {
                      ref
                          .read(searchControllerProvider.notifier)
                          .setActiveFilter(
                            searchState.activeFilter ==
                                    SearchFilterType.category
                                ? null
                                : SearchFilterType.category,
                          );
                    },
                  ),
                  const SizedBox(width: 8),
                  CategoryChip(
                    label: HomeFeedConstants.byPopularity,
                    isSelected:
                        searchState.activeFilter == SearchFilterType.popularity,
                    onTap: () {
                      final newSortBy = searchState.sortBy == 'popularity'
                          ? null
                          : 'popularity';
                      ref
                          .read(searchControllerProvider.notifier)
                          .setSortBy(newSortBy);
                    },
                  ),
                ],
              ),
            ),
            // Divider
            if (searchState.query.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: isDark ? AppColorsDark.border : AppColorsLight.border,
                  height: 1,
                ),
              ),
            // Results count
            if (searchState.query.isNotEmpty && searchState.totalResults > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColorsLight.textSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: '${HomeFeedConstants.foundResults} ',
                      ),
                      TextSpan(
                        text: '${searchState.totalResults}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: ' ${HomeFeedConstants.resultsFor} '),
                      TextSpan(
                        text: '"${searchState.query}"',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColorsDark.textPrimary
                              : AppColorsLight.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Results
            Expanded(
              child: searchState.isLoading && searchState.results.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : searchState.results.isEmpty && searchState.query.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: isDark
                                ? AppColorsDark.textTertiary
                                : AppColorsLight.textTertiary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            HomeFeedConstants.noQuotesFound,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: isDark
                                      ? AppColorsDark.textSecondary
                                      : AppColorsLight.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    )
                  : searchState.query.isEmpty
                  ? Center(
                      child: Text(
                        'Search for quotes or authors',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDark
                              ? AppColorsDark.textSecondary
                              : AppColorsLight.textSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: searchState.results.length + 1,
                      itemBuilder: (context, index) {
                        if (index == searchState.results.length) {
                          return LoadingMoreIndicator(
                            isLoading: searchState.isLoadingMore,
                            hasReachedEnd: searchState.hasReachedEnd,
                          );
                        }

                        final quote = searchState.results[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: QuoteCard(
                            quote: quote,
                            onFavorite: () {
                              // TODO: Toggle favorite
                            },
                            onShare: () {
                              // TODO: Share
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
