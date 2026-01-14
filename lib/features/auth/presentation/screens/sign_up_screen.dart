import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/constants/auth_constants.dart';
import '../../application/controllers/sign_up_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_match_indicator.dart';
import '../widgets/password_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _confirmPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpControllerProvider);
    final controller = ref.read(signUpControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // QuoteVault title
              Center(
                child: Text(
                  'QuoteVault',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              const SizedBox(height: 32),

              // Join the Vault
              Center(
                child: Text(
                  AuthConstants.joinTheVault,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  AuthConstants.signUpSubtitle,
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
                label: AuthConstants.email,
                hintText: 'Enter your email',
                onChanged: controller.updateEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email,
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
                  Icons.lock,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Password field
              PasswordTextField(
                focusNode: _confirmPasswordFocusNode,
                label: AuthConstants.confirmPassword,
                hintText: 'Confirm your password',
                onChanged: controller.updateConfirmPassword,
                obscureText: state.obscureConfirmPassword,
                onToggleVisibility: controller.toggleConfirmPasswordVisibility,
                prefixIcon: Icon(
                  Icons.lock_reset,
                  color: isDark
                      ? AppColorsDark.accentTeal
                      : AppColorsLight.accentTeal,
                ),
              ),

              const SizedBox(height: 12),

              // Password match indicator
              PasswordMatchIndicator(
                passwordsMatch: controller.passwordsMatch,
                showIndicator:
                    state.password.isNotEmpty &&
                    state.confirmPassword.isNotEmpty &&
                    (controller.passwordsMatch ||
                        !_confirmPasswordFocusNode.hasFocus),
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

              // Create Account button
              AuthButton(
                text: AuthConstants.createAccount,
                onPressed: () async {
                  final success = await controller.signUp();
                  if (success && context.mounted) {
                    context.go(AuthConstants.homeRoute);
                  }
                },
                isLoading: state.isLoading,
              ),

              // Log in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthConstants.alreadyHaveAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () =>
                        context.pushReplacement(AuthConstants.signInRoute),
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
