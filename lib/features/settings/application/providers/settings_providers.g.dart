// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SharedPreferences instance

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider for SharedPreferences instance

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// Provider for SharedPreferences instance
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'6c03b929f567eb6f97608f6208b95744ffee3bfd';

/// Provider for local settings datasource

@ProviderFor(localSettingsDatasource)
const localSettingsDatasourceProvider = LocalSettingsDatasourceProvider._();

/// Provider for local settings datasource

final class LocalSettingsDatasourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalSettingsDatasource>,
          LocalSettingsDatasource,
          FutureOr<LocalSettingsDatasource>
        >
    with
        $FutureModifier<LocalSettingsDatasource>,
        $FutureProvider<LocalSettingsDatasource> {
  /// Provider for local settings datasource
  const LocalSettingsDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSettingsDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localSettingsDatasourceHash();

  @$internal
  @override
  $FutureProviderElement<LocalSettingsDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalSettingsDatasource> create(Ref ref) {
    return localSettingsDatasource(ref);
  }
}

String _$localSettingsDatasourceHash() =>
    r'1c2c545a68625716505be7791c5f2f41d7e3029e';

/// Provider for Supabase settings datasource

@ProviderFor(supabaseSettingsDatasource)
const supabaseSettingsDatasourceProvider =
    SupabaseSettingsDatasourceProvider._();

/// Provider for Supabase settings datasource

final class SupabaseSettingsDatasourceProvider
    extends
        $FunctionalProvider<
          SupabaseSettingsDatasource,
          SupabaseSettingsDatasource,
          SupabaseSettingsDatasource
        >
    with $Provider<SupabaseSettingsDatasource> {
  /// Provider for Supabase settings datasource
  const SupabaseSettingsDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseSettingsDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseSettingsDatasourceHash();

  @$internal
  @override
  $ProviderElement<SupabaseSettingsDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseSettingsDatasource create(Ref ref) {
    return supabaseSettingsDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseSettingsDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseSettingsDatasource>(value),
    );
  }
}

String _$supabaseSettingsDatasourceHash() =>
    r'104dd90dffda2a13591b18d6f5d4beeaeb56f99c';

/// Provider for settings repository

@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Provider for settings repository

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SettingsRepository>,
          SettingsRepository,
          FutureOr<SettingsRepository>
        >
    with
        $FutureModifier<SettingsRepository>,
        $FutureProvider<SettingsRepository> {
  /// Provider for settings repository
  const SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SettingsRepository> create(Ref ref) {
    return settingsRepository(ref);
  }
}

String _$settingsRepositoryHash() =>
    r'966fafdba916a439cb3743c5b04bb6e7b12daeaa';
