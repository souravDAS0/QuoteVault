import 'package:quote_vault/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/qv_user.dart';
import '../../data/datasources/supabase_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_state_provider.g.dart';

/// Provider for Supabase datasource
@riverpod
SupabaseAuthDatasource supabaseAuthDatasource(Ref ref) {
  return SupabaseAuthDatasource(supabase.Supabase.instance.client);
}

/// Provider for auth repository
@riverpod
AuthRepository authRepository(Ref ref) {
  final datasource = ref.watch(supabaseAuthDatasourceProvider);
  return AuthRepositoryImpl(datasource);
}

/// Stream provider for auth state changes
@riverpod
Stream<QvUser?> authStateChanges(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
}

/// Provider for current user
@riverpod
FutureOr<QvUser?> currentUser(Ref ref) async {
  // Watch auth state changes to react to updates (sign in, sign out, user update)
  final authState = ref.watch(authStateChangesProvider);

  // If we have a user from the stream, return it
  if (authState.hasValue) {
    return authState.value;
  }

  // Fallback to fetching current user directly
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
}
