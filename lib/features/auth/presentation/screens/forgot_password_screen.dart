import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';
import '../../application/controllers/forgot_password_controller.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Reset icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color:
                        (isDark
                                ? AppColorsDark.surface
                                : AppColorsLight.surface)
                            .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark
                          ? AppColorsDark.border
                          : AppColorsLight.border,
                    ),
                  ),
                  child: Icon(
                    Icons.lock_reset,
                    size: 60,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Center(
                child: Text(
                  AuthConstants.forgotPasswordTitle,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  AuthConstants.forgotPasswordSubtitleAlt,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColorsDark.textSecondary
                        : AppColorsLight.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 32),

              // Email field
              AuthTextField(
                label: AuthConstants.emailAddress,
                hintText: 'name@example.com',
                onChanged: controller.updateEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 24),

              // Success message
              if (state.emailSent)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    AuthConstants.resetEmailSent,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal,
                    ),
                  ),
                ),

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

              // Send Reset Link button
              AuthButton(
                text: '${AuthConstants.sendResetLink}  →',
                onPressed: () async {
                  await controller.sendResetLink();
                },
                isLoading: state.isLoading,
              ),

              const SizedBox(height: 32),

              // Log in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthConstants.rememberPassword,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      AuthConstants.logIn,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColorsDark.accentTeal
                            : AppColorsLight.accentTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
