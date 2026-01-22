import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/home_feed_constants.dart';
import '../../../auth/application/providers/auth_state_provider.dart';
import '../../../collections/presentation/widgets/add_to_collection_sheet.dart';
import '../../../sharing/presentation/screens/share_quote_sheet.dart';
import '../../domain/entities/quote.dart';
import '../../application/controllers/home_feed_controller.dart';
import '../widgets/home_feed_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chip.dart';
import '../widgets/quote_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/author_filter_sheet.dart';
import '../widgets/daily_quote_card.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(homeFeedControllerProvider.notifier).loadMore();
    }
  }

  void _showAuthorFilter() {
    final feedState = ref.read(homeFeedControllerProvider);
    String? tempSelectedAuthorId = feedState.selectedAuthorId;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AuthorFilterSheet(
              authors: feedState.authors,
              selectedAuthorId: tempSelectedAuthorId,
              onAuthorSelected: (authorId) {
                setModalState(() {
                  tempSelectedAuthorId = authorId;
                });
              },
              onApply: () {
                ref
                    .read(homeFeedControllerProvider.notifier)
                    .selectAuthor(tempSelectedAuthorId);
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final feedState = ref.watch(homeFeedControllerProvider);
    final currentUser = ref.watch(currentUserProvider);

    // Extract user data from AsyncValue
    final userName = currentUser.when(
      data: (user) => user?.displayName ?? 'User',
      loading: () => 'User',
      error: (e, s) => 'User',
    );
    final userPhotoUrl = currentUser.when(
      data: (user) => user?.photoUrl,
      loading: () => null,
      error: (e, s) => null,
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeFeedControllerProvider.notifier).refresh();
          },
          color: colorScheme.tertiary,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Skeletonizer(
                    enabled: feedState.isLoading && feedState.quotes.isEmpty,
                    child: HomeFeedHeader(
                      userName: userName,
                      userPhotoUrl: userPhotoUrl,
                    ),
                  ),
                ),
              ),
              // Search bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Skeletonizer(
                    enabled: feedState.isLoading && feedState.quotes.isEmpty,
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBarWidget(
                            onTap: () {
                              context.push(HomeFeedConstants.searchRoute);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Author Filter Chip
                        SizedBox(
                          height: 48,
                          child: CategoryChip(
                            label: HomeFeedConstants.byAuthor,
                            isSelected: feedState.selectedAuthorId != null,
                            onTap: () {
                              _showAuthorFilter();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Category chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 40,
                    child: Skeletonizer(
                      enabled:
                          feedState.categories.isEmpty && feedState.isLoading,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: feedState.categories.isEmpty
                            ? 5 // Show 5 skeleton chips when loading
                            : feedState.categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          if (feedState.categories.isEmpty) {
                            // Show skeleton chips
                            return CategoryChip(
                              label: 'Categ_${index + 1}',
                              isSelected: index == 0,
                              onTap: () {},
                            );
                          }
                          final category = feedState.categories[index];
                          return CategoryChip(
                            label: category.name,
                            isSelected: category.isSelected,
                            onTap: () {
                              ref
                                  .read(homeFeedControllerProvider.notifier)
                                  .selectCategory(category.id);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // Daily Quote Section
              if (feedState.isDailyQuoteLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Skeletonizer(
                      enabled: true,
                      child: DailyQuoteCard(
                        quote: Quote(
                          id: 'skeleton',
                          text: 'This is a placeholder quote text.',
                          authorId: 'skeleton-author',
                          authorName: 'Author Name',
                          categoryId: 'skeleton-category',
                          categoryName: 'Category',
                          isFavorite: false,
                          isBookmarked: false,
                          likesCount: 0,
                          createdAt: DateTime.now(),
                        ),
                        onFavorite: () {},
                        onShare: () {},
                        onCopy: () {},
                        onAddToCollection: () {},
                      ),
                    ),
                  ),
                )
              else if (feedState.dailyQuote != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DailyQuoteCard(
                      quote: feedState.dailyQuote!,
                      onFavorite: () {
                        ref
                            .read(homeFeedControllerProvider.notifier)
                            .toggleFavorite(feedState.dailyQuote!.id);
                      },
                      onShare: () {
                        ShareQuoteSheet.show(
                          context,
                          quote: feedState.dailyQuote!,
                        );
                      },
                      onCopy: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Quote copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      onAddToCollection: () {
                        AddToCollectionSheet.show(
                          context,
                          quoteId: feedState.dailyQuote!.id,
                        );
                      },
                    ),
                  ),
                ),
              // if (feedState.dailyQuote != null)
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              // Loading state
              if (feedState.isLoading && feedState.quotes.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Skeletonizer(
                            enabled: true,
                            child: QuoteCard(
                              quote: Quote(
                                id: 'skeleton-$index',
                                text:
                                    'This is a placeholder quote text that will be replaced with actual content once it loads from the server.',
                                authorId: 'skeleton-author',
                                authorName: '',
                                categoryId: 'skeleton-category',
                                categoryName: 'Category',
                                isFavorite: false,
                                isBookmarked: false,
                                likesCount: 0,
                                createdAt: DateTime.now(),
                              ),
                              onFavorite: () {},
                              onShare: () {},
                              onCopy: () {},
                              onAddToCollection: () {},
                            ),
                          ),
                        );
                      },
                      childCount: 3, // Show 3 skeleton cards
                    ),
                  ),
                )
              // Error state
              else if (feedState.errorMessage != null &&
                  feedState.quotes.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading quotes',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feedState.errorMessage!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(homeFeedControllerProvider.notifier)
                                  .refresh();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              // Empty state
              else if (!feedState.isLoading && feedState.quotes.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_quote,
                          size: 64,
                          color: colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          HomeFeedConstants.noQuotesFound,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              // Quote list
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final quote = feedState.quotes[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: QuoteCard(
                          quote: quote,
                          onFavorite: () {
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
                    }, childCount: feedState.quotes.length),
                  ),
                ),
                // Loading more indicator
                SliverToBoxAdapter(
                  child: LoadingMoreIndicator(
                    isLoading: feedState.isLoadingMore,
                    hasReachedEnd: feedState.hasReachedEnd,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
