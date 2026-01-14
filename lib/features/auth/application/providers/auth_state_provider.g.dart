// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for Supabase datasource

@ProviderFor(supabaseAuthDatasource)
const supabaseAuthDatasourceProvider = SupabaseAuthDatasourceProvider._();

/// Provider for Supabase datasource

final class SupabaseAuthDatasourceProvider
    extends
        $FunctionalProvider<
          SupabaseAuthDatasource,
          SupabaseAuthDatasource,
          SupabaseAuthDatasource
        >
    with $Provider<SupabaseAuthDatasource> {
  /// Provider for Supabase datasource
  const SupabaseAuthDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseAuthDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseAuthDatasourceHash();

  @$internal
  @override
  $ProviderElement<SupabaseAuthDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseAuthDatasource create(Ref ref) {
    return supabaseAuthDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseAuthDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseAuthDatasource>(value),
    );
  }
}

String _$supabaseAuthDatasourceHash() =>
    r'83448ee9b85c749ff035f18224a926b33aa0e90a';

/// Provider for auth repository

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// Provider for auth repository

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Provider for auth repository
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'd6a39e437a767adccdd3d2a23bb604c3734af7c7';

/// Stream provider for auth state changes

@ProviderFor(authStateChanges)
const authStateChangesProvider = AuthStateChangesProvider._();

/// Stream provider for auth state changes

final class AuthStateChangesProvider
    extends $FunctionalProvider<AsyncValue<QvUser?>, QvUser?, Stream<QvUser?>>
    with $FutureModifier<QvUser?>, $StreamProvider<QvUser?> {
  /// Stream provider for auth state changes
  const AuthStateChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateChangesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateChangesHash();

  @$internal
  @override
  $StreamProviderElement<QvUser?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<QvUser?> create(Ref ref) {
    return authStateChanges(ref);
  }
}

String _$authStateChangesHash() => r'a40566118e416b3c2b71ee91dc6b10489475f059';

/// Provider for current user

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

/// Provider for current user

final class CurrentUserProvider
    extends $FunctionalProvider<AsyncValue<QvUser?>, QvUser?, FutureOr<QvUser?>>
    with $FutureModifier<QvUser?>, $FutureProvider<QvUser?> {
  /// Provider for current user
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<QvUser?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<QvUser?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'06bcc26b9e3d94d7b5215b53286f4a75f59be1fd';
