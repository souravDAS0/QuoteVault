// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for Supabase quote datasource

@ProviderFor(supabaseQuoteDatasource)
const supabaseQuoteDatasourceProvider = SupabaseQuoteDatasourceProvider._();

/// Provider for Supabase quote datasource

final class SupabaseQuoteDatasourceProvider
    extends
        $FunctionalProvider<
          SupabaseQuoteDatasource,
          SupabaseQuoteDatasource,
          SupabaseQuoteDatasource
        >
    with $Provider<SupabaseQuoteDatasource> {
  /// Provider for Supabase quote datasource
  const SupabaseQuoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseQuoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseQuoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<SupabaseQuoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupabaseQuoteDatasource create(Ref ref) {
    return supabaseQuoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseQuoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseQuoteDatasource>(value),
    );
  }
}

String _$supabaseQuoteDatasourceHash() =>
    r'f197126d75f5d6bdd5972d13ba8cb9b5b2d03e3f';

/// Provider for quote repository

@ProviderFor(quoteRepository)
const quoteRepositoryProvider = QuoteRepositoryProvider._();

/// Provider for quote repository

final class QuoteRepositoryProvider
    extends
        $FunctionalProvider<QuoteRepository, QuoteRepository, QuoteRepository>
    with $Provider<QuoteRepository> {
  /// Provider for quote repository
  const QuoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuoteRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuoteRepository create(Ref ref) {
    return quoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuoteRepository>(value),
    );
  }
}

String _$quoteRepositoryHash() => r'85b0e15263ed5bb2e6a19e70e6aa166ac3d22498';
