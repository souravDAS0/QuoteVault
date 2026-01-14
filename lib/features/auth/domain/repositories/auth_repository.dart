import '../entities/qv_user.dart';

/// Abstract repository defining authentication contracts
/// Implementation will be in the data layer
/// NO Supabase imports, NO implementation details
abstract class AuthRepository {
  /// Get current authenticated user
  /// Returns null if not authenticated
  Future<QvUser?> getCurrentUser();

  /// Sign in with email and password
  /// Throws AuthException on failure
  Future<QvUser> signInWithEmail({
    required String email,
    required String password,
  });

  /// Create new account with email and password
  /// Throws AuthException on failure
  Future<QvUser> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Send password reset email
  /// Throws AuthException on failure
  Future<void> sendPasswordResetEmail({required String email});

  /// Update password (used after clicking reset link)
  /// Throws AuthException on failure
  Future<void> updatePassword({required String newPassword});

  /// Sign out current user
  Future<void> signOut();

  /// Stream of authentication state changes
  /// Emits User when authenticated, null when not
  Stream<QvUser?> authStateChanges();
}
