// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for AppThemeMode from settings

@ProviderFor(appThemeMode)
const appThemeModeProvider = AppThemeModeProvider._();

/// Provider for AppThemeMode from settings

final class AppThemeModeProvider
    extends $FunctionalProvider<AppThemeMode, AppThemeMode, AppThemeMode>
    with $Provider<AppThemeMode> {
  /// Provider for AppThemeMode from settings
  const AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  $ProviderElement<AppThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppThemeMode create(Ref ref) {
    return appThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'e0f4afd82d97ebe39cde331b7795512f5230d694';

/// Provider for the effective ThemeMode passed to MaterialApp
///
/// This handles the logic where generic Light/Dark/System map to ThemeMode,
/// but custom color themes (Blue/Violet) are forced as ThemeMode.light
/// so we can provide our custom ThemeData.

@ProviderFor(effectiveFlutterThemeMode)
const effectiveFlutterThemeModeProvider = EffectiveFlutterThemeModeProvider._();

/// Provider for the effective ThemeMode passed to MaterialApp
///
/// This handles the logic where generic Light/Dark/System map to ThemeMode,
/// but custom color themes (Blue/Violet) are forced as ThemeMode.light
/// so we can provide our custom ThemeData.

final class EffectiveFlutterThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// Provider for the effective ThemeMode passed to MaterialApp
  ///
  /// This handles the logic where generic Light/Dark/System map to ThemeMode,
  /// but custom color themes (Blue/Violet) are forced as ThemeMode.light
  /// so we can provide our custom ThemeData.
  const EffectiveFlutterThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveFlutterThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveFlutterThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return effectiveFlutterThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$effectiveFlutterThemeModeHash() =>
    r'c8e9ba8a57aa5e3b2f99c8a060d8169c240de901';

/// Provider for the effective ThemeData (light/custom)

@ProviderFor(effectiveTheme)
const effectiveThemeProvider = EffectiveThemeProvider._();

/// Provider for the effective ThemeData (light/custom)

final class EffectiveThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  /// Provider for the effective ThemeData (light/custom)
  const EffectiveThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveThemeHash();

  @$internal
  @override
  $ProviderElement<ThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeData create(Ref ref) {
    return effectiveTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeData>(value),
    );
  }
}

String _$effectiveThemeHash() => r'c27417515627859bae66cc5bbe8fad2f41923790';

/// Provider for the effective DarkThemeData
/// This is only used when we are in Light/Dark/System mode.
/// When in Blue/Violet, we force Light mode so this is ignored,
/// but we provide standard dark theme for System/Dark modes.

@ProviderFor(effectiveDarkTheme)
const effectiveDarkThemeProvider = EffectiveDarkThemeProvider._();

/// Provider for the effective DarkThemeData
/// This is only used when we are in Light/Dark/System mode.
/// When in Blue/Violet, we force Light mode so this is ignored,
/// but we provide standard dark theme for System/Dark modes.

final class EffectiveDarkThemeProvider
    extends $FunctionalProvider<ThemeData, ThemeData, ThemeData>
    with $Provider<ThemeData> {
  /// Provider for the effective DarkThemeData
  /// This is only used when we are in Light/Dark/System mode.
  /// When in Blue/Violet, we force Light mode so this is ignored,
  /// but we provide standard dark theme for System/Dark modes.
  const EffectiveDarkThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveDarkThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveDarkThemeHash();

  @$internal
  @override
  $ProviderElement<ThemeData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeData create(Ref ref) {
    return effectiveDarkTheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeData>(value),
    );
  }
}

String _$effectiveDarkThemeHash() =>
    r'fd4f100bf02909ffaff1087e26ad3eccb613b9fe';

/// Provider for current font size preset

@ProviderFor(fontSizePreset)
const fontSizePresetProvider = FontSizePresetProvider._();

/// Provider for current font size preset

final class FontSizePresetProvider
    extends $FunctionalProvider<FontSizePreset, FontSizePreset, FontSizePreset>
    with $Provider<FontSizePreset> {
  /// Provider for current font size preset
  const FontSizePresetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fontSizePresetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fontSizePresetHash();

  @$internal
  @override
  $ProviderElement<FontSizePreset> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FontSizePreset create(Ref ref) {
    return fontSizePreset(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FontSizePreset value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FontSizePreset>(value),
    );
  }
}

String _$fontSizePresetHash() => r'300d9789d1044dd7efdf5cd90723c682920482b2';

/// Provider for current font family

@ProviderFor(fontFamily)
const fontFamilyProvider = FontFamilyProvider._();

/// Provider for current font family

final class FontFamilyProvider
    extends $FunctionalProvider<FontFamily, FontFamily, FontFamily>
    with $Provider<FontFamily> {
  /// Provider for current font family
  const FontFamilyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fontFamilyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fontFamilyHash();

  @$internal
  @override
  $ProviderElement<FontFamily> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FontFamily create(Ref ref) {
    return fontFamily(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FontFamily value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FontFamily>(value),
    );
  }
}

String _$fontFamilyHash() => r'efa681b58e82b45521e7c410db1569d0d7bc6948';
