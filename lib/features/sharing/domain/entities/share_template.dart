import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_template.freezed.dart';

/// Domain entity representing a share template type
/// NO framework dependencies
@freezed
abstract class ShareTemplate with _$ShareTemplate {
  const factory ShareTemplate.classic() = ClassicTemplate;
  const factory ShareTemplate.minimal() = MinimalTemplate;
  const factory ShareTemplate.gradient() = GradientTemplate;
}
