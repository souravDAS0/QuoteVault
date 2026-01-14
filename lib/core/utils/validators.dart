import 'package:email_validator/email_validator.dart';

/// Validation utilities for authentication forms
class Validators {
  /// Validate email format using email_validator package
  static bool isValidEmail(String email) {
    return EmailValidator.validate(email.trim());
  }

  /// Validate password meets all requirements
  /// Requirements: min 8 characters + contains number + contains symbol
  static bool isValidPassword(String password) {
    return hasMinLength(password) &&
        hasNumber(password) &&
        hasSymbol(password);
  }

  /// Check password has minimum 8 characters
  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  /// Check password contains at least one number
  static bool hasNumber(String password) {
    return RegExp(r'\d').hasMatch(password);
  }

  /// Check password contains at least one symbol
  static bool hasSymbol(String password) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  /// Validate passwords match and are not empty
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword && password.isNotEmpty;
  }
}
