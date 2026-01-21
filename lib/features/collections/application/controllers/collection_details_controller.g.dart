// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectionDetailsController)
const collectionDetailsControllerProvider =
    CollectionDetailsControllerFamily._();

final class CollectionDetailsControllerProvider
    extends
        $NotifierProvider<CollectionDetailsController, CollectionDetailsState> {
  const CollectionDetailsControllerProvider._({
    required CollectionDetailsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'collectionDetailsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collectionDetailsControllerHash();

  @override
  String toString() {
    return r'collectionDetailsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CollectionDetailsController create() => CollectionDetailsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionDetailsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionDetailsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionDetailsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionDetailsControllerHash() =>
    r'dfba293bd94223d53d9ec92163f4ea6534ad8224';

final class CollectionDetailsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CollectionDetailsController,
          CollectionDetailsState,
          CollectionDetailsState,
          CollectionDetailsState,
          String
        > {
  const CollectionDetailsControllerFamily._()
    : super(
        retry: null,
        name: r'collectionDetailsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollectionDetailsControllerProvider call(String collectionId) =>
      CollectionDetailsControllerProvider._(argument: collectionId, from: this);

  @override
  String toString() => r'collectionDetailsControllerProvider';
}

abstract class _$CollectionDetailsController
    extends $Notifier<CollectionDetailsState> {
  late final _$args = ref.$arg as String;
  String get collectionId => _$args;

  CollectionDetailsState build(String collectionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<CollectionDetailsState, CollectionDetailsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CollectionDetailsState, CollectionDetailsState>,
              CollectionDetailsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Controller for Favorites (special collection using user_favorites table)

@ProviderFor(FavoritesController)
const favoritesControllerProvider = FavoritesControllerProvider._();

/// Controller for Favorites (special collection using user_favorites table)
final class FavoritesControllerProvider
    extends $NotifierProvider<FavoritesController, FavoritesState> {
  /// Controller for Favorites (special collection using user_favorites table)
  const FavoritesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesControllerHash();

  @$internal
  @override
  FavoritesController create() => FavoritesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesState>(value),
    );
  }
}

String _$favoritesControllerHash() =>
    r'1b8130b1bdc5865f06ca3d3dc9b38ed0025a3d7f';

/// Controller for Favorites (special collection using user_favorites table)

abstract class _$FavoritesController extends $Notifier<FavoritesState> {
  FavoritesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FavoritesState, FavoritesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FavoritesState, FavoritesState>,
              FavoritesState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
