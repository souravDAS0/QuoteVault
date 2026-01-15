/// Constants for settings/personalization feature
abstract class SettingsConstants {
  // Route
  static const String personalizationRoute = '/personalization';

  // Screen
  static const String screenTitle = 'Personalization';

  // Section titles
  static const String previewSection = 'Preview';
  static const String appearanceSection = 'Appearance';
  static const String typographySection = 'Typography';
  static const String notificationsSection = 'Notifications';
  static const String backgroundStylesSection = 'Background Styles';

  // Preview
  static const String previewHint = 'Changes update in real-time above';
  static const String previewQuote = '"Creativity is intelligence having fun."';
  static const String previewAuthor = '– Albert Einstein';

  // Appearance labels
  static const String lightLabel = 'Light';
  static const String darkLabel = 'Dark';
  static const String systemLabel = 'System';
  static const String tealLabel = 'Teal';
  static const String goldLabel = 'Gold';

  // Typography labels

  static const String pxSuffix = 'px';

  // Notifications labels
  static const String dailyQuoteLabel = 'Daily Quote';
  static const String dailyQuoteDescription = 'Receive your daily inspiration';
  static const String amLabel = 'AM';
  static const String pmLabel = 'PM';

  // Background styles
  static const String backgroundStylesLabel = 'Background Styles';
  static const String backgroundStylesDescription =
      'Gradients, solid colors & images';

  // Font size bounds
  static const int minFontSize = 14;
  static const int maxFontSize = 28;
  static const int defaultFontSize = 18;
}
