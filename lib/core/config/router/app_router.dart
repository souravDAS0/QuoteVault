import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../../features/auth/application/providers/auth_state_provider.dart';
import '../../../features/home_feed/presentation/screens/main_shell.dart';
import '../../../features/home_feed/presentation/screens/search_screen.dart';
import '../../../features/collections/presentation/screens/collection_details_screen.dart';
import '../../../features/settings/presentation/screens/personalization_screen.dart';
import '../../constants/auth_constants.dart';
import '../../constants/home_feed_constants.dart';
import '../../constants/collections_constants.dart';
import '../../constants/settings_constants.dart';

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

          final isResetPasswordRoute =
              state.matchedLocation == AuthConstants.resetPasswordRoute;

          // Check if user is in password recovery session
          final session = supabase.Supabase.instance.client.auth.currentSession;
          final isPasswordRecovery = session?.user.recoverySentAt != null;

          // If user is authenticated and in password recovery, allow reset password screen
          if (user != null && isPasswordRecovery && isResetPasswordRoute) {
            return null; // Allow access to reset password screen
          }

          // If user is authenticated and on auth route, redirect to home
          if (user != null && isAuthRoute) {
            return AuthConstants.homeRoute;
          }

          // If user is authenticated but trying to access reset password without recovery, redirect to home
          if (user != null && isResetPasswordRoute && !isPasswordRecovery) {
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
      GoRoute(
        path: '/collections/:id',
        builder: (context, state) {
          final collectionId = state.pathParameters['id']!;
          return CollectionDetailsScreen(collectionId: collectionId);
        },
      ),
      GoRoute(
        path: CollectionsConstants.favoritesRoute,
        builder: (context, state) =>
            const CollectionDetailsScreen(isFavorites: true),
      ),
      GoRoute(
        path: SettingsConstants.personalizationRoute,
        builder: (context, state) => const PersonalizationScreen(),
      ),
    ],
  );
});
