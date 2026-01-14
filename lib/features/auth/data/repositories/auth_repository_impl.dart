import '../../domain/entities/qv_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_datasource.dart';

/// Concrete implementation of AuthRepository using Supabase
/// Converts between DTOs and domain entities
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<QvUser?> getCurrentUser() async {
    final userDto = await _datasource.getCurrentUser();
    return userDto?.toDomain();
  }

  @override
  Future<QvUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userDto = await _datasource.signInWithEmail(
      email: email,
      password: password,
    );
    return userDto.toDomain();
  }

  @override
  Future<QvUser> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final userDto = await _datasource.signUpWithEmail(
      email: email,
      password: password,
    );
    return userDto.toDomain();
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _datasource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    await _datasource.updatePassword(newPassword: newPassword);
  }

  @override
  Future<void> signOut() async {
    await _datasource.signOut();
  }

  @override
  Stream<QvUser?> authStateChanges() {
    return _datasource.authStateChanges().map((userDto) => userDto?.toDomain());
  }
}
