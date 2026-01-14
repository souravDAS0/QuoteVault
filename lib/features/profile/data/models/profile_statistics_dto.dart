import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_statistics.dart';

part 'profile_statistics_dto.freezed.dart';
part 'profile_statistics_dto.g.dart';

/// DTO for profile statistics from Supabase
@freezed
abstract class ProfileStatisticsDto with _$ProfileStatisticsDto {
  const ProfileStatisticsDto._();

  const factory ProfileStatisticsDto({
    required int favoritesCount,
    required int collectionsCount,
  }) = _ProfileStatisticsDto;

  factory ProfileStatisticsDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatisticsDtoFromJson(json);

  /// Convert DTO to domain entity
  ProfileStatistics toDomain() {
    return ProfileStatistics(
      favoritesCount: favoritesCount,
      collectionsCount: collectionsCount,
    );
  }
}
