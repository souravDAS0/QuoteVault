import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/collections_state.dart';
import '../providers/collection_providers.dart';
import '../../domain/entities/collection.dart';

part 'collections_controller.g.dart';

@riverpod
class CollectionsController extends _$CollectionsController {
  @override
  CollectionsState build() {
    _loadInitialData();
    return const CollectionsState(isLoading: true);
  }

  Future<void> _loadInitialData() async {
    try {
      final repository = ref.read(collectionRepositoryProvider);

      // Load collections and favorites count in parallel
      final results = await Future.wait([
        repository.getCollections(sortBy: 'created_at', ascending: false),
        repository.getFavoritesCount(),
      ]);

      final collections = results[0] as List<Collection>;
      final favoritesCount = results[1] as int;

      state = state.copyWith(
        collections: collections,
        favoritesCount: favoritesCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load collections: $e',
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    await _loadInitialData();
  }

  Future<void> createCollection({
    required String name,
    String? description,
  }) async {
    if (name.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Collection name cannot be empty');
      return;
    }

    state = state.copyWith(isCreating: true, errorMessage: null);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      final newCollection = await repository.createCollection(
        name: name.trim(),
        description: description?.trim(),
      );

      state = state.copyWith(
        collections: [newCollection, ...state.collections],
        isCreating: false,
      );
    } catch (e) {
      state = state.copyWith(
        isCreating: false,
        errorMessage: 'Failed to create collection: $e',
      );
    }
  }

  Future<void> deleteCollection(String collectionId) async {
    state = state.copyWith(isDeleting: true, errorMessage: null);

    try {
      final repository = ref.read(collectionRepositoryProvider);
      await repository.deleteCollection(collectionId);

      state = state.copyWith(
        collections:
            state.collections.where((c) => c.id != collectionId).toList(),
        isDeleting: false,
      );
    } catch (e) {
      state = state.copyWith(
        isDeleting: false,
        errorMessage: 'Failed to delete collection: $e',
      );
    }
  }

  void setSortBy(CollectionSortBy sortBy) {
    if (state.sortBy == sortBy) return;

    final sorted = List<Collection>.from(state.collections);
    switch (sortBy) {
      case CollectionSortBy.name:
        sorted.sort((a, b) => a.name.compareTo(b.name));
      case CollectionSortBy.dateCreated:
        sorted.sort((a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
      case CollectionSortBy.quoteCount:
        sorted.sort((a, b) => b.quoteCount.compareTo(a.quoteCount));
    }

    state = state.copyWith(
      collections: sorted,
      sortBy: sortBy,
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
