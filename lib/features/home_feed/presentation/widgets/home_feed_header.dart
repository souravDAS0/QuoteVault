import 'package:flutter/material.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/home_feed_constants.dart';

class HomeFeedHeader extends StatelessWidget {
  final String? userName;
  final String? userPhotoUrl;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeFeedHeader({
    super.key,
    this.userName,
    this.userPhotoUrl,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
              border: Border.all(
                color: isDark ? AppColorsDark.border : AppColorsLight.border,
              ),
            ),
            child: userPhotoUrl != null
                ? ClipOval(
                    child: Image.network(
                      userPhotoUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: isDark
                        ? AppColorsDark.textSecondary
                        : AppColorsLight.textSecondary,
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
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColorsLight.textSecondary,
                    ),
              ),
              Text(
                userName ?? 'User',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        // Notification bell
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color:
                  isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
