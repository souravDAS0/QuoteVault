import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Freezed union for different types of failures
@freezed
abstract class Failure with _$Failure {
  const factory Failure.auth({required String message, String? code}) =
      AuthFailure;

  const factory Failure.network({required String message}) = NetworkFailure;

  const factory Failure.server({required String message}) = ServerFailure;

  const factory Failure.unknown({required String message}) = UnknownFailure;
}
