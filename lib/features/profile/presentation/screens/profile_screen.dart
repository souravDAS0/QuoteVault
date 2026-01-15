import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/config/theme/app_typography.dart';
import 'package:quote_vault/core/constants/collections_constants.dart';
import 'package:quote_vault/core/constants/settings_constants.dart';
import 'package:quote_vault/features/auth/domain/entities/qv_user.dart';

import '../../../../core/constants/profile_constants.dart';
import '../../../auth/application/providers/auth_state_provider.dart';
import '../../application/controllers/profile_controller.dart';
import '../widgets/account_settings_item.dart';
import '../widgets/edit_profile_sheet.dart';
import '../widgets/profile_header.dart';
import '../widgets/statistics_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUserAsync = ref.watch(currentUserProvider);
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,

      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,

        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(profileControllerProvider.notifier).refresh();
          },
          child: currentUserAsync.when(
            data: (user) {
              if (user == null) {
                return const Center(child: Text('Not authenticated'));
              }

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    ProfileHeader(
                      displayName: user.displayName ?? 'User',
                      email: user.email,
                      photoUrl: user.photoUrl,
                      onEditTap: () {
                        _showEditProfileSheet(context, user);
                      },
                    ),

                    // Statistics Cards
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: profileState.isLoading
                          ? _buildLoadingStatistics(context, colorScheme)
                          : Row(
                              children: [
                                StatisticsCard(
                                  icon: Icons.favorite,
                                  count:
                                      profileState.statistics?.favoritesCount ??
                                      0,
                                  label: ProfileConstants.favorites,
                                  onTap: () {
                                    context.push(
                                      CollectionsConstants.favoritesRoute,
                                    );
                                  },
                                ),
                                const SizedBox(width: 16),
                                StatisticsCard(
                                  icon: Icons.collections_bookmark,
                                  count:
                                      profileState
                                          .statistics
                                          ?.collectionsCount ??
                                      0,
                                  label: ProfileConstants.collections,
                                ),
                              ],
                            ),
                    ),

                    const SizedBox(height: 32),
                    _buildAccountSettingSection(context, colorScheme, ref),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text('Error loading user: $error')),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSettingSection(
    BuildContext context,
    ColorScheme colorScheme,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Settings Section
          Text(
            ProfileConstants.account,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Edit Profile
          AccountSettingsItem(
            icon: Icons.person_add,
            title: ProfileConstants.editProfile,
            onTap: () {
              final currentUserAsync = ref.read(currentUserProvider);
              currentUserAsync.whenData((user) {
                if (user != null) {
                  _showEditProfileSheet(context, user);
                }
              });
            },
          ),
          const SizedBox(height: 16),

          // Settings
          AccountSettingsItem(
            icon: Icons.settings,
            title: ProfileConstants.settings,
            onTap: () {
              context.push(SettingsConstants.personalizationRoute);
            },
          ),

          const SizedBox(height: 16),

          // Logout Button
          AccountSettingsItem(
            icon: Icons.logout,
            title: ProfileConstants.logout,
            iconColor: colorScheme.error,
            textColor: colorScheme.error,
            showTrailingIcon: false,
            onTap: () => _handleLogout(context, ref),
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStatistics(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  void _showEditProfileSheet(BuildContext context, QvUser user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EditProfileSheet(user: user),
    );
  }

  Future<void> _showLogoutConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext dialogContext) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Are you sure you want to logout?',
                  style: AppTypography.headlineMedium(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colorScheme.outline),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTypography.bodyLarge(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          _performLogout(context, ref);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.errorContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: AppTypography.bodyLarge(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    await _showLogoutConfirmationDialog(context, ref);
  }

  Future<void> _performLogout(BuildContext context, WidgetRef ref) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signOut();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(ProfileConstants.logoutSuccess),
            duration: Duration(seconds: 2),
          ),
        );
        context.go('/sign-in');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${ProfileConstants.logoutFailed}: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
