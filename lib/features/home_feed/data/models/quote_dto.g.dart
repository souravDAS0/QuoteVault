// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => _QuoteDto(
  id: json['id'] as String,
  text: json['text'] as String,
  authorId: json['author_id'] as String,
  authorName: json['author_name'] as String,
  authorDescription: json['author_description'] as String?,
  categoryId: json['category_id'] as String,
  categoryName: json['category_name'] as String,
  likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
  isFavorite: json['is_favorite'] as bool? ?? false,
  isBookmarked: json['is_bookmarked'] as bool? ?? false,
  isFeatured: json['is_featured'] as bool? ?? false,
  imageUrl: json['image_url'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$QuoteDtoToJson(_QuoteDto instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'author_id': instance.authorId,
  'author_name': instance.authorName,
  'author_description': instance.authorDescription,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'likes_count': instance.likesCount,
  'is_favorite': instance.isFavorite,
  'is_bookmarked': instance.isBookmarked,
  'is_featured': instance.isFeatured,
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt?.toIso8601String(),
};
