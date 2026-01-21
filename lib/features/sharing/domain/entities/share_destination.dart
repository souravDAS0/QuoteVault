import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_destination.freezed.dart';

/// Represents a share destination with specific aspect ratio and dimensions
/// for social media platforms.
@freezed
class ShareDestination with _$ShareDestination {
  const ShareDestination._();

  /// Default size with 4:5 aspect ratio (400x500px)
  const factory ShareDestination.whatsappStatus() = _WhatsappStatus;

  /// Instagram Story with 9:16 aspect ratio (1080x1920px)
  const factory ShareDestination.instagramStory() = _InstagramStory;

  /// Instagram Post with 1:1 aspect ratio (1080x1080px)
  const factory ShareDestination.instagramPost() = _InstagramPost;

  /// Twitter/X Post with 16:9 aspect ratio (1200x675px)
  // const factory ShareDestination.twitterPost() = _TwitterPost;

  /// Get the width in pixels for this destination
  double get width => when(
    whatsappStatus: () => 1080.0,
    instagramStory: () => 1080.0,
    instagramPost: () => 1080.0,
    // twitterPost: () => 1200.0,
  );

  /// Get the height in pixels for this destination
  double get height => when(
    whatsappStatus: () => 1350.0,
    instagramStory: () => 1920.0,
    instagramPost: () => 1080.0,
    // twitterPost: () => 675.0,
  );

  /// Get the aspect ratio for this destination
  double get aspectRatio => width / height;

  /// Get the pixel ratio for rendering.
  ///
  /// This determines how much to scale down logical dimensions:
  /// - WhatsApp: 1.0 (no scaling, already small)
  /// - Instagram: 3.0 (scale down 3×, then render at 3× for 1080px output)
  double get pixelRatio => when(
    whatsappStatus: () => 3.0,
    instagramStory: () => 3.0,
    instagramPost: () => 3.0,
  );

  /// Get the logical width for widget rendering.
  ///
  /// Logical dimensions are what the widget tree uses during layout.
  /// Physical dimensions = logical dimensions × pixelRatio
  ///
  /// Examples:
  /// - WhatsApp: 400 physical ÷ 1.0 = 400 logical
  /// - Instagram Story: 1080 physical ÷ 3.0 = 360 logical
  /// - Instagram Post: 1080 physical ÷ 3.0 = 360 logical
  double get logicalWidth => width / pixelRatio;

  /// Get the logical height for widget rendering.
  ///
  /// See [logicalWidth] for explanation of logical vs physical pixels.
  double get logicalHeight => height / pixelRatio;
}
