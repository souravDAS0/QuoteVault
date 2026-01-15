import 'package:flutter/material.dart';
import 'package:quote_vault/core/config/theme/app_typography.dart';

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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  color: colorScheme.tertiary.withValues(alpha: 0.2),
                ),
                child: photoUrl != null
                    ? ClipOval(
                        child: Image.network(
                          photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(colorScheme),
                        ),
                      )
                    : _buildDefaultAvatar(colorScheme),
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
                      color: colorScheme.tertiary,
                      border: Border.all(color: colorScheme.surface, width: 3),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: colorScheme.surface,
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
            style: AppTypography.displayLarge(color: colorScheme.onBackground),
          ),
          // Email
          Text(
            email,
            style: AppTypography.bodyMedium(
              color: colorScheme.onBackground.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(ColorScheme colorScheme) {
    return Center(
      child: Icon(Icons.person, size: 50, color: colorScheme.tertiary),
    );
  }
}
