/// Constants for the Collections feature
abstract class CollectionsConstants {
  // Routes
  static const String collectionsRoute = '/collections';
  static const String collectionDetailsRoute = '/collections/:id';
  static const String favoritesRoute = '/favorites';

  // Screen titles
  static const String myCollections = 'My Collections';
  static const String favorites = 'Favorites';
  static const String customCollections = 'Custom Collections';
  static const String newCollection = 'New Collection';
  static const String createNow = 'Create now';

  // Favorites card
  static const String featured = 'FEATURED';
  static const String savedQuotes = 'saved quotes';

  // Collection details
  static const String quotes = 'Quotes';
  static const String quote = 'Quote';
  static const String createdOn = 'Created';
  static const String addQuote = 'Add Quote';

  // Actions
  static const String sortBy = 'Sort by';
  static const String sortByName = 'Name';
  static const String sortByDate = 'Date Created';
  static const String sortByCount = 'Quote Count';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String rename = 'Rename';
  static const String cancel = 'Cancel';
  static const String create = 'Create';
  static const String save = 'Save';
  static const String copy = 'Copy';
  static const String share = 'Share';

  // Create dialog
  static const String createCollection = 'Create Collection';
  static const String collectionName = 'Collection Name';
  static const String collectionNameHint = 'Enter collection name';
  static const String descriptionOptional = 'Description (optional)';
  static const String descriptionHint = 'Add a description...';

  // Edit dialog
  static const String editCollection = 'Edit Collection';
  static const String renameCollection = 'Rename Collection';

  // Empty states
  static const String noCollections = 'No collections yet';
  static const String createFirstCollection =
      'Create your first collection to organize quotes';
  static const String noQuotesInCollection = 'No quotes in this collection';
  static const String addQuotesToCollection = 'Add quotes to get started';
  static const String noFavorites = 'No favorites yet';
  static const String startFavoriting = 'Heart quotes to save them here';

  // Error messages
  static const String errorLoadingCollections = 'Failed to load collections';
  static const String errorCreatingCollection = 'Failed to create collection';
  static const String errorDeletingCollection = 'Failed to delete collection';
  static const String errorLoadingQuotes = 'Failed to load quotes';
  static const String collectionNameRequired = 'Collection name is required';
  static const String quoteAlreadyInCollection =
      'Quote already in this collection';

  // Success messages
  static const String collectionCreated = 'Collection created';
  static const String collectionDeleted = 'Collection deleted';
  static const String quoteAdded = 'Quote added to collection';
  static const String quoteRemoved = 'Quote removed from collection';
  static const String quoteCopied = 'Quote copied to clipboard';

  // Confirmation dialogs
  static const String deleteCollectionTitle = 'Delete Collection?';
  static const String deleteCollectionMessage =
      'This will permanently delete this collection and remove all quotes from it. This action cannot be undone.';
  static const String removeQuoteTitle = 'Remove Quote?';
  static const String removeQuoteMessage =
      'This quote will be removed from this collection.';
}
