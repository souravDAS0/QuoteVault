import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../core/utils/validators.dart';
import '../state/reset_password_state.dart';
import '../providers/auth_state_provider.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  @override
  ResetPasswordState build() {
    return const ResetPasswordState();
  }

  void updateNewPassword(String password) {
    state = state.copyWith(newPassword: password, errorMessage: null);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      errorMessage: null,
    );
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  bool get passwordsMatch {
    return Validators.passwordsMatch(
      state.newPassword,
      state.confirmPassword,
    );
  }

  bool get isPasswordValid {
    return Validators.isValidPassword(state.newPassword);
  }

  bool get hasMinLength {
    return Validators.hasMinLength(state.newPassword);
  }

  bool get hasNumber {
    return Validators.hasNumber(state.newPassword);
  }

  bool get hasSymbol {
    return Validators.hasSymbol(state.newPassword);
  }

  Future<bool> updatePassword() async {
    // Validation
    if (state.newPassword.isEmpty) {
      state = state.copyWith(errorMessage: 'Password is required');
      return false;
    }

    if (!isPasswordValid) {
      state = state.copyWith(
        errorMessage: 'Password does not meet requirements',
      );
      return false;
    }

    if (!passwordsMatch) {
      state = state.copyWith(errorMessage: 'Passwords do not match');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.updatePassword(newPassword: state.newPassword);

      state = state.copyWith(isLoading: false);
      return true;
    } on QuoteVaultAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred',
      );
      return false;
    }
  }
}
