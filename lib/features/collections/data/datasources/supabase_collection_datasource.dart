import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../models/collection_dto.dart';
import '../../../home_feed/data/models/quote_dto.dart';

/// Wrapper around Supabase database methods for collections
/// Handles all Supabase collection-related operations
class SupabaseCollectionDatasource {
  final supabase.SupabaseClient _client;

  SupabaseCollectionDatasource(this._client);

  String? get _currentUserId => _client.auth.currentUser?.id;

  /// Convert raw quote data with nested relations to flat DTO format
  QuoteDto _mapToQuoteDto(Map<String, dynamic> data, Set<String> favorites) {
    final author = data['authors'] as Map<String, dynamic>?;
    final category = data['categories'] as Map<String, dynamic>?;
    final quoteId = data['id']?.toString() ?? '';

    return QuoteDto(
      id: quoteId,
      text: data['text']?.toString() ?? '',
      authorId: data['author_id']?.toString() ?? author?['id']?.toString() ?? '',
      authorName: author?['name']?.toString() ?? 'Unknown',
      authorDescription: author?['bio']?.toString(),
      categoryId:
          data['category_id']?.toString() ?? category?['id']?.toString() ?? '',
      categoryName:
          category?['display_name']?.toString() ??
          category?['name']?.toString() ??
          'General',
      isFavorite: favorites.contains(quoteId),
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'].toString())
          : null,
    );
  }

  /// Get all collections for current user with quote counts
  Future<List<CollectionDto>> getCollections({
    String? sortBy,
    bool ascending = false,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final sortColumn = sortBy ?? 'created_at';

    final response = await _client
        .from('collections')
        .select()
        .eq('user_id', userId)
        .order(sortColumn, ascending: ascending);

    final collections = <CollectionDto>[];
    for (final row in response as List) {
      final collectionId = row['id'].toString();

      // Get quote count for this collection
      final countResponse = await _client
          .from('collection_quotes')
          .select()
          .eq('collection_id', collectionId)
          .count(supabase.CountOption.exact);

      // Get first quote's image as collection preview
      String? imageUrl;
      final firstQuoteResult = await _client
          .from('collection_quotes')
          .select('quote_id, quotes(id)')
          .eq('collection_id', collectionId)
          .order('added_at', ascending: true)
          .limit(1);

      if ((firstQuoteResult as List).isNotEmpty) {
        // For now, we don't have image_url on quotes, leave it null
        imageUrl = null;
      }

      collections.add(CollectionDto(
        id: collectionId,
        userId: row['user_id'].toString(),
        name: row['name'].toString(),
        description: row['description']?.toString(),
        imageUrl: imageUrl,
        quoteCount: countResponse.count,
        createdAt: row['created_at'] != null
            ? DateTime.parse(row['created_at'].toString())
            : null,
        updatedAt: row['updated_at'] != null
            ? DateTime.parse(row['updated_at'].toString())
            : null,
      ));
    }

    return collections;
  }

  /// Get single collection by ID
  Future<CollectionDto> getCollectionById(String collectionId) async {
    final response = await _client
        .from('collections')
        .select()
        .eq('id', collectionId)
        .single();

    // Get quote count
    final countResponse = await _client
        .from('collection_quotes')
        .select()
        .eq('collection_id', collectionId)
        .count(supabase.CountOption.exact);

    return CollectionDto(
      id: response['id'].toString(),
      userId: response['user_id'].toString(),
      name: response['name'].toString(),
      description: response['description']?.toString(),
      quoteCount: countResponse.count,
      createdAt: response['created_at'] != null
          ? DateTime.parse(response['created_at'].toString())
          : null,
      updatedAt: response['updated_at'] != null
          ? DateTime.parse(response['updated_at'].toString())
          : null,
    );
  }

  /// Create new collection
  Future<CollectionDto> createCollection({
    required String name,
    String? description,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client.from('collections').insert({
      'user_id': userId,
      'name': name,
      'description': description,
    }).select().single();

    return CollectionDto(
      id: response['id'].toString(),
      userId: response['user_id'].toString(),
      name: response['name'].toString(),
      description: response['description']?.toString(),
      quoteCount: 0,
      createdAt: response['created_at'] != null
          ? DateTime.parse(response['created_at'].toString())
          : null,
      updatedAt: response['updated_at'] != null
          ? DateTime.parse(response['updated_at'].toString())
          : null,
    );
  }

  /// Update collection
  Future<CollectionDto> updateCollection({
    required String collectionId,
    String? name,
    String? description,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;

    final response = await _client
        .from('collections')
        .update(updates)
        .eq('id', collectionId)
        .select()
        .single();

    // Get quote count
    final countResponse = await _client
        .from('collection_quotes')
        .select()
        .eq('collection_id', collectionId)
        .count(supabase.CountOption.exact);

    return CollectionDto(
      id: response['id'].toString(),
      userId: response['user_id'].toString(),
      name: response['name'].toString(),
      description: response['description']?.toString(),
      quoteCount: countResponse.count,
      createdAt: response['created_at'] != null
          ? DateTime.parse(response['created_at'].toString())
          : null,
      updatedAt: response['updated_at'] != null
          ? DateTime.parse(response['updated_at'].toString())
          : null,
    );
  }

  /// Delete collection
  Future<void> deleteCollection(String collectionId) async {
    // First delete all collection_quotes entries
    await _client
        .from('collection_quotes')
        .delete()
        .eq('collection_id', collectionId);

    // Then delete the collection
    await _client.from('collections').delete().eq('id', collectionId);
  }

  /// Get paginated quotes in a collection
  Future<List<QuoteDto>> getCollectionQuotes({
    required String collectionId,
    required int page,
    int pageSize = 20,
  }) async {
    final userId = _currentUserId;

    // Query through junction table with nested select
    final response = await _client
        .from('collection_quotes')
        .select('quote_id, added_at, quotes(*, authors(*), categories(*))')
        .eq('collection_id', collectionId)
        .order('added_at', ascending: false)
        .range(page * pageSize, (page + 1) * pageSize - 1);

    // Get user's favorites
    Set<String> userFavorites = {};
    if (userId != null) {
      userFavorites = await _getUserFavoriteQuoteIds(userId);
    }

    return (response as List).map((row) {
      final quoteData = row['quotes'] as Map<String, dynamic>;
      return _mapToQuoteDto(quoteData, userFavorites);
    }).toList();
  }

  /// Add quote to collection
  Future<void> addQuoteToCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    try {
      await _client.from('collection_quotes').insert({
        'collection_id': collectionId,
        'quote_id': quoteId,
      });
    } on supabase.PostgrestException catch (e) {
      if (e.code == '23505') {
        throw Exception('Quote already in collection');
      }
      rethrow;
    }
  }

  /// Remove quote from collection
  Future<void> removeQuoteFromCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    await _client
        .from('collection_quotes')
        .delete()
        .eq('collection_id', collectionId)
        .eq('quote_id', quoteId);
  }

  /// Check if quote exists in collection
  Future<bool> isQuoteInCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    final response = await _client
        .from('collection_quotes')
        .select()
        .eq('collection_id', collectionId)
        .eq('quote_id', quoteId)
        .maybeSingle();
    return response != null;
  }

