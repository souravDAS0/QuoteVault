import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_config.g.dart';

/// Provider that reads DEBUG flag from .env file
@riverpod
bool isDebugMode(Ref ref) {
  final debugValue = dotenv.env['DEBUG']?.toLowerCase();
  return debugValue == 'true';
}
