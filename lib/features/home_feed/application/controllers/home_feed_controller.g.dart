// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_feed_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeFeedController)
const homeFeedControllerProvider = HomeFeedControllerProvider._();

final class HomeFeedControllerProvider
    extends $NotifierProvider<HomeFeedController, HomeFeedState> {
  const HomeFeedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeFeedControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeFeedControllerHash();

  @$internal
  @override
  HomeFeedController create() => HomeFeedController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeFeedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeFeedState>(value),
    );
  }
}

String _$homeFeedControllerHash() =>
    r'fbdf1d222496294097b9afdbb6bf97c237e7c267';

abstract class _$HomeFeedController extends $Notifier<HomeFeedState> {
  HomeFeedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HomeFeedState, HomeFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeFeedState, HomeFeedState>,
              HomeFeedState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
