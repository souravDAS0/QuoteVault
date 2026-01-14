// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for Supabase profile datasource

@ProviderFor(supabaseProfileDatasource)
const supabaseProfileDatasourceProvider = SupabaseProfileDatasourceProvider._();

/// Provider for Supabase profile datasource

final class SupabaseProfileDatasourceProvider
    extends
        $FunctionalProvider<
          SupabaseProfileDatasource,
          SupabaseProfileDatasource,
          SupabaseProfileDatasource
        >
    with $Provider<SupabaseProfileDatasource> {
  /// Provider for Supabase profile datasource
  const SupabaseProfileDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseProfileDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseProfileDatasourceHash();

  @$internal
  @override
  $ProviderElement<SupabaseProfileDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseProfileDatasource create(Ref ref) {
    return supabaseProfileDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseProfileDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseProfileDatasource>(value),
    );
  }
}

String _$supabaseProfileDatasourceHash() =>
    r'8c23417cd185325fbde7f97223153fb0dddb5b58';

/// Provider for profile repository

@ProviderFor(profileRepository)
const profileRepositoryProvider = ProfileRepositoryProvider._();

/// Provider for profile repository

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  /// Provider for profile repository
  const ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'3ad6b8483db2f476cd5a0130e89b62e1a819f18e';
