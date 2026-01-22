class DebugConstants {
  // Route
  static const String debugLogsRoute = '/debug-logs';

  // Screen
  static const String debugLogsScreenTitle = 'Debug Logs';

  // Menu
  static const String debugLogsMenuItem = 'Debug Logs';

  // Filters
  static const String filterAll = 'All';
  static const String filterDebug = 'Debug';
  static const String filterInfo = 'Info';
  static const String filterWarning = 'Warning';
  static const String filterError = 'Error';

  // Actions
  static const String copyLogsTooltip = 'Copy all logs';
  static const String clearLogsTooltip = 'Clear all logs';

  // Messages
  static const String noLogsMessage = 'No logs available';
  static const String logsCopiedMessage = 'Logs copied to clipboard';
  static const String clearLogsDialogTitle = 'Clear Logs';
  static const String clearLogsDialogMessage =
      'Are you sure you want to clear all logs? This action cannot be undone.';
  static const String clearLogsDialogCancel = 'Cancel';
  static const String clearLogsDialogConfirm = 'Clear';

  // Entry count
  static String entryCount(int count) => '$count ${count == 1 ? 'entry' : 'entries'}';
}
