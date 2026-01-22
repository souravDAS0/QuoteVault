// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectionsController)
const collectionsControllerProvider = CollectionsControllerProvider._();

final class CollectionsControllerProvider
    extends $NotifierProvider<CollectionsController, CollectionsState> {
  const CollectionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionsControllerHash();

  @$internal
  @override
  CollectionsController create() => CollectionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionsState>(value),
    );
  }
}

String _$collectionsControllerHash() =>
    r'779cd46817286df4defa88a38de9bd11b4c17992';

abstract class _$CollectionsController extends $Notifier<CollectionsState> {
  CollectionsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CollectionsState, CollectionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CollectionsState, CollectionsState>,
              CollectionsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
