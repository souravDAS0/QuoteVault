import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../core/utils/validators.dart';
import '../state/sign_up_state.dart';
import '../providers/auth_state_provider.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  SignUpState build() {
    return const SignUpState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      errorMessage: null,
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  bool get passwordsMatch {
    return Validators.passwordsMatch(state.password, state.confirmPassword);
  }

  bool get isPasswordValid {
    return Validators.isValidPassword(state.password);
  }

  Future<bool> signUp() async {
    // Validation
    if (state.email.isEmpty) {
      state = state.copyWith(errorMessage: 'Email is required');
      return false;
    }

    if (!Validators.isValidEmail(state.email)) {
      state = state.copyWith(errorMessage: 'Please enter a valid email');
      return false;
    }

    if (state.password.isEmpty) {
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
      await repository.signUpWithEmail(
        email: state.email,
        password: state.password,
      );

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
