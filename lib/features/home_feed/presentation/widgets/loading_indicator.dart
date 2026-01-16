import 'package:flutter/material.dart';

import '../../../../core/constants/home_feed_constants.dart';

class LoadingMoreIndicator extends StatelessWidget {
  final bool isLoading;
  final bool hasReachedEnd;

  const LoadingMoreIndicator({
    super.key,
    required this.isLoading,
    required this.hasReachedEnd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!isLoading && !hasReachedEnd) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          if (isLoading)
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.tertiary,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            isLoading
                ? HomeFeedConstants.loadingMoreQuotes
                : HomeFeedConstants.endOfResults,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onTertiary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
