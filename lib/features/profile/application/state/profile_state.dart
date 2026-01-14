import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_statistics.dart';

part 'profile_state.freezed.dart';

/// State for the profile screen
@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(null) ProfileStatistics? statistics,
    @Default(true) bool isLoading,
    @Default(null) String? errorMessage,
    @Default(false) bool isUpdating,
    @Default(null) String? updateError,
  }) = _ProfileState;
}
