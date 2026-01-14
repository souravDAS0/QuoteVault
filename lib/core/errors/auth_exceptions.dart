/// Custom exception for authentication-related errors
class QuoteVaultAuthException implements Exception {
  final String message;
  final String? code;

  QuoteVaultAuthException(this.message, {this.code});

  @override
  String toString() => message;
}
