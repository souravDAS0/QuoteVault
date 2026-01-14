import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../../features/auth/application/providers/auth_state_provider.dart';
import '../../constants/auth_constants.dart';

/// Provider for go_router configuration
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: AuthConstants.signInRoute,
    redirect: (context, state) {
      // Check auth state for redirection
      return authState.when(
        data: (user) {
          final isAuthRoute =
              state.matchedLocation == AuthConstants.signInRoute ||
                  state.matchedLocation == AuthConstants.signUpRoute ||
                  state.matchedLocation == AuthConstants.forgotPasswordRoute;

          // If user is authenticated and on auth route, redirect to home
          if (user != null && isAuthRoute) {
            return AuthConstants.homeRoute;
          }

          // If user is not authenticated and not on auth/reset route, redirect to sign in
          if (user == null &&
              !isAuthRoute &&
              state.matchedLocation != AuthConstants.resetPasswordRoute) {
            return AuthConstants.signInRoute;
          }

          return null; // No redirect
        },
        loading: () => null, // Don't redirect while loading
        error: (_, _) => AuthConstants.signInRoute,
      );
    },
    routes: [
      GoRoute(
        path: AuthConstants.signInRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AuthConstants.signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AuthConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AuthConstants.resetPasswordRoute,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AuthConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});

/// Placeholder home screen (will be replaced by actual home feed)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuoteVault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final repo = ref.read(authRepositoryProvider);
              await repo.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Feed - Coming Soon'),
      ),
    );
  }
}
