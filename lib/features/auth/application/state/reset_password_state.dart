import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(false) bool isLoading,
    @Default(true) bool obscureNewPassword,
    @Default(true) bool obscureConfirmPassword,
    String? errorMessage,
  }) = _ResetPasswordState;
}
