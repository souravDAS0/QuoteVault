import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(true) bool obscurePassword,
    String? errorMessage,
  }) = _SignInState;
}
