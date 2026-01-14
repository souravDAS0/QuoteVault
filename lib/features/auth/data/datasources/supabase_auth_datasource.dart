import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/errors/auth_exceptions.dart';
import '../models/user_dto.dart';

/// Wrapper around Supabase auth methods
/// Handles all Supabase authentication operations
class SupabaseAuthDatasource {
  final supabase.SupabaseClient _client;

  SupabaseAuthDatasource(this._client);

  /// Get current user from Supabase session
  Future<UserDto?> getCurrentUser() async {
    try {
      final session = _client.auth.currentSession;
      if (session == null) return null;

      final supabaseUser = session.user;
      return UserDto(
        id: supabaseUser.id,
        email: supabaseUser.email!,
        displayName: supabaseUser.userMetadata?['display_name'],
        photoUrl: supabaseUser.userMetadata?['photo_url'],
        createdAt: DateTime.parse(supabaseUser.createdAt),
      );
    } catch (e) {
      throw QuoteVaultAuthException('Failed to get current user: $e');
    }
  }

  /// Sign in with email and password
  Future<UserDto> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final supabaseUser = response.user;
      if (supabaseUser == null) {
        throw QuoteVaultAuthException('Sign in failed: No user returned');
      }

      return UserDto(
        id: supabaseUser.id,
        email: supabaseUser.email!,
        displayName: supabaseUser.userMetadata?['display_name'],
        photoUrl: supabaseUser.userMetadata?['photo_url'],
        createdAt: DateTime.parse(supabaseUser.createdAt),
      );
    } on QuoteVaultAuthException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('Invalid login credentials')) {
        throw QuoteVaultAuthException('Invalid email or password');
      }
      throw QuoteVaultAuthException('Sign in failed: $e');
    }
  }

  /// Create account with email and password
  Future<UserDto> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final supabaseUser = response.user;
      if (supabaseUser == null) {
        throw QuoteVaultAuthException('Sign up failed: No user returned');
      }

      return UserDto(
        id: supabaseUser.id,
        email: supabaseUser.email!,
        displayName: supabaseUser.userMetadata?['display_name'],
        photoUrl: supabaseUser.userMetadata?['photo_url'],
        createdAt: DateTime.parse(supabaseUser.createdAt),
      );
    } on QuoteVaultAuthException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('already registered')) {
        throw QuoteVaultAuthException('An account with this email already exists');
      }
      throw QuoteVaultAuthException('Sign up failed: $e');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'quotevault://reset-password', // Deep link
      );
    } on QuoteVaultAuthException {
      rethrow;
    } catch (e) {
      throw QuoteVaultAuthException('Failed to send reset email: $e');
    }
  }

  /// Update password (called after user clicks reset link)
  Future<void> updatePassword({
    required String newPassword,
  }) async {
    try {
      await _client.auth.updateUser(
        supabase.UserAttributes(password: newPassword),
      );
    } on QuoteVaultAuthException {
      rethrow;
    } catch (e) {
      throw QuoteVaultAuthException('Failed to update password: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw QuoteVaultAuthException('Sign out failed: $e');
    }
  }

  /// Stream of auth state changes
  Stream<UserDto?> authStateChanges() {
    return _client.auth.onAuthStateChange.map((data) {
      final session = data.session;
      if (session == null) return null;

      final supabaseUser = session.user;
      return UserDto(
        id: supabaseUser.id,
        email: supabaseUser.email!,
        displayName: supabaseUser.userMetadata?['display_name'],
        photoUrl: supabaseUser.userMetadata?['photo_url'],
        createdAt: DateTime.parse(supabaseUser.createdAt),
      );
    });
  }
}
