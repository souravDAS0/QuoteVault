import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/config/theme/app_typography.dart';
import 'package:quote_vault/core/constants/collections_constants.dart';
import 'package:quote_vault/features/auth/domain/entities/qv_user.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/profile_constants.dart';
import '../../../auth/application/providers/auth_state_provider.dart';
import '../../application/controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/statistics_card.dart';
import '../widgets/account_settings_item.dart';
import '../widgets/edit_profile_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserAsync = ref.watch(currentUserProvider);
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColorsDark.background
            : AppColorsLight.background,
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
                          ? _buildLoadingStatistics(context, isDark)
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
                    _buildAcoountSettingSection(context, isDark, ref),
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

  Widget _buildAcoountSettingSection(
    BuildContext context,
    bool isDark,
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
              color: isDark
                  ? AppColorsDark.textTertiary
                  : AppColorsLight.textTertiary,
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
              _showComingSoonSnackbar(context, 'Settings');
            },
          ),

          const SizedBox(height: 16),

          // Logout Button
          AccountSettingsItem(
            icon: Icons.logout,
            title: ProfileConstants.logout,
            iconColor: isDark ? AppColorsDark.error : AppColorsLight.error,
            textColor: isDark ? AppColorsDark.error : AppColorsLight.error,
            showTrailingIcon: false,
            onTap: () => _handleLogout(context, ref),
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStatistics(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
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
              color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  void _showComingSoonSnackbar(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon'),
        duration: const Duration(seconds: 2),
      ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext dialogContext) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
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
                    color: isDark
                        ? AppColorsDark.divider
                        : AppColorsLight.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Are you sure you want to logout?',
                  style: AppTypography.headlineMedium(
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColorsLight.textPrimary,
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
                          side: BorderSide(
                            color: isDark
                                ? AppColorsDark.border
                                : AppColorsLight.border,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTypography.bodyLarge(
                            color: isDark
                                ? AppColorsDark.textSecondary
                                : AppColorsLight.textSecondary,
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
                          backgroundColor: isDark
                              ? const Color.fromARGB(255, 235, 105, 73)
                              : const Color.fromARGB(255, 235, 105, 73),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: AppTypography.bodyLarge(
                            color: isDark ? Colors.white : Colors.white,
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
