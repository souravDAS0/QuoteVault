import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../data/datasources/local_settings_datasource.dart';
import '../../data/datasources/supabase_settings_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_providers.g.dart';

/// Provider for SharedPreferences instance
@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

/// Provider for local settings datasource
@riverpod
Future<LocalSettingsDatasource> localSettingsDatasource(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return LocalSettingsDatasource(prefs);
}

/// Provider for Supabase settings datasource
@riverpod
SupabaseSettingsDatasource supabaseSettingsDatasource(Ref ref) {
  return SupabaseSettingsDatasource(supabase.Supabase.instance.client);
}

/// Provider for settings repository
@riverpod
Future<SettingsRepository> settingsRepository(Ref ref) async {
  final localDatasource = await ref.watch(localSettingsDatasourceProvider.future);
  final cloudDatasource = ref.watch(supabaseSettingsDatasourceProvider);
  return SettingsRepositoryImpl(localDatasource, cloudDatasource);
}
