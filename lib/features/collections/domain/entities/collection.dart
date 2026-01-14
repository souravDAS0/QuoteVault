import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.freezed.dart';

/// Domain entity representing a user's collection
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class Collection with _$Collection {
  const factory Collection({
    required String id,
    required String userId,
    required String name,
    String? description,
    String? imageUrl,
    @Default(0) int quoteCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Collection;
}
