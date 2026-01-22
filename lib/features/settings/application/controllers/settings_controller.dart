import 'package:quote_vault/features/home_feed/application/providers/quote_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/providers/notification_manager_provider.dart';
import '../../../../core/providers/log_service_provider.dart';
import '../../../../core/services/daily_quote_worker.dart';
import '../../domain/entities/user_settings.dart';
import '../providers/settings_providers.dart';
import '../state/settings_state.dart';

part 'settings_controller.g.dart';

/// Controller for settings/personalization screen
@riverpod
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() {
    // Schedule initial data load after build completes
    Future.microtask(() => _loadSettings());
    return const SettingsState(isLoading: true);
  }

  /// Load settings from repository (local first, then cloud fallback)
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

  /// Sync settings from cloud after login
  /// Called when user logs in to fetch their settings from Supabase
  Future<void> syncFromCloud() async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = await ref.read(settingsRepositoryProvider.future);
      final settings = await repository.loadSettingsFromCloud();

      state = state.copyWith(
        settings: settings,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // Fall back to local/defaults on error
      await _loadSettings();
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
    final logger = await ref.read(logServiceProvider.future);

    try {
      final notificationService = await ref.read(notificationServiceProvider.future);

      if (settings.notificationsEnabled) {
        // Request permission first
        final permissionGranted = await notificationService.requestPermission();

        if (!permissionGranted) {
          await logger.warning('Notification permission denied', 'SettingsController');
          return;
        }

        // Get daily quote for notification content
        final repository = ref.read(quoteRepositoryProvider);
        final dailyQuote = await repository.getDailyQuote();
        // Use a generic message for now - the notification manager will update it

        if (dailyQuote != null) {
          await notificationService.scheduleDailyNotification(
            hour: settings.notificationHour,
            minute: settings.notificationMinute,
            title: 'Quote of the Day ☀️',
            body: '${dailyQuote.text} \n - ${dailyQuote.authorName}',
          );
          await logger.info(
            'Notification scheduled for ${settings.notificationHour}:${settings.notificationMinute.toString().padLeft(2, '0')}',
            'SettingsController',
          );
        }

        // Register WorkManager task to update quote at midnight
        await _registerDailyQuoteTask();
      } else {
        await notificationService.cancelDailyNotification();

        // Cancel WorkManager task when notifications are disabled
        await Workmanager().cancelByUniqueName(dailyQuoteTaskName);
        await logger.info('WorkManager task cancelled', 'SettingsController');
      }
    } catch (e, stackTrace) {
      await logger.error(
        'Error rescheduling notifications: $e',
        'SettingsController',
        stackTrace: stackTrace.toString(),
      );
    }
  }

  /// Register WorkManager periodic task to update daily quote at midnight
  Future<void> _registerDailyQuoteTask() async {
    final logger = await ref.read(logServiceProvider.future);

    try {
      // Cancel any existing task first
      await Workmanager().cancelByUniqueName(dailyQuoteTaskName);

      // Calculate time until next 00:30 IST
      // IST is UTC+5:30, so 00:30 IST = 19:00 UTC (previous day)
      final nowUtc = DateTime.now().toUtc();

      // Calculate next 00:30 IST in UTC terms
      // 00:30 IST = 19:00 UTC (previous day)
      var nextRunUtc = DateTime.utc(
        nowUtc.year,
        nowUtc.month,
        nowUtc.day,
        19, // 19:00 UTC = 00:30 IST next day
        0,
        0,
      );

      // If we've already passed 19:00 UTC today, schedule for tomorrow
      if (nextRunUtc.isBefore(nowUtc) || nextRunUtc.isAtSameMomentAs(nowUtc)) {
        nextRunUtc = nextRunUtc.add(const Duration(days: 1));
      }

      final initialDelay = nextRunUtc.difference(nowUtc);

      // Convert to IST for logging
      final nextRunIst = nextRunUtc.add(const Duration(hours: 5, minutes: 30));

      // Register periodic task that runs daily at midnight
      await Workmanager().registerPeriodicTask(
        dailyQuoteTaskName,
        dailyQuoteTaskName,
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay,
        constraints: Constraints(
          networkType: NetworkType.connected, // Require network to fetch quote
        ),
      );

      await logger.info(
        'WorkManager task registered. Next run at: $nextRunIst IST (${nextRunUtc} UTC) (initial delay: ${initialDelay.inMinutes} minutes)',
        'SettingsController',
      );
    } catch (e, stackTrace) {
      await logger.error(
        'Error registering WorkManager task: $e',
        'SettingsController',
        stackTrace: stackTrace.toString(),
      );
    }
  }

  // Future<void> showTestNotification() async {
  //   final notificationService = ref.read(notificationServiceProvider);
  //   await notificationService.showImmediateNotification(
  //     title: 'Quote of the Day ☀️',
  //     body:
  //         'A wise man can learn more from a follish question than a fool can learn from a wise answer. is a test notification with a large body. \n and it has a very very large body ',
  //   );
  // }

  /// Schedule initial notifications on app startup
  Future<void> scheduleInitialNotifications() async {
    // Don't refresh from cloud here - settings are already loaded when this is called
    // Refreshing would trigger the listener again causing infinite loop
    if (state.settings.notificationsEnabled) {
      await _rescheduleNotifications(state.settings);
    }
  }
}
