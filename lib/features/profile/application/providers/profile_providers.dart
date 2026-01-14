import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../data/datasources/supabase_profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_providers.g.dart';

/// Provider for Supabase profile datasource
@riverpod
SupabaseProfileDatasource supabaseProfileDatasource(Ref ref) {
  return SupabaseProfileDatasource(supabase.Supabase.instance.client);
}

/// Provider for profile repository
@riverpod
ProfileRepository profileRepository(Ref ref) {
  final datasource = ref.watch(supabaseProfileDatasourceProvider);
  return ProfileRepositoryImpl(datasource);
}
