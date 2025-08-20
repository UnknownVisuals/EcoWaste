import 'package:get/get.dart';
import 'package:eco_waste/features/authentication/utils/auth_constants.dart';

/// Utility class for authentication-related validations
class AuthValidators {
  /// Validate email address
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AuthConstants.emailRequiredMessage;
    }

    if (!GetUtils.isEmail(email)) {
      return AuthConstants.emailInvalidMessage;
    }

    return null;
  }

  /// Validate password
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AuthConstants.passwordRequiredMessage;
    }

    if (password.length < AuthConstants.minPasswordLength) {
      return AuthConstants.passwordMinLengthMessage;
    }

    return null;
  }

  /// Validate name
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return AuthConstants.nameRequiredMessage;
    }

    if (name.length < AuthConstants.minNameLength) {
      return AuthConstants.nameMinLengthMessage;
    }

    if (name.length > AuthConstants.maxNameLength) {
      return 'Name must be less than ${AuthConstants.maxNameLength} characters';
    }

    return null;
  }

  /// Validate confirm password
  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return AuthConstants.passwordMismatchMessage;
    }

    return null;
  }

  /// Validate current password (for password change)
  static String? validateCurrentPassword(String? currentPassword) {
    if (currentPassword == null || currentPassword.isEmpty) {
      return 'Current password is required';
    }

    return null;
  }

  /// Validate new password (for password change)
  static String? validateNewPassword(
    String? newPassword,
    String? currentPassword,
  ) {
    final passwordValidation = validatePassword(newPassword);
    if (passwordValidation != null) {
      return passwordValidation;
    }

    if (newPassword == currentPassword) {
      return 'New password must be different from current password';
    }

    return null;
  }

  /// Validate terms and conditions agreement
  static String? validateTermsAndConditions(bool? agreed) {
    if (agreed != true) {
      return AuthConstants.termsRequiredMessage;
    }

    return null;
  }

  /// Comprehensive login form validation
  static Map<String, String?> validateLoginForm({
    required String email,
    required String password,
  }) {
    return {
      'email': validateEmail(email),
      'password': validatePassword(password),
    };
  }

  /// Comprehensive registration form validation
  static Map<String, String?> validateRegistrationForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool agreedToTerms,
  }) {
    return {
      'name': validateName(name),
      'email': validateEmail(email),
      'password': validatePassword(password),
      'confirmPassword': validateConfirmPassword(password, confirmPassword),
      'terms': validateTermsAndConditions(agreedToTerms),
    };
  }

  /// Comprehensive password change form validation
  static Map<String, String?> validatePasswordChangeForm({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return {
      'currentPassword': validateCurrentPassword(currentPassword),
      'newPassword': validateNewPassword(newPassword, currentPassword),
      'confirmPassword': validateConfirmPassword(newPassword, confirmPassword),
    };
  }

  /// Check if validation results have errors
  static bool hasValidationErrors(Map<String, String?> validationResults) {
    return validationResults.values.any((error) => error != null);
  }

  /// Get first validation error message
  static String? getFirstValidationError(
    Map<String, String?> validationResults,
  ) {
    for (String? error in validationResults.values) {
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
