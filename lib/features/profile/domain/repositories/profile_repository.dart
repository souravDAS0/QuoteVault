import '../entities/profile_statistics.dart';

/// Repository interface for profile operations
/// NO framework dependencies, NO implementation details
abstract class ProfileRepository {
  /// Get user profile statistics (favorites count, collections count)
  Future<ProfileStatistics> getProfileStatistics();
}
