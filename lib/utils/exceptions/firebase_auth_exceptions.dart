/// Custom exception class to handle various Firebase authentication-related errors.
class REYFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  REYFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API key.';
      case 'auth-domain-config-required':
        return 'The authDomain configuration is required for the action code verification link.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credential.';
      case 'invalid-cordova-configuration':
        return 'The provided Cordova configuration is invalid.';
      case 'invalid-credential':
        return 'The supplied credential is invalid. Please check the credential and try again.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'invalid-login-credentials':
        return 'Invalid login credentials.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing the iframe src attribute.';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'user-not-found':
        return 'No user found for the given email or UID.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}
