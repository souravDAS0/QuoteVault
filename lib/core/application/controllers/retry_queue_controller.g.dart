// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retry_queue_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the retry queue of offline operations

@ProviderFor(RetryQueueController)
const retryQueueControllerProvider = RetryQueueControllerProvider._();

/// Controller for managing the retry queue of offline operations
final class RetryQueueControllerProvider
    extends $NotifierProvider<RetryQueueController, RetryQueueState> {
  /// Controller for managing the retry queue of offline operations
  const RetryQueueControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retryQueueControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retryQueueControllerHash();

  @$internal
  @override
  RetryQueueController create() => RetryQueueController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RetryQueueState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RetryQueueState>(value),
    );
  }
}

String _$retryQueueControllerHash() =>
    r'bcb0d7cf50c141d56bb53d6cb4a0831f46174fa5';

/// Controller for managing the retry queue of offline operations

abstract class _$RetryQueueController extends $Notifier<RetryQueueState> {
  RetryQueueState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RetryQueueState, RetryQueueState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RetryQueueState, RetryQueueState>,
              RetryQueueState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
