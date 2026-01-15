import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_settings.dart';

/// Local datasource for settings using SharedPreferences
class LocalSettingsDatasource {
  static const String _settingsKey = 'user_settings';

  final SharedPreferences _prefs;

  LocalSettingsDatasource(this._prefs);

  /// Get settings from local storage
  UserSettings? getSettings() {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserSettings.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Save settings to local storage
  Future<void> saveSettings(UserSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, jsonString);
  }

  /// Clear local settings
  Future<void> clearSettings() async {
    await _prefs.remove(_settingsKey);
  }
}
