import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/signup_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  Rx<bool> obscurePassword = true.obs;
  Rx<bool> agreeTnC = false.obs;
  Rx<bool> isLoading = false.obs;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Toggle terms and conditions agreement
  void toggleAgreeToC(bool? value) {
    agreeTnC.value = value ?? false;
  }

  /// Register new user using API endpoint POST /users
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String? tps3rId,
  }) async {
    if (!validateSignupForm(name, email, password)) {
      return;
    }

    isLoading.value = true;

    try {
      final signupModel = SignupModel(
        name: name,
        email: email,
        password: password,
        role: 'USER', // Default role from API documentation
        tps3rId: tps3rId,
      );

      final response = await httpHelper.postRequest(
        'users',
        signupModel.toJson(),
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;

        // Check if response format matches API documentation
        if (responseBody['status'] == 'success') {
          final userData = responseBody['data'];

          // Update user model with created user data
          userController.updateUserModel(userData);

          // Show success message
          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Account created successfully',
          );

          // Navigate to login or verification screen
          Get.back(); // Go back to login screen
        } else {
          REYLoaders.errorSnackBar(
            title: 'Registration Failed',
            message: responseBody['message'] ?? 'Registration failed',
          );
        }
      } else if (response.statusCode == 400) {
        final responseBody = response.body;
        String errorMessage = 'Invalid registration data';

        // Handle validation errors
        if (responseBody['errors'] != null &&
            responseBody['errors'].isNotEmpty) {
          final errors = responseBody['errors'] as List;
          errorMessage = errors.map((e) => e['message']).join('\n');
        } else if (responseBody['message'] != null) {
          errorMessage = responseBody['message'];
        }

        REYLoaders.errorSnackBar(
          title: 'Registration Failed',
          message: errorMessage,
        );
      } else {
        final responseBody = response.body;
        REYLoaders.errorSnackBar(
          title: 'Registration Failed',
          message:
              responseBody['message'] ??
              'An error occurred during registration',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Registration Failed',
        message: 'Failed to connect to server: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate signup form
  bool validateSignupForm(String name, String email, String password) {
    if (name.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Name is required',
      );
      return false;
    }

    if (name.length < 2) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Name must be at least 2 characters',
      );
      return false;
    }

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

    if (password.isEmpty) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Password is required',
      );
      return false;
    }

    if (password.length < 8) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Password must be at least 8 characters',
      );
      return false;
    }

    if (!agreeTnC.value) {
      REYLoaders.errorSnackBar(
        title: 'Validation Error',
        message: 'Please agree to Terms and Conditions',
      );
      return false;
    }

    return true;
  }

  /// Check if email is already registered
  Future<bool> checkEmailAvailability(String email) async {
    try {
      // This would need to be implemented if the API provides such endpoint
      // For now, we'll handle it in the signup process
      return true;
    } catch (e) {
      return true; // Assume available if check fails
    }
  }
}
