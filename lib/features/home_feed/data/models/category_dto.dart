import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

/// Data Transfer Object for Category
/// Handles JSON serialization/deserialization and conversion to domain entity
@freezed
abstract class CategoryDto with _$CategoryDto {
  const CategoryDto._();

  const factory CategoryDto({
    required String id,
    required String name,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  /// Convert DTO to domain entity
  Category toDomain({bool isSelected = false}) {
    return Category(
      id: id,
      name: name,
      isSelected: isSelected,
    );
  }

  /// Create DTO from domain entity
  factory CategoryDto.fromDomain(Category category) {
    return CategoryDto(
      id: category.id,
      name: category.name,
    );
  }
}
