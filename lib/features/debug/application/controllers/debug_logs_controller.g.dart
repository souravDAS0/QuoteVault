// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_logs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebugLogsController)
const debugLogsControllerProvider = DebugLogsControllerProvider._();

final class DebugLogsControllerProvider
    extends $AsyncNotifierProvider<DebugLogsController, DebugLogsState> {
  const DebugLogsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugLogsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugLogsControllerHash();

  @$internal
  @override
  DebugLogsController create() => DebugLogsController();
}

String _$debugLogsControllerHash() =>
    r'ff3867e2a8a32187b4b9b24ec78ee780d7f47b61';

abstract class _$DebugLogsController extends $AsyncNotifier<DebugLogsState> {
  FutureOr<DebugLogsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<DebugLogsState>, DebugLogsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DebugLogsState>, DebugLogsState>,
              AsyncValue<DebugLogsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
