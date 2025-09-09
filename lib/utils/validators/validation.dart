import 'package:get/get.dart';

class REYValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'emailRequired'.tr;
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'invalidEmailAddress'.tr;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'passwordRequired'.tr;
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'passwordMinLength'.tr;
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'passwordUppercase'.tr;
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'passwordNumber'.tr;
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'passwordSpecialChar'.tr;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'phoneRequired'.tr;
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'invalidPhoneNumber'.tr;
    }

    return null;
  }

  // Add more custom validators as needed for your specific requirements.
}
