/// Exception class for handling various errors.
class REYExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const REYExceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);

  /// Create an authentication exception from a Firebase authentication exception code.
  factory REYExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const REYExceptions(
            'The email address is already registered. Please use a different email.');
      case 'internal-error':
        return const REYExceptions('Internal error. Please try again later.');
      case 'invalid-argument':
        return const REYExceptions(
            'Invalid argument provided to the authentication method.');
      case 'invalid-email':
        return const REYExceptions(
            'The email address provided is invalid. Please enter a valid email.');
      case 'invalid-login-credentials':
        return const REYExceptions(
            'Invalid login credentials. Please double-check your information.');
      case 'invalid-password':
        return const REYExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const REYExceptions('The provided phone number is invalid.');
      case 'invalid-verification-code':
        return const REYExceptions(
            'Invalid verification code. Please enter a valid code.');
      case 'invalid-verification-id':
        return const REYExceptions(
            'Invalid verification ID. Please request a new verification code.');
      case 'network-request-failed':
        return const REYExceptions(
            'Network request failed. Please check your internet connection.');
      case 'operation-not-allowed':
        return const REYExceptions(
            'The sign-in provider is disabled for your Firebase project.');
      case 'quota-exceeded':
        return const REYExceptions('Quota exceeded. Please try again later.');
      case 'session-cookie-expired':
        return const REYExceptions(
            'The Firebase session cookie has expired. Please sign in again.');
      case 'sign-in-failed':
        return const REYExceptions('Sign-in failed. Please try again.');
      case 'too-many-requests':
        return const REYExceptions(
            'Too many requests. Please try again later.');
      case 'uid-already-exists':
        return const REYExceptions(
            'The provided user ID is already in use by another user.');
      case 'user-disabled':
        return const REYExceptions(
            'This user account has been disabled. Please contact support for assistance.');
      case 'user-not-found':
        return const REYExceptions('Invalid login details. User not found.');
      case 'weak-password':
        return const REYExceptions(
            'The password is too weak. Please choose a stronger password.');
      case 'wrong-password':
        return const REYExceptions(
            'Incorrect password. Please check your password and try again.');
      default:
        return const REYExceptions();
    }
  }
}
