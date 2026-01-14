import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';
import '../../application/controllers/reset_password_controller.dart';
import '../widgets/password_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/password_requirements_card.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resetPasswordControllerProvider);
    final controller = ref.read(resetPasswordControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and Security title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  Text(
                    AuthConstants.security,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance for back button
                ],
              ),

              const SizedBox(height: 32),

              // Reset icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: (isDark ? AppColorsDark.surface : AppColorsLight.surface)
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.lock_reset,
                    size: 40,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Text(
                AuthConstants.resetPasswordTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                AuthConstants.resetPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColorsLight.textSecondary,
                    ),
              ),

              const SizedBox(height: 32),

              // New Password field
              PasswordTextField(
                label: AuthConstants.newPassword,
                hintText: 'Enter new password',
                onChanged: controller.updateNewPassword,
                obscureText: state.obscureNewPassword,
                onToggleVisibility: controller.toggleNewPasswordVisibility,
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Password field
              PasswordTextField(
                label: AuthConstants.confirmPassword,
                hintText: 'Re-enter password',
                onChanged: controller.updateConfirmPassword,
                obscureText: state.obscureConfirmPassword,
                onToggleVisibility:
                    controller.toggleConfirmPasswordVisibility,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 12),

              // Weak password indicator
              if (state.newPassword.isNotEmpty && !controller.isPasswordValid)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    AuthConstants.weakPassword,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColorsDark.error
                              : AppColorsLight.error,
                        ),
                  ),
                ),

              // Password Requirements Card
              PasswordRequirementsCard(
                hasMinLength: controller.hasMinLength,
                hasNumber: controller.hasNumber,
                hasSymbol: controller.hasSymbol,
              ),

              const SizedBox(height: 24),

              // Error message
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    state.errorMessage!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColorsDark.error
                              : AppColorsLight.error,
                        ),
                  ),
                ),

              // Update Password button
              AuthButton(
                text: '${AuthConstants.updatePassword}  →',
                onPressed: () async {
                  final success = await controller.updatePassword();
                  if (success && context.mounted) {
                    // Show success message and navigate to sign in
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AuthConstants.passwordUpdated),
                        backgroundColor: isDark
                            ? AppColorsDark.accentTeal
                            : AppColorsLight.accentTeal,
                      ),
                    );
                    context.go(AuthConstants.signInRoute);
                  }
                },
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 32),

              // Footer
              Center(
                child: Text(
                  AuthConstants.protectedBy,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColorsDark.textTertiary
                            : AppColorsLight.textTertiary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
