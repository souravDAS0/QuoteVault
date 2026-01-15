import 'package:quote_vault/features/home_feed/application/providers/quote_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/notification_manager_provider.dart';
import '../../domain/entities/user_settings.dart';
import '../providers/settings_providers.dart';
import '../state/settings_state.dart';

part 'settings_controller.g.dart';

/// Controller for settings/personalization screen
@riverpod
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() {
    _loadSettings();
    return const SettingsState(isLoading: true);
  }

  /// Load settings from repository
  Future<void> _loadSettings() async {
    try {
      final repository = await ref.read(settingsRepositoryProvider.future);
      final settings = await repository.getSettings();

      state = state.copyWith(
        settings: settings,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load settings: $e',
      );
    }
  }

  /// Update theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    final newSettings = state.settings.copyWith(themeMode: mode);
    await _updateSettings(newSettings);
  }

  /// Update font size preset
  Future<void> setFontSizePreset(FontSizePreset preset) async {
    final newSettings = state.settings.copyWith(fontSizePreset: preset);
    await _updateSettings(newSettings);
  }

  /// Toggle notifications enabled
  Future<void> setNotificationsEnabled(bool enabled) async {
    final newSettings = state.settings.copyWith(notificationsEnabled: enabled);
    await _updateSettings(newSettings);

    // Reschedule notifications
    await _rescheduleNotifications(newSettings);
  }

  /// Update notification time
  Future<void> setNotificationTime(int hour, int minute) async {
    final newSettings = state.settings.copyWith(
      notificationHour: hour,
      notificationMinute: minute,
    );
    await _updateSettings(newSettings);

    // Reschedule notifications with new time
    await _rescheduleNotifications(newSettings);
  }

  /// Update settings locally and sync to cloud
  Future<void> _updateSettings(UserSettings newSettings) async {
    // Update state immediately for real-time UI update
    state = state.copyWith(settings: newSettings, isSaving: true);

    try {
      final repository = await ref.read(settingsRepositoryProvider.future);

      // Save locally first (fast)
      await repository.saveSettingsLocally(newSettings);

      // Sync to cloud in background
      state = state.copyWith(isSaving: false, isSyncing: true);
      await repository.syncSettingsToCloud(newSettings);

      state = state.copyWith(isSyncing: false, syncError: null);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        isSyncing: false,
        syncError: 'Failed to sync settings: $e',
      );
    }
  }

  /// Refresh settings from cloud
  Future<void> refreshFromCloud() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = await ref.read(settingsRepositoryProvider.future);
      final settings = await repository.loadSettingsFromCloud();

      state = state.copyWith(settings: settings, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to refresh settings: $e',
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null, syncError: null);
  }

  /// Reschedule notifications based on new settings
  Future<void> _rescheduleNotifications(UserSettings settings) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);

      if (settings.notificationsEnabled) {
        // Get daily quote for notification content
        final repository = ref.read(quoteRepositoryProvider);
        final dailyQuote = await repository.getDailyQuote();
        // Use a generic message for now - the notification manager will update it

        if (dailyQuote != null) {
          await notificationService.scheduleDailyNotification(
            hour: settings.notificationHour,
            minute: settings.notificationMinute,
            title: 'Quote of the Day ☀️',
            body: '"${dailyQuote.text}" - ${dailyQuote.authorName}',
          );
        }
      } else {
        await notificationService.cancelDailyNotification();
      }
    } catch (e) {
      print('Error rescheduling notifications: $e');
    }
  }

  /// Schedule initial notifications on app startup
  Future<void> scheduleInitialNotifications() async {
    if (state.settings.notificationsEnabled) {
      await _rescheduleNotifications(state.settings);
    }
  }
}
