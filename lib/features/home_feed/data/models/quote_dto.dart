import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quote.dart';

part 'quote_dto.freezed.dart';
part 'quote_dto.g.dart';

/// Data Transfer Object for Quote
/// Handles JSON serialization/deserialization and conversion to domain entity
@freezed
abstract class QuoteDto with _$QuoteDto {
  const QuoteDto._();

  const factory QuoteDto({
    required String id,
    required String text,
    @JsonKey(name: 'author_id') required String authorId,
    @JsonKey(name: 'author_name') required String authorName,
    @JsonKey(name: 'author_description') String? authorDescription,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'is_bookmarked') @Default(false) bool isBookmarked,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);

  /// Convert DTO to domain entity
  Quote toDomain() {
    return Quote(
      id: id,
      text: text,
      authorId: authorId,
      authorName: authorName,
      authorDescription: authorDescription,
      categoryId: categoryId,
      categoryName: categoryName,
      likesCount: likesCount,
      isFavorite: isFavorite,
      isBookmarked: isBookmarked,
      isFeatured: isFeatured,
      imageUrl: imageUrl,
      createdAt: createdAt,
    );
  }

  /// Create DTO from domain entity
  factory QuoteDto.fromDomain(Quote quote) {
    return QuoteDto(
      id: quote.id,
      text: quote.text,
      authorId: quote.authorId,
      authorName: quote.authorName,
      authorDescription: quote.authorDescription,
      categoryId: quote.categoryId,
      categoryName: quote.categoryName,
      likesCount: quote.likesCount,
      isFavorite: quote.isFavorite,
      isBookmarked: quote.isBookmarked,
      isFeatured: quote.isFeatured,
      imageUrl: quote.imageUrl,
      createdAt: quote.createdAt,
    );
  }
}
