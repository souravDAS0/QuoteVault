// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that reads DEBUG flag from .env file

@ProviderFor(isDebugMode)
const isDebugModeProvider = IsDebugModeProvider._();

/// Provider that reads DEBUG flag from .env file

final class IsDebugModeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider that reads DEBUG flag from .env file
  const IsDebugModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isDebugModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isDebugModeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDebugMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDebugModeHash() => r'3e1f6b604f48b57d2b7b39fc2bcf7983db589746';
