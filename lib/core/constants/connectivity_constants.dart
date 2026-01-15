/// String constants for connectivity-related UI
abstract class ConnectivityConstants {
  // Banner strings
  static const String offlineTitle = 'No internet connection';
  static const String offlineSubtitle = 'Some features may be unavailable';
  static const String pendingOperations = 'pending';
  static const String retryButton = 'Retry';

  // Reconnection strings
  static const String backOnline = 'Back online';
  static const String refresh = 'Refresh';

  // Error messages
  static const String networkError = 'Network error. Please check your connection.';
  static const String operationQueued = 'Operation saved. Will sync when online.';
  static const String retryFailed = 'Retry failed. Please try again later.';

  // Auth screen strings
  static const String signInRequiresInternet = 'Sign in requires internet connection';
  static const String signUpRequiresInternet = 'Sign up requires internet connection';
  static const String searchRequiresInternet = 'Search requires internet connection';
}
