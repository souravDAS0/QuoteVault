import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../core/utils/validators.dart';
import '../state/forgot_password_state.dart';
import '../providers/auth_state_provider.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  ForgotPasswordState build() {
    return const ForgotPasswordState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email, errorMessage: null);
  }

  Future<bool> sendResetLink() async {
    // Validation
    if (state.email.isEmpty) {
      state = state.copyWith(errorMessage: 'Email is required');
      return false;
    }

    if (!Validators.isValidEmail(state.email)) {
      state = state.copyWith(errorMessage: 'Please enter a valid email');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.sendPasswordResetEmail(email: state.email);

      state = state.copyWith(isLoading: false, emailSent: true);
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
