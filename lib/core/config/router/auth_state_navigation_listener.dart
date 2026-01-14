import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../constants/auth_constants.dart';
import 'app_router.dart';

part 'auth_state_navigation_listener.g.dart';

/// Provider that sets up auth state change listener for password recovery navigation
@riverpod
void authStateNavigationListener(Ref ref) {
  final router = ref.watch(goRouterProvider);

  // Listen to auth state changes
  final subscription = supabase.Supabase.instance.client.auth.onAuthStateChange
      .listen((data) {
        final event = data.event;
        final session = data.session;

        // Handle password recovery event
        if (event == supabase.AuthChangeEvent.passwordRecovery &&
            session != null) {
          // Navigate to reset password screen using the router directly
          router.go(AuthConstants.resetPasswordRoute);
        }
      });

  // Clean up subscription when provider is disposed
  ref.onDispose(() {
    subscription.cancel();
  });
}
