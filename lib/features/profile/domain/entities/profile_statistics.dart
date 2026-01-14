import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_statistics.freezed.dart';

/// Domain entity representing user profile statistics
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class ProfileStatistics with _$ProfileStatistics {
  const factory ProfileStatistics({
    required int favoritesCount,
    required int collectionsCount,
  }) = _ProfileStatistics;
}
