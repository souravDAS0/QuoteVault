import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/collection.dart';

part 'collection_dto.freezed.dart';
part 'collection_dto.g.dart';

/// Data Transfer Object for Collection
/// Handles JSON serialization and conversion to domain entity
@freezed
abstract class CollectionDto with _$CollectionDto {
  const CollectionDto._();

  const factory CollectionDto({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'quote_count') @Default(0) int quoteCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _CollectionDto;

  factory CollectionDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionDtoFromJson(json);

  /// Convert DTO to domain entity
  Collection toDomain() {
    return Collection(
      id: id,
      userId: userId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      quoteCount: quoteCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create DTO from domain entity
  factory CollectionDto.fromDomain(Collection collection) {
    return CollectionDto(
      id: collection.id,
      userId: collection.userId,
      name: collection.name,
      description: collection.description,
      imageUrl: collection.imageUrl,
      quoteCount: collection.quoteCount,
      createdAt: collection.createdAt,
      updatedAt: collection.updatedAt,
    );
  }
}
