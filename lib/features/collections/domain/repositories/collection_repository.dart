import '../entities/collection.dart';
import '../../../home_feed/domain/entities/quote.dart';

/// Abstract repository defining collection data contracts
/// Implementation will be in the data layer
/// NO Supabase imports, NO implementation details
abstract class CollectionRepository {
  /// Get all collections for the current user
  Future<List<Collection>> getCollections({
    String? sortBy,
    bool ascending = false,
  });

  /// Get a single collection by ID
  Future<Collection> getCollectionById(String collectionId);

  /// Create a new collection
  Future<Collection> createCollection({
    required String name,
    String? description,
  });

  /// Update collection name/description
  Future<Collection> updateCollection({
    required String collectionId,
    String? name,
    String? description,
  });

  /// Delete a collection
  Future<void> deleteCollection(String collectionId);

  /// Get paginated quotes in a collection
  Future<List<Quote>> getCollectionQuotes({
    required String collectionId,
    required int page,
    int pageSize = 20,
  });

  /// Add a quote to a collection
  Future<void> addQuoteToCollection({
    required String collectionId,
    required String quoteId,
  });

  /// Remove a quote from a collection
  Future<void> removeQuoteFromCollection({
    required String collectionId,
    required String quoteId,
  });

  /// Check if quote exists in collection
  Future<bool> isQuoteInCollection({
    required String collectionId,
    required String quoteId,
  });

  /// Get count of user's favorites
  Future<int> getFavoritesCount();

  /// Get paginated favorites
  Future<List<Quote>> getFavorites({
    required int page,
    int pageSize = 20,
  });

  /// Get collections that a specific quote belongs to
  Future<List<Collection>> getCollectionsForQuote(String quoteId);
}
