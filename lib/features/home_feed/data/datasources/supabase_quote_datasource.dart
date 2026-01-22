import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../models/quote_dto.dart';
import '../models/category_dto.dart';
import '../models/author_dto.dart';

/// Wrapper around Supabase database methods for quotes
/// Handles all Supabase quote-related operations
class SupabaseQuoteDatasource {
  final supabase.SupabaseClient _client;

  SupabaseQuoteDatasource(this._client);

  String? get _currentUserId => _client.auth.currentUser?.id;

  /// Convert raw quote data with nested relations to flat DTO format
  QuoteDto _mapToQuoteDto(Map<String, dynamic> data) {
    // Handle nested author and category data from Supabase joins
    final author = data['authors'] as Map<String, dynamic>?;
    final category = data['categories'] as Map<String, dynamic>?;

    return QuoteDto(
      id: data['id']?.toString() ?? '',
      text: data['text']?.toString() ?? data['content']?.toString() ?? '',
      authorId:
          data['author_id']?.toString() ?? author?['id']?.toString() ?? '',
      authorName:
          author?['name']?.toString() ??
          data['author']?.toString() ??
          'Unknown',
      authorDescription: author?['description']?.toString(),
      categoryId:
          data['category_id']?.toString() ?? category?['id']?.toString() ?? '',
      categoryName:
          category?['name']?.toString() ??
          data['category']?.toString() ??
          'General',
      likesCount: data['likes_count'] as int? ?? data['likes'] as int? ?? 0,
      isFavorite: data['is_favorite'] as bool? ?? false,
      isBookmarked: data['is_bookmarked'] as bool? ?? false,
      isFeatured:
          data['is_featured'] as bool? ?? data['featured'] as bool? ?? false,
      imageUrl:
          data['image_url']?.toString() ?? data['background_image']?.toString(),
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'].toString())
          : null,
      isQuoteOfTheDay: data['is_quote_of_the_day'] as bool? ?? false,
      quoteOfTheDayDate: data['quote_of_the_day_date'] != null
          ? DateTime.tryParse(data['quote_of_the_day_date'].toString())
          : null,
    );
  }

  /// Get paginated quotes from the feed
  Future<List<QuoteDto>> getQuotes({
    required int page,
    int pageSize = 10,
    String? categoryId,
    String? authorId,
  }) async {
    try {
      final userId = _currentUserId;

      // First try with joins, fallback to simple query if it fails
      try {
        var query = _client
            .from('quotes')
            .select('*, authors(*), categories(*)');

        if (categoryId != null) {
          query = query.eq('category_id', categoryId);
        }

        if (authorId != null) {
          query = query.eq('author_id', authorId);
        }

        final response = await query
            .order('created_at', ascending: false)
            .range(page * pageSize, (page + 1) * pageSize - 1);

        print('Fetched ${(response as List).length} quotes with joins');

        // Get user's favorites if logged in
        Set<String> userFavorites = {};
        if (userId != null) {
          userFavorites = await _getUserFavoriteQuoteIds(userId);
        }

        return response.map((data) {
          final quote = _mapToQuoteDto(data);
          return quote.copyWith(isFavorite: userFavorites.contains(quote.id));
        }).toList();
      } catch (joinError) {
        print('Join query failed, trying simple query: $joinError');
        // Fallback: query without joins
        var query = _client.from('quotes').select();

        if (categoryId != null) {
          query = query.eq('category_id', categoryId);
        }

        if (authorId != null) {
          query = query.eq('author_id', authorId);
        }

        final response = await query
            .order('created_at', ascending: false)
            .range(page * pageSize, (page + 1) * pageSize - 1);

        print('Fetched ${(response as List).length} quotes without joins');

        // Get user's favorites if logged in
        Set<String> userFavorites = {};
        if (userId != null) {
          userFavorites = await _getUserFavoriteQuoteIds(userId);
        }

        return response.map((data) {
          final quote = _mapToQuoteDto(data);
          return quote.copyWith(isFavorite: userFavorites.contains(quote.id));
        }).toList();
      }
    } catch (e) {
      print('Error fetching quotes: $e');
      throw Exception('Failed to fetch quotes: $e');
    }
  }

  /// Get all quote IDs that the user has favorited
  Future<Set<String>> _getUserFavoriteQuoteIds(String userId) async {
    try {
      final response = await _client
          .from('user_favorites')
          .select('quote_id')
          .eq('user_id', userId);

      return (response as List)
          .map((row) => row['quote_id'].toString())
          .toSet();
    } catch (e) {
      print('Error fetching user favorites: $e');
      return {};
    }
  }

  /// Search quotes by text or author
  Future<List<QuoteDto>> searchQuotes({
    required String query,
    required int page,
    int pageSize = 10,
    String? authorId,
    String? categoryId,
    String? sortBy,
  }) async {
    try {
      final userId = _currentUserId;

      final params = {
        'query': query,
        'author_id_filter': authorId,
        'category_id_filter': categoryId,
        'page_size': pageSize,
        'page_number': page,
      };

      final response = await _client.rpc('search_quotes', params: params);

      // Get user's favorites if logged in
      Set<String> userFavorites = {};
      if (userId != null) {
        userFavorites = await _getUserFavoriteQuoteIds(userId);
      }

      return (response as List).map((data) {
        final quote = _mapToQuoteDto(data as Map<String, dynamic>);
        return quote.copyWith(isFavorite: userFavorites.contains(quote.id));
      }).toList();
    } catch (e) {
      print('Error searching quotes: $e');
      throw Exception('Failed to search quotes: $e');
    }
  }

