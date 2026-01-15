import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/user_settings.dart';

/// Datasource for settings-related Supabase queries
class SupabaseSettingsDatasource {
  final supabase.SupabaseClient _client;

  SupabaseSettingsDatasource(this._client);

  /// Get settings from cloud (profiles table)
  Future<UserSettings?> getSettings() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _client
        .from('profiles')
        .select(
          'theme_preference, font_size_preference, notifications_enabled, notification_time',
        )
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;

    return _mapResponseToSettings(response);
  }

  /// Save settings to cloud (profiles table)
  Future<void> saveSettings(UserSettings settings) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _client
        .from('profiles')
        .update({
          'theme_preference': _themeModeToString(settings.themeMode),
          'font_size_preference': _fontSizePresetToString(
            settings.fontSizePreset,
          ),
          'notifications_enabled': settings.notificationsEnabled,
          'notification_time': _timeToString(
            settings.notificationHour,
            settings.notificationMinute,
          ),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', userId);
  }

  UserSettings _mapResponseToSettings(Map<String, dynamic> response) {
    return UserSettings(
      themeMode: _stringToThemeMode(response['theme_preference'] as String?),
      fontSizePreset: _stringToFontSizePreset(
        response['font_size_preference'] as String?,
      ),
      notificationsEnabled: response['notifications_enabled'] as bool? ?? true,
      notificationHour: _parseNotificationHour(
        response['notification_time'] as String?,
      ),
      notificationMinute: _parseNotificationMinute(
        response['notification_time'] as String?,
      ),
    );
  }

  // Theme mode conversion
  String _themeModeToString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
      case AppThemeMode.blue:
        return 'blue';
      case AppThemeMode.violet:
        return 'violet';
    }
  }

  AppThemeMode _stringToThemeMode(String? value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'blue':
        return AppThemeMode.blue;
      case 'violet':
        return AppThemeMode.violet;
      default:
        return AppThemeMode.system;
    }
  }

  // Font size preset conversion
  String _fontSizePresetToString(FontSizePreset preset) {
    switch (preset) {
      case FontSizePreset.extraSmall:
        return 'extra-small';
      case FontSizePreset.small:
        return 'small';
      case FontSizePreset.medium:
        return 'medium';
      case FontSizePreset.large:
        return 'large';
      case FontSizePreset.extraLarge:
        return 'extra-large';
    }
  }

  FontSizePreset _stringToFontSizePreset(String? value) {
    // Handle potential legacy int strings or new preset strings
    switch (value) {
      case 'extra-small':
        return FontSizePreset.extraSmall;
      case 'small':
        return FontSizePreset.small;
      case 'large':
        return FontSizePreset.large;
      case 'extra-large':
        return FontSizePreset.extraLarge;
      case 'medium':
      default:
        return FontSizePreset.medium;
    }
  }

  // Time conversion
  String _timeToString(int hour, int minute) {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr:00';
  }

  int _parseNotificationHour(String? time) {
    if (time == null) return 8;
    final parts = time.split(':');
    if (parts.isEmpty) return 8;
    return int.tryParse(parts[0]) ?? 8;
  }

  int _parseNotificationMinute(String? time) {
    if (time == null) return 30;
    final parts = time.split(':');
    if (parts.length < 2) return 30;
    return int.tryParse(parts[1]) ?? 30;
  }
}
