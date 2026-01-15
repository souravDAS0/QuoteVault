import 'package:flutter/material.dart';

import '../../../../core/constants/home_feed_constants.dart';

class HomeFeedHeader extends StatelessWidget {
  final String? userName;
  final String? userPhotoUrl;
  final VoidCallback? onProfileTap;

  const HomeFeedHeader({
    super.key,
    this.userName,
    this.userPhotoUrl,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        // User avatar
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            child: userPhotoUrl != null
                ? ClipOval(
                    child: Image.network(userPhotoUrl!, fit: BoxFit.cover),
                  )
                : Icon(
                    Icons.person,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        // Welcome text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HomeFeedConstants.welcomeBack,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                userName ?? 'User',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