  /// Get total count for search results
  Future<int> getSearchResultsCount({
    required String query,
    String? authorId,
    String? categoryId,
  }) async {
    try {
      final params = {
        'query': query,
        'author_id_filter': authorId,
        'category_id_filter': categoryId,
      };

      final response = await _client.rpc('search_quotes_count', params: params);
      return response as int;
    } catch (e) {
      print('Error getting search count: $e');
      throw Exception('Failed to get search count: $e');
    }
  }

  /// Get all categories
  Future<List<CategoryDto>> getCategories() async {
    try {
      final response = await _client
          .from('categories')
          .select()
          .order('name', ascending: true);

      return (response as List)
          .map((json) => CategoryDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// Get all authors
  Future<List<AuthorDto>> getAuthors() async {
    try {
      final response = await _client
          .from('authors')
          .select()
          .order('name', ascending: true);

      return (response as List)
          .map((json) => AuthorDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching authors: $e');
      throw Exception('Failed to fetch authors: $e');
    }
  }

  /// Search authors by name
  Future<List<AuthorDto>> searchAuthors({required String query}) async {
    try {
      final response = await _client
          .from('authors')
          .select()
          .ilike('name', '%$query%')
          .order('name', ascending: true);

      return (response as List)
          .map((json) => AuthorDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error searching authors: $e');
      throw Exception('Failed to search authors: $e');
    }
  }

  /// Toggle favorite status
  Future<QuoteDto> toggleFavorite({required String quoteId}) async {
    try {
      final userId = _currentUserId;
      if (userId == null) throw Exception('User not authenticated');

      // Check if already favorited
      final existing = await _client
          .from('user_favorites')
          .select()
          .eq('user_id', userId)
          .eq('quote_id', quoteId)
          .maybeSingle();

      if (existing != null) {
        // Remove favorite
        await _client
            .from('user_favorites')
            .delete()
            .eq('user_id', userId)
            .eq('quote_id', quoteId);
      } else {
        // Add favorite - handle potential duplicate key from race condition
        try {
          await _client.from('user_favorites').insert({
            'user_id': userId,
            'quote_id': quoteId,
          });
        } on supabase.PostgrestException catch (e) {
          // If duplicate key error (code 23505), the favorite already exists
          // This can happen due to race conditions - just ignore and continue
          if (e.code != '23505') {
            rethrow;
          }
          print('Favorite already exists, ignoring duplicate insert');
        }
      }

      // Fetch the updated quote with favorite status
      final isFavorited = await _checkIfFavorited(userId, quoteId);

      // Return updated quote
      final response = await _client
          .from('quotes')
          .select('*, authors(*), categories(*)')
          .eq('id', quoteId)
          .single();

      final quote = _mapToQuoteDto(response);
      return QuoteDto(
        id: quote.id,
        text: quote.text,
        authorId: quote.authorId,
        authorName: quote.authorName,
        authorDescription: quote.authorDescription,
        categoryId: quote.categoryId,
        categoryName: quote.categoryName,
        likesCount: quote.likesCount,
        isFavorite: isFavorited,
        isBookmarked: quote.isBookmarked,
        isFeatured: quote.isFeatured,
        imageUrl: quote.imageUrl,
        createdAt: quote.createdAt,
      );
    } catch (e) {
      print('Error toggling favorite: $e');
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  /// Check if a quote is favorited by the user
  Future<bool> _checkIfFavorited(String userId, String quoteId) async {
    final result = await _client
        .from('user_favorites')
        .select()
        .eq('user_id', userId)
        .eq('quote_id', quoteId)
        .maybeSingle();
    return result != null;
  }

  /// Get today's daily quote
  Future<QuoteDto?> getDailyQuote() async {
    try {
      final userId = _currentUserId;

      // Get today's date in IST timezone
      // IST is UTC+5:30
      final now = DateTime.now().toUtc();
      final istNow = now.add(const Duration(hours: 5, minutes: 30));
      final istToday = DateTime(istNow.year, istNow.month, istNow.day);

      // Calculate the range for today in IST
      final istStartOfDay = istToday;
      final istEndOfDay = istStartOfDay.add(const Duration(days: 1));

      // Convert back to UTC for query (subtract IST offset)
      final utcStartOfDay = istStartOfDay.subtract(const Duration(hours: 5, minutes: 30));
      final utcEndOfDay = istEndOfDay.subtract(const Duration(hours: 5, minutes: 30));

      final response = await _client
          .from('quotes')
          .select('*, authors(*), categories(*)')
          .eq('is_quote_of_the_day', true)
          .gte('quote_of_the_day_date', utcStartOfDay.toIso8601String())
          .lt('quote_of_the_day_date', utcEndOfDay.toIso8601String())
          .maybeSingle();

      if (response == null) {
        return null;
      }

      // Get user's favorites if logged in
      Set<String> userFavorites = {};
      if (userId != null) {
        userFavorites = await _getUserFavoriteQuoteIds(userId);
      }

      final quote = _mapToQuoteDto(response);
      return quote.copyWith(isFavorite: userFavorites.contains(quote.id));
    } catch (e) {
      // Don't log network errors - they're expected when offline
      if (!_isNetworkError(e)) {
        print('Error fetching daily quote: $e');
      }
      return null;
    }
  }

  /// Check if an error is a network-related error
  bool _isNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('socketexception') ||
        errorString.contains('clientexception') ||
        errorString.contains('connection') ||
        errorString.contains('network') ||
        errorString.contains('timeout') ||
        errorString.contains('unreachable') ||
        errorString.contains('no address') ||
        errorString.contains('failed host lookup');
  }
}
