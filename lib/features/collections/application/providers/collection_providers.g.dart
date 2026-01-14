// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for Supabase collection datasource

@ProviderFor(supabaseCollectionDatasource)
const supabaseCollectionDatasourceProvider =
    SupabaseCollectionDatasourceProvider._();

/// Provider for Supabase collection datasource

final class SupabaseCollectionDatasourceProvider
    extends
        $FunctionalProvider<
          SupabaseCollectionDatasource,
          SupabaseCollectionDatasource,
          SupabaseCollectionDatasource
        >
    with $Provider<SupabaseCollectionDatasource> {
  /// Provider for Supabase collection datasource
  const SupabaseCollectionDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseCollectionDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseCollectionDatasourceHash();

  @$internal
  @override
  $ProviderElement<SupabaseCollectionDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseCollectionDatasource create(Ref ref) {
    return supabaseCollectionDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseCollectionDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseCollectionDatasource>(value),
    );
  }
}

String _$supabaseCollectionDatasourceHash() =>
    r'0bbfbd819f62acc607a07011717999f6c79a3af1';

/// Provider for collection repository

@ProviderFor(collectionRepository)
const collectionRepositoryProvider = CollectionRepositoryProvider._();

/// Provider for collection repository

final class CollectionRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionRepository,
          CollectionRepository,
          CollectionRepository
        >
    with $Provider<CollectionRepository> {
  /// Provider for collection repository
  const CollectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRepository create(Ref ref) {
    return collectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRepository>(value),
    );
  }
}

String _$collectionRepositoryHash() =>
    r'171f7d4093e29dcdea3703131e148da2fcd3eff0';
