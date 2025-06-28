/// Exception class for handling various platform-related errors.
class REYPlatformException implements Exception {
  final String code;

  REYPlatformException(this.code);

  String get message {
    switch (code) {
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      // Add more cases as needed...
      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}
