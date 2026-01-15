import '../entities/quote.dart';
import '../entities/category.dart';
import '../entities/author.dart';

/// Abstract repository defining quote data contracts
/// Implementation will be in the data layer
/// NO Supabase imports, NO implementation details
abstract class QuoteRepository {
  /// Get paginated quotes for the feed
  /// [page] starts from 0
  /// [pageSize] number of quotes per page
  /// [categoryId] optional filter by category
  /// [authorId] optional filter by author
  Future<List<Quote>> getQuotes({
    required int page,
    int pageSize = 10,
    String? categoryId,
    String? authorId,
  });

  /// Search quotes by text or author
  /// [query] search term
  /// [page] pagination page starting from 0
  /// [pageSize] number of results per page
  /// [authorId] optional filter by author
  /// [categoryId] optional filter by category
  /// [sortBy] optional sort field (popularity, recent, etc.)
  Future<List<Quote>> searchQuotes({
    required String query,
    required int page,
    int pageSize = 10,
    String? authorId,
    String? categoryId,
    String? sortBy,
  });

  /// Get total count for search results
  Future<int> getSearchResultsCount({
    required String query,
    String? authorId,
    String? categoryId,
  });

  /// Get all available categories
  Future<List<Category>> getCategories();

  /// Get all available authors
  Future<List<Author>> getAuthors();

  /// Get authors matching search query
  Future<List<Author>> searchAuthors({required String query});

  /// Toggle favorite status for a quote
  Future<Quote> toggleFavorite({required String quoteId});

  /// Get today's quote of the day
  /// Returns null if no quote is marked as quote of the day for today
  Future<Quote?> getDailyQuote();
}
