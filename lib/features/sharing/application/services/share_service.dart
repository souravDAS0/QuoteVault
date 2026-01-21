import 'package:flutter/material.dart';

import '../../../home_feed/domain/entities/quote.dart';
import '../../domain/entities/share_template.dart';
import '../../domain/entities/share_destination.dart';

/// Abstract interface for sharing service
/// Application layer service - no framework dependencies
abstract class ShareService {
  /// Share quote as plain text
  Future<void> shareAsText(Quote quote);

  /// Share quote as image using the specified template and destination
  Future<void> shareAsImage(
    Quote quote,
    ShareTemplate template,
    ShareDestination destination, {
    required ColorScheme colorScheme,
  });

  /// Save quote image to device storage
  /// Returns the file path if successful, null otherwise
  Future<String?> saveImageToDevice(
    Quote quote,
    ShareTemplate template,
    ShareDestination destination, {
    required ColorScheme colorScheme,
  });
}
