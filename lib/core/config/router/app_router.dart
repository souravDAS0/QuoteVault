import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../../features/auth/application/providers/auth_state_provider.dart';
import '../../../features/home_feed/presentation/screens/main_shell.dart';
import '../../../features/home_feed/presentation/screens/search_screen.dart';
import '../../constants/auth_constants.dart';
import '../../constants/home_feed_constants.dart';

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
        builder: (context, state) => const MainShell(),
      ),
      GoRoute(
        path: HomeFeedConstants.searchRoute,
        builder: (context, state) => const SearchScreen(),
      ),
    ],
  );
});
