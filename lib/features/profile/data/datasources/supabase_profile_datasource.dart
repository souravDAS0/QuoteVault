import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Datasource for profile-related Supabase queries
class SupabaseProfileDatasource {
  final supabase.SupabaseClient _client;

  SupabaseProfileDatasource(this._client);

  /// Get the count of favorites for the current user
  Future<int> getFavoritesCount() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await _client
        .from('user_favorites')
        .select()
        .eq('user_id', userId)
        .count(supabase.CountOption.exact);

    return response.count;
  }

  /// Get the count of collections for the current user
  Future<int> getCollectionsCount() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await _client
        .from('collections')
        .select()
        .eq('user_id', userId)
        .count(supabase.CountOption.exact);

    return response.count;
  }
}
