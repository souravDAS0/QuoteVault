import '../../domain/entities/collection.dart';
import '../../domain/repositories/collection_repository.dart';
import '../datasources/supabase_collection_datasource.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Concrete implementation of CollectionRepository using Supabase
class CollectionRepositoryImpl implements CollectionRepository {
  final SupabaseCollectionDatasource _datasource;

  CollectionRepositoryImpl(this._datasource);

  @override
  Future<List<Collection>> getCollections({
    String? sortBy,
    bool ascending = false,
  }) async {
    final dtos = await _datasource.getCollections(
      sortBy: sortBy,
      ascending: ascending,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<Collection> getCollectionById(String collectionId) async {
    final dto = await _datasource.getCollectionById(collectionId);
    return dto.toDomain();
  }

  @override
  Future<Collection> createCollection({
    required String name,
    String? description,
  }) async {
    final dto = await _datasource.createCollection(
      name: name,
      description: description,
    );
    return dto.toDomain();
  }

  @override
  Future<Collection> updateCollection({
    required String collectionId,
    String? name,
    String? description,
  }) async {
    final dto = await _datasource.updateCollection(
      collectionId: collectionId,
      name: name,
      description: description,
    );
    return dto.toDomain();
  }

  @override
  Future<void> deleteCollection(String collectionId) async {
    await _datasource.deleteCollection(collectionId);
  }

  @override
  Future<List<Quote>> getCollectionQuotes({
    required String collectionId,
    required int page,
    int pageSize = 20,
  }) async {
    final dtos = await _datasource.getCollectionQuotes(
      collectionId: collectionId,
      page: page,
      pageSize: pageSize,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<void> addQuoteToCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    await _datasource.addQuoteToCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  @override
  Future<void> removeQuoteFromCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    await _datasource.removeQuoteFromCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  @override
  Future<bool> isQuoteInCollection({
    required String collectionId,
    required String quoteId,
  }) async {
    return _datasource.isQuoteInCollection(
      collectionId: collectionId,
      quoteId: quoteId,
    );
  }

  @override
  Future<int> getFavoritesCount() async {
    return _datasource.getFavoritesCount();
  }

  @override
  Future<List<Quote>> getFavorites({
    required int page,
    int pageSize = 20,
  }) async {
    final dtos = await _datasource.getFavorites(
      page: page,
      pageSize: pageSize,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Collection>> getCollectionsForQuote(String quoteId) async {
    final dtos = await _datasource.getCollectionsForQuote(quoteId);
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}