  /// Get favorites count
  Future<int> getFavoritesCount() async {
    final userId = _currentUserId;
    if (userId == null) return 0;

    final response = await _client
        .from('user_favorites')
        .select()
        .eq('user_id', userId)
        .count(supabase.CountOption.exact);
    return response.count;
  }

  /// Get paginated favorites
  Future<List<QuoteDto>> getFavorites({
    required int page,
    int pageSize = 20,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client
        .from('user_favorites')
        .select('quote_id, created_at, quotes(*, authors(*), categories(*))')
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .range(page * pageSize, (page + 1) * pageSize - 1);

    // All quotes in favorites are favorited
    return (response as List).map((row) {
      final quoteData = row['quotes'] as Map<String, dynamic>;
      final quoteId = quoteData['id']?.toString() ?? '';
      return _mapToQuoteDto(quoteData, {quoteId});
    }).toList();
  }

  /// Get collections containing a specific quote
  Future<List<CollectionDto>> getCollectionsForQuote(String quoteId) async {
    final userId = _currentUserId;
    if (userId == null) return [];

    final response = await _client
        .from('collection_quotes')
        .select('collection_id, collections(*)')
        .eq('quote_id', quoteId);

    return (response as List)
        .where((row) => row['collections'] != null)
        .map((row) {
          final col = row['collections'] as Map<String, dynamic>;
          return CollectionDto(
            id: col['id'].toString(),
            userId: col['user_id'].toString(),
            name: col['name'].toString(),
            description: col['description']?.toString(),
            quoteCount: 0,
            createdAt: col['created_at'] != null
                ? DateTime.parse(col['created_at'].toString())
                : null,
            updatedAt: col['updated_at'] != null
                ? DateTime.parse(col['updated_at'].toString())
                : null,
          );
        })
        .toList();
  }

  /// Get all quote IDs that the user has favorited
  Future<Set<String>> _getUserFavoriteQuoteIds(String userId) async {
    try {
      final response = await _client
          .from('user_favorites')
          .select('quote_id')
          .eq('user_id', userId);

      return (response as List).map((row) => row['quote_id'].toString()).toSet();
    } catch (e) {
      return {};
    }
  }
}
