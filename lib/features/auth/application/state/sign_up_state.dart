import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isLoading,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureConfirmPassword,
    String? errorMessage,
  }) = _SignUpState;
}
