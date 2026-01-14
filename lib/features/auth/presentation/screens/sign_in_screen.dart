import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';
import '../../application/controllers/sign_in_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_text_field.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInControllerProvider);
    final controller = ref.read(signInControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and Help
              const SizedBox(height: 32),

              // Lock icon
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
                    Icons.lock_open,
                    size: 60,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Welcome text
              Center(
                child: Text(
                  AuthConstants.welcomeBack,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  AuthConstants.signInSubtitle,
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
                hintText: 'Enter your email',
                onChanged: controller.updateEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 20),

              // Password field
              PasswordTextField(
                label: AuthConstants.password,
                hintText: 'Enter your password',
                onChanged: controller.updatePassword,
                obscureText: state.obscurePassword,
                onToggleVisibility: controller.togglePasswordVisibility,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              // const SizedBox(height: 8),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.push(AuthConstants.forgotPasswordRoute),
                  child: Text(
                    AuthConstants.forgotPassword,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColorsDark.textSecondary
                          : AppColorsLight.textSecondary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

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

              // Sign in button
              AuthButton(
                text: AuthConstants.signIn,
                onPressed: () async {
                  final success = await controller.signIn();
                  if (success && context.mounted) {
                    context.go(AuthConstants.homeRoute);
                  }
                },
                isLoading: state.isLoading,
              ),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthConstants.dontHaveAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () =>
                        context.pushReplacement(AuthConstants.signUpRoute),
                    child: Text(
                      AuthConstants.signUp,
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
