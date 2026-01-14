import 'package:flutter/material.dart';
import 'package:quote_vault/core/config/theme/app_typography.dart';
import '../../../../core/config/theme/app_colors.dart';

/// Widget displaying user profile header with avatar, name, and email
class ProfileHeader extends StatelessWidget {
  final String displayName;
  final String email;
  final String? photoUrl;
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    required this.displayName,
    required this.email,
    this.photoUrl,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          // Avatar with edit badge
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? AppColorsDark.accentTeal.withValues(alpha: 0.2)
                      : AppColorsLight.accentTeal.withValues(alpha: 0.2),
                ),
                child: photoUrl != null
                    ? ClipOval(
                        child: Image.network(
                          photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(isDark),
                        ),
                      )
                    : _buildDefaultAvatar(isDark),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: onEditTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal,
                      border: Border.all(
                        color: isDark
                            ? AppColorsDark.surface
                            : AppColorsLight.surface,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: isDark
                          ? AppColorsDark.surface
                          : AppColorsLight.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Display name
          Text(
            displayName,
            style: AppTypography.displayLarge(
              color: isDark
                  ? AppColorsDark.textPrimary
                  : AppColorsLight.textPrimary,
            ),
          ),
          // Email
          Text(
            email,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColorsDark.textSecondary
                  : AppColorsLight.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(bool isDark) {
    return Center(
      child: Icon(
        Icons.person,
        size: 50,
        color: isDark ? AppColorsDark.accentTeal : AppColorsLight.accentTeal,
      ),
    );
  }
}
