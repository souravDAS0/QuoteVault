import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';

/// Domain entity representing a quote
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String text,
    required String authorId,
    required String authorName,
    String? authorDescription,
    required String categoryId,
    required String categoryName,
    @Default(0) int likesCount,
    @Default(false) bool isFavorite,
    @Default(false) bool isBookmarked,
    @Default(false) bool isFeatured,
    String? imageUrl,
    DateTime? createdAt,
  }) = _Quote;
}
