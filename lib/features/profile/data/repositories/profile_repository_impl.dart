import '../../domain/entities/profile_statistics.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/supabase_profile_datasource.dart';

/// Implementation of ProfileRepository using Supabase
class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseProfileDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<ProfileStatistics> getProfileStatistics() async {
    try {
      // Fetch both counts in parallel
      final results = await Future.wait([
        _datasource.getFavoritesCount(),
        _datasource.getCollectionsCount(),
      ]);

      return ProfileStatistics(
        favoritesCount: results[0],
        collectionsCount: results[1],
      );
    } catch (e) {
      throw Exception('Failed to load profile statistics: $e');
    }
  }
}
