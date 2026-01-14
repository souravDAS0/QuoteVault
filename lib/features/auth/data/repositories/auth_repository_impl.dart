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

  @override
  Future<QvUser> updateDisplayName(String displayName) async {
    final userDto = await _datasource.updateDisplayName(displayName);
    return userDto.toDomain();
  }

  @override
  Future<QvUser> updateAvatar(String filePath) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    final photoUrl = await _datasource.uploadAvatar(currentUser.id, filePath);
    // Append timestamp to bust cache
    final timestampedUrl =
        '$photoUrl?t=${DateTime.now().millisecondsSinceEpoch}';
    final userDto = await _datasource.updateUserProfile(
      photoUrl: timestampedUrl,
    );
    return userDto.toDomain();
  }

  @override
  Future<QvUser> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    final userDto = await _datasource.updateUserProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );
    return userDto.toDomain();
  }
}
