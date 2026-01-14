import '../../domain/entities/quote.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/author.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/supabase_quote_datasource.dart';

/// Concrete implementation of QuoteRepository using Supabase
/// Converts between DTOs and domain entities
class QuoteRepositoryImpl implements QuoteRepository {
  final SupabaseQuoteDatasource _datasource;

  QuoteRepositoryImpl(this._datasource);

  @override
  Future<List<Quote>> getQuotes({
    required int page,
    int pageSize = 10,
    String? categoryId,
    String? authorId,
  }) async {
    final dtos = await _datasource.getQuotes(
      page: page,
      pageSize: pageSize,
      categoryId: categoryId,
      authorId: authorId,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Quote>> searchQuotes({
    required String query,
    required int page,
    int pageSize = 10,
    String? authorId,
    String? categoryId,
    String? sortBy,
  }) async {
    final dtos = await _datasource.searchQuotes(
      query: query,
      page: page,
      pageSize: pageSize,
      authorId: authorId,
      categoryId: categoryId,
      sortBy: sortBy,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<int> getSearchResultsCount({
    required String query,
    String? authorId,
    String? categoryId,
  }) async {
    return _datasource.getSearchResultsCount(
      query: query,
      authorId: authorId,
      categoryId: categoryId,
    );
  }

  @override
  Future<List<Category>> getCategories() async {
    final dtos = await _datasource.getCategories();
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Author>> getAuthors() async {
    final dtos = await _datasource.getAuthors();
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Author>> searchAuthors({required String query}) async {
    final dtos = await _datasource.searchAuthors(query: query);
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<Quote> toggleFavorite({required String quoteId}) async {
    final dto = await _datasource.toggleFavorite(quoteId: quoteId);
    return dto.toDomain();
  }
}
