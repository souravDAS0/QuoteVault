import 'package:freezed_annotation/freezed_annotation.dart';

part 'qv_user.freezed.dart';

/// Domain entity representing a user
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class QvUser with _$QvUser {
  const factory QvUser({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
  }) = _QvUser;
}
