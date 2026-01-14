/// Authentication-related constants
/// Includes routes, UI strings, validation messages, and password requirements
class AuthConstants {
  // Routes
  static const String signInRoute = '/sign-in';
  static const String signUpRoute = '/sign-up';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String resetPasswordRoute = '/reset-password';
  static const String homeRoute = '/home';

  // Strings (following UI reference images)
  static const String welcomeBack = 'Welcome back!';
  static const String signInSubtitle =
      'Sign in to access your quote collection.';
  static const String joinTheVault = 'Join the Vault';
  static const String signUpSubtitle =
      'Save, share, and discover the world\'s best quotes.';
  static const String forgotPasswordTitle = 'Forgot Password?';
  static const String forgotPasswordSubtitle =
      'Don\'t worry! It happens. Enter your email to receive a reset link.';
  static const String forgotPasswordSubtitleAlt =
      'Enter your email address to receive a reset link.';
  static const String resetPasswordTitle = 'Reset Your Key';
  static const String changePasswordTitle = 'Change Password';
  static const String resetPasswordSubtitle =
      'Choose a strong password to keep your quote collection safe.';

  // Button labels
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String createAccount = 'Create Account';
  static const String sendResetLink = 'Send Reset Link';
  static const String updatePassword = 'Update Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String rememberPassword = 'Remembered your password?';
  static const String logIn = 'Log In';
  static const String dontHaveAccount = 'Don\'t have an account?';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String orContinueWith = 'Or continue with';
  static const String orSignUpWith = 'Or sign up with';
  static const String help = 'Help';
  static const String security = 'Security';

  // Input labels
  static const String emailAddress = 'Email Address';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String newPassword = 'New Password';

  // Validation messages
  static const String passwordsMatch = 'Passwords match';
  static const String weakPassword = 'Weak password';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String emailRequired = 'Email is required';
  static const String passwordsDoNotMatch = 'Passwords do not match';

  // Password requirements
  static const String requirementsTitle = 'REQUIREMENTS';
  static const String requirement8Chars = 'At least 8 characters';
  static const String requirementNumber = 'Contains a number';
  static const String requirementSymbol = 'Contains a symbol';

  // Success messages
  static const String resetEmailSent =
      'Password reset link sent! Check your email.';
  static const String passwordUpdated = 'Password updated successfully!';

  // Social auth (disabled for now)
  static const String google = 'Google';
  static const String apple = 'Apple';
  static const String comingSoon = 'Coming Soon';

  // Security footer
  static const String protectedBy = 'Protected by QuoteVault Security';
}
