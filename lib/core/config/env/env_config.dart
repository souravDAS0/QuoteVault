import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration loader
/// Loads and provides access to environment variables from .env file
class EnvConfig {
  /// Supabase project URL
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  /// Supabase anonymous key
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
