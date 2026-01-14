// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_statistics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileStatisticsDto _$ProfileStatisticsDtoFromJson(
  Map<String, dynamic> json,
) => _ProfileStatisticsDto(
  favoritesCount: (json['favoritesCount'] as num).toInt(),
  collectionsCount: (json['collectionsCount'] as num).toInt(),
);

Map<String, dynamic> _$ProfileStatisticsDtoToJson(
  _ProfileStatisticsDto instance,
) => <String, dynamic>{
  'favoritesCount': instance.favoritesCount,
  'collectionsCount': instance.collectionsCount,
};
