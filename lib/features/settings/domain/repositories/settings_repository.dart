import '../entities/user_settings.dart';

/// Repository interface for settings operations
/// NO framework dependencies, NO implementation details
abstract class SettingsRepository {
  /// Get user settings (from local storage, fallback to defaults)
  Future<UserSettings> getSettings();

  /// Save settings locally
  Future<void> saveSettingsLocally(UserSettings settings);

  /// Sync settings to cloud (Supabase profile)
  Future<void> syncSettingsToCloud(UserSettings settings);

  /// Load settings from cloud and merge with local
  Future<UserSettings> loadSettingsFromCloud();

  /// Clear local settings cache (used on logout)
  Future<void> clearLocalSettings();
}
