import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/repositories/collection_repository.dart';
import '../../data/datasources/supabase_collection_datasource.dart';
import '../../data/repositories/collection_repository_impl.dart';

part 'collection_providers.g.dart';

/// Provider for Supabase collection datasource
@riverpod
SupabaseCollectionDatasource supabaseCollectionDatasource(Ref ref) {
  return SupabaseCollectionDatasource(supabase.Supabase.instance.client);
}

/// Provider for collection repository
@riverpod
CollectionRepository collectionRepository(Ref ref) {
  final datasource = ref.watch(supabaseCollectionDatasourceProvider);
  return CollectionRepositoryImpl(datasource);
}
