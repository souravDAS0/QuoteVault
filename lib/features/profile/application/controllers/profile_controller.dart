import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/profile_state.dart';
import '../providers/profile_providers.dart';
import '../../../auth/application/providers/auth_state_provider.dart';

part 'profile_controller.g.dart';

/// Controller for profile screen
@riverpod
class ProfileController extends _$ProfileController {
  @override
  ProfileState build() {
    _loadStatistics();
    return const ProfileState(isLoading: true);
  }

  /// Load profile statistics
  Future<void> _loadStatistics() async {
    try {
      final repository = ref.read(profileRepositoryProvider);
      final statistics = await repository.getProfileStatistics();

      state = state.copyWith(
        statistics: statistics,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load profile statistics: $e',
      );
    }
  }

  /// Refresh profile statistics
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _loadStatistics();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Update user's display name
  Future<void> updateDisplayName(String displayName) async {
    if (displayName.trim().isEmpty) {
      state = state.copyWith(updateError: 'Display name cannot be empty');
      return;
    }

    try {
      state = state.copyWith(isUpdating: true, updateError: null);

      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.updateDisplayName(displayName.trim());

      state = state.copyWith(isUpdating: false);
      // Auth state will update automatically via authStateChanges stream
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        updateError: 'Failed to update display name: $e',
      );
    }
  }

  /// Upload and update user's avatar
  Future<void> updateAvatar(String filePath) async {
    try {
      state = state.copyWith(isUpdating: true, updateError: null);

      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.updateAvatar(filePath);

      state = state.copyWith(isUpdating: false);
      // Auth state will update automatically via authStateChanges stream
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        updateError: 'Failed to update avatar: $e',
      );
    }
  }

  /// Update user profile with optional display name and photo URL
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    try {
      state = state.copyWith(isUpdating: true, updateError: null);

      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.updateUserProfile(
        displayName: displayName,
        photoUrl: photoUrl,
      );

      state = state.copyWith(isUpdating: false);
      // Auth state will update automatically via authStateChanges stream
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        updateError: 'Failed to update profile: $e',
      );
    }
  }
}
