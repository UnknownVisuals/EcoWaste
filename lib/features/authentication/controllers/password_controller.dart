import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  Rx<bool> isLoading = false.obs;
  Rx<bool> obscurePassword = true.obs;
  Rx<bool> obscureConfirmPassword = true.obs;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  /// Send forgot password request
  /// Note: This endpoint is not documented in the API, but commonly exists
  Future<void> forgotPassword({required String email}) async {
    if (!validateEmail(email)) {
      return;
    }

    isLoading.value = true;

    try {
      // This endpoint might need to be confirmed with the backend team
      final response = await httpHelper.postRequest('auth/forgot-password', {
        'email': email,
      });

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ??
                'Password reset instructions sent to your email',
          );

          // Navigate back or to verification screen
          Get.back();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message:
                responseBody['message'] ?? 'Failed to send reset instructions',
          );
        }
      } else if (response.statusCode == 404) {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Email address not found',
        );
      } else {
        final responseBody = response.body;
        REYLoaders.errorSnackBar(
          title: 'Error',
          message:
              responseBody['message'] ?? 'Failed to send reset instructions',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to connect to server: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset password with token
  /// Note: This endpoint is not documented in the API, but commonly exists
  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (!validatePasswordReset(newPassword, confirmPassword)) {
      return;
    }

    isLoading.value = true;

    try {
      // This endpoint might need to be confirmed with the backend team
      final response = await httpHelper.postRequest('auth/reset-password', {
        'token': token,
        'password': newPassword,
        'confirmPassword': confirmPassword,
      });

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Password reset successfully',
          );

          // Navigate to login screen
          Get.offAllNamed('/login');
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to reset password',
          );
        }
      } else if (response.statusCode == 400) {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Invalid or expired reset token',
        );
      } else {
        final responseBody = response.body;
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: responseBody['message'] ?? 'Failed to reset password',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to connect to server: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Change password for authenticated user
  /// Note: This endpoint is not documented in the API, but commonly exists
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (!validatePasswordChange(
      currentPassword,
      newPassword,
      confirmPassword,
    )) {
      return;
    }

    isLoading.value = true;

    try {
      // This endpoint might need to be confirmed with the backend team
      final response = await httpHelper.putRequest('auth/change-password', {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      });

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Password changed successfully',
          );

          // Navigate back to profile or settings
          Get.back();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to change password',
          );
        }
      } else if (response.statusCode == 400) {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Current password is incorrect',
        );
      } else if (response.statusCode == 401) {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Authentication required. Please login again.',
        );
      } else {
        final responseBody = response.body;
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: responseBody['message'] ?? 'Failed to change password',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to connect to server: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate email format
  bool validateEmail(String email) {
    if (email.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Email is required',
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Please enter a valid email address',
      );
      return false;
    }

    return true;
  }

  /// Validate password reset form
  bool validatePasswordReset(String newPassword, String confirmPassword) {
    if (newPassword.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'New password is required',
      );
      return false;
    }

    if (newPassword.length < 8) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Password must be at least 8 characters',
      );
      return false;
    }

    if (confirmPassword.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Confirm password is required',
      );
      return false;
    }

    if (newPassword != confirmPassword) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Passwords do not match',
      );
      return false;
    }

    return true;
  }

  /// Validate password change form
  bool validatePasswordChange(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) {
    if (currentPassword.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Current password is required',
      );
      return false;
    }

    if (newPassword.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'New password is required',
      );
      return false;
    }

    if (newPassword.length < 8) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'New password must be at least 8 characters',
      );
      return false;
    }

    if (confirmPassword.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Confirm password is required',
      );
      return false;
    }

    if (newPassword != confirmPassword) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'New passwords do not match',
      );
      return false;
    }

    if (currentPassword == newPassword) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'New password must be different from current password',
      );
      return false;
    }

    return true;
  }
}
