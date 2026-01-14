// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_navigation_listener.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that sets up auth state change listener for password recovery navigation

@ProviderFor(authStateNavigationListener)
const authStateNavigationListenerProvider =
    AuthStateNavigationListenerProvider._();

/// Provider that sets up auth state change listener for password recovery navigation

final class AuthStateNavigationListenerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Provider that sets up auth state change listener for password recovery navigation
  const AuthStateNavigationListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateNavigationListenerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateNavigationListenerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return authStateNavigationListener(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authStateNavigationListenerHash() =>
    r'f65bead68cfc917a49aef2c36757336751305286';
