import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/qv_user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// Data Transfer Object for User
/// Handles JSON serialization/deserialization and conversion to domain entity
@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Convert DTO to domain entity
  QvUser toDomain() {
    return QvUser(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      createdAt: createdAt,
    );
  }

  /// Create DTO from domain entity
  factory UserDto.fromDomain(QvUser user) {
    return UserDto(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      createdAt: user.createdAt,
    );
  }
}
