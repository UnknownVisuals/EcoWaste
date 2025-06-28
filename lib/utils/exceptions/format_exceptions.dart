/// Custom exception class to handle various format-related errors.
class REYFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const REYFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory REYFormatException.fromMessage(String message) {
    return REYFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory REYFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-credit-card-format':
        return const REYFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-date-format':
        return const REYFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-email-format':
        return const REYFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-numeric-format':
        return const REYFormatException(
            'The input should be a valid numeric format.');
      case 'invalid-phone-number-format':
        return const REYFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-url-format':
        return const REYFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      // Add more cases as needed...
      default:
        return const REYFormatException();
    }
  }
}
