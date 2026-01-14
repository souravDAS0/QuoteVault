import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/author.dart';

part 'author_dto.freezed.dart';
part 'author_dto.g.dart';

/// Data Transfer Object for Author
/// Handles JSON serialization/deserialization and conversion to domain entity
@freezed
abstract class AuthorDto with _$AuthorDto {
  const AuthorDto._();

  const factory AuthorDto({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  /// Convert DTO to domain entity
  Author toDomain() {
    return Author(
      id: id,
      name: name,
      description: description,
      avatarUrl: avatarUrl,
    );
  }

  /// Create DTO from domain entity
  factory AuthorDto.fromDomain(Author author) {
    return AuthorDto(
      id: author.id,
      name: author.name,
      description: author.description,
      avatarUrl: author.avatarUrl,
    );
  }
}
