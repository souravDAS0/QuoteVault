import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';

/// Domain entity representing a quote author
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class Author with _$Author {
  const factory Author({
    required String id,
    required String name,
    String? description,
    String? avatarUrl,
  }) = _Author;
}
