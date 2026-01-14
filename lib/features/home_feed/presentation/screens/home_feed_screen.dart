import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/home_feed_constants.dart';
import '../../../auth/application/providers/auth_state_provider.dart';
import '../../application/controllers/home_feed_controller.dart';
import '../widgets/home_feed_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_chip.dart';
import '../widgets/quote_card.dart';
import '../widgets/loading_indicator.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeFeedControllerProvider.notifier).refresh();
          },
          color: isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: HomeFeedHeader(
                    userName: userName,
                    userPhotoUrl: userPhotoUrl,
                    onNotificationTap: () {
                      // TODO: Navigate to notifications
                    },
                  ),
                ),
              ),
              // Search bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBarWidget(
                    onTap: () {
                      context.push(HomeFeedConstants.searchRoute);
                    },
                  ),
                ),
              ),
              // Category chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: feedState.categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
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
              // Loading state
              if (feedState.isLoading && feedState.quotes.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
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
                            color: isDark
                                ? AppColorsDark.error
                                : AppColorsLight.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading quotes',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColorsDark.textPrimary
                                      : AppColorsLight.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feedState.errorMessage!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColorsDark.textSecondary
                                      : AppColorsLight.textSecondary,
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

                          onShare: () {
                            // TODO: Share quote
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
