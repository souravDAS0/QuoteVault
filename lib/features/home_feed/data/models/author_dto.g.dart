// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) => _AuthorDto(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$AuthorDtoToJson(_AuthorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'avatar_url': instance.avatarUrl,
    };
