import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_settings.dart';

part 'settings_state.freezed.dart';

/// State for the settings/personalization screen
@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(UserSettings()) UserSettings settings,
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSyncing,
    @Default(null) String? errorMessage,
    @Default(null) String? syncError,
  }) = _SettingsState;
}
