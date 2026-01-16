import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local_settings_datasource.dart';
import '../datasources/supabase_settings_datasource.dart';

/// Implementation of SettingsRepository
class SettingsRepositoryImpl implements SettingsRepository {
  final LocalSettingsDatasource _localDatasource;
  final SupabaseSettingsDatasource _cloudDatasource;

  SettingsRepositoryImpl(this._localDatasource, this._cloudDatasource);

  @override
  Future<UserSettings> getSettings() async {
    // First try local storage
    final localSettings = _localDatasource.getSettings();
    if (localSettings != null) {
      return localSettings;
    }

    // If no local settings, try cloud
    final cloudSettings = await _cloudDatasource.getSettings();
    if (cloudSettings != null) {
      // Save to local for future use
      await _localDatasource.saveSettings(cloudSettings);
      return cloudSettings;
    }

    // Return defaults
    return const UserSettings();
  }

  @override
  Future<void> saveSettingsLocally(UserSettings settings) async {
    await _localDatasource.saveSettings(settings);
  }

  @override
  Future<void> syncSettingsToCloud(UserSettings settings) async {
    await _cloudDatasource.saveSettings(settings);
  }

  @override
  Future<UserSettings> loadSettingsFromCloud() async {
    final cloudSettings = await _cloudDatasource.getSettings();
    if (cloudSettings != null) {
      // Update local storage with cloud settings
      await _localDatasource.saveSettings(cloudSettings);
      return cloudSettings;
    }
    return const UserSettings();
  }

  @override
  Future<void> clearLocalSettings() async {
    await _localDatasource.clearSettings();
  }
}
