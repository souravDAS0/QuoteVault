import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                color: isDark
                    ? AppColorsDark.accentTeal
                    : AppColorsLight.accentTeal,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            isLoading
                ? HomeFeedConstants.loadingMoreQuotes
                : HomeFeedConstants.endOfResults,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppColorsDark.textTertiary
                      : AppColorsLight.textTertiary,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}
