// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(logService)
const logServiceProvider = LogServiceProvider._();

final class LogServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<LogService>,
          LogService,
          FutureOr<LogService>
        >
    with $FutureModifier<LogService>, $FutureProvider<LogService> {
  const LogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logServiceHash();

  @$internal
  @override
  $FutureProviderElement<LogService> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LogService> create(Ref ref) {
    return logService(ref);
  }
}

String _$logServiceHash() => r'270c5c1aed8b4cade3e7de9997795c4436d0298b';
