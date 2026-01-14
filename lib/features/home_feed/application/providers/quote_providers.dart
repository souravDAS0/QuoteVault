import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/repositories/quote_repository.dart';
import '../../data/datasources/supabase_quote_datasource.dart';
import '../../data/repositories/quote_repository_impl.dart';

part 'quote_providers.g.dart';

/// Provider for Supabase quote datasource
@riverpod
SupabaseQuoteDatasource supabaseQuoteDatasource(Ref ref) {
  return SupabaseQuoteDatasource(supabase.Supabase.instance.client);
}

/// Provider for quote repository
@riverpod
QuoteRepository quoteRepository(Ref ref) {
  final datasource = ref.watch(supabaseQuoteDatasourceProvider);
  return QuoteRepositoryImpl(datasource);
}
