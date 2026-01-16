import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/features/collections/presentation/widgets/add_to_collection_sheet.dart';
import 'package:quote_vault/features/home_feed/application/controllers/home_feed_controller.dart';
import 'package:quote_vault/features/home_feed/presentation/widgets/quote_card.dart';

import '../../../../core/constants/home_feed_constants.dart';
import '../../../sharing/presentation/screens/share_quote_sheet.dart';
import '../../application/controllers/search_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final searchState = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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

            // Divider
            if (searchState.query.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: colorScheme.outline.withValues(alpha: 0.5),
                  height: 1,
                ),
              ),
            // Results count
            if (searchState.query.isNotEmpty && searchState.totalResults >= 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
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
                          color: colorScheme.onSurface,
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
                            color: colorScheme.tertiary.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            HomeFeedConstants.noQuotesFound,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
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
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
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
                              // Update search results state immediately for responsive UI
                              final newIsFavorite = !quote.isFavorite;
                              final newLikesCount = newIsFavorite
                                  ? quote.likesCount + 1
                                  : quote.likesCount - 1;
                              ref
                                  .read(searchControllerProvider.notifier)
                                  .updateQuoteFavoriteStatus(
                                    quote.id,
                                    newIsFavorite,
                                    newLikesCount,
                                  );
                              // Also toggle in home feed (handles API call)
                              ref
                                  .read(homeFeedControllerProvider.notifier)
                                  .toggleFavorite(quote.id);
                            },
                            onAddToCollection: () {
                              AddToCollectionSheet.show(
                                context,
                                quoteId: quote.id,
                              );
                            },
                            onShare: () {
                              ShareQuoteSheet.show(context, quote: quote);
                            },
                            onCopy: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Quote copied to clipboard'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
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
