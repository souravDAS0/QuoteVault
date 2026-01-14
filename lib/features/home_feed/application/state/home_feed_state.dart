import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/author.dart';

part 'home_feed_state.freezed.dart';

@freezed
abstract class HomeFeedState with _$HomeFeedState {
  const factory HomeFeedState({
    @Default([]) List<Quote> quotes,
    @Default([]) List<Category> categories,
    @Default([]) List<Author> authors,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    @Default(0) int currentPage,
    String? selectedCategoryId,
    String? selectedAuthorId,
    String? errorMessage,
  }) = _HomeFeedState;
}
