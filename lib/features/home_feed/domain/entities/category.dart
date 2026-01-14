import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// Domain entity representing a quote category
/// NO framework dependencies, NO Supabase imports
@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    @Default(false) bool isSelected,
  }) = _Category;
}
