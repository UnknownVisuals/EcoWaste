import 'package:eco_waste/features/admin/navigation_menu.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/login_model.dart';
import 'package:eco_waste/features/authentication/models/signup_model.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/features/user/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());
  final GetStorage storage = GetStorage();

  // Observable variables
  Rx<bool> isAuthenticated = false.obs;
  Rx<bool> isLoading = false.obs;

  // Login specific variables
  Rx<bool> isObscurePassword = true.obs;
  Rx<bool> isRememberMe = false.obs;

  // Signup specific variables
  Rx<bool> obscurePassword = true.obs;
  Rx<bool> agreeTnC = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthenticationStatus();
  }

  /// Check authentication status on app start
  Future<void> checkAuthenticationStatus() async {
    try {
      final userData = storage.read('user');
      final rememberMe = storage.read('rememberMe') ?? false;

      if (userData != null && rememberMe) {
        try {
          // Verify session with server by calling /auth/me
          final response = await httpHelper.getRequest('auth/me');

          if (response.statusCode == 200) {
            final responseBody = response.body;
            if (responseBody != null &&
                responseBody is Map<String, dynamic> &&
                responseBody['status'] == 'success' &&
                responseBody['data'] != null) {
              userController.updateUserModel(responseBody['data']);
              isAuthenticated.value = true;
              return;
            }
          }
        } catch (e) {
          // Network error or server error, clear session
          print('Auth check failed: $e');
        }

        // If server validation fails, clear local data
        userController.removeUserFromStorage();
        httpHelper.clearSession();
      }

      isAuthenticated.value = false;
    } catch (e) {
      // Error checking authentication status, set to unauthenticated
      print('Auth status check error: $e');
      isAuthenticated.value = false;
      userController.removeUserFromStorage();
      httpHelper.clearSession();
    }
  }

  /// Login user with email and password
  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;

    try {
      final loginModel = LoginModel(email: email, password: password);

      final loginResponse = await httpHelper.postRequest(
        'auth/login',
        loginModel.toJson(),
        saveSession: true, // Enable session saving
      );

      if (loginResponse.statusCode == 200) {
        final responseBody = loginResponse.body;

        if (responseBody != null &&
            responseBody is Map<String, dynamic> &&
            responseBody['status'] == 'success' &&
            responseBody['data'] != null) {
          final userData = responseBody['data'];

          userController.updateUserModel(userData);
          userController.saveUserToStorage(userData);
          isAuthenticated.value = true;

          _navigateBasedOnRole();

          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Login successful',
          );
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message:
                responseBody?['message'] ??
                'Login failed - Invalid response format',
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to login, please try again',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to login: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
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

  /// Logout current user
  Future<void> logout() async {
    isLoading.value = true;

    try {
      // Call API logout endpoint
      await httpHelper.postRequest('auth/logout', {});

      // Clear local storage
      userController.removeUserFromStorage();

      // Clear session cookie
      httpHelper.clearSession();

      isAuthenticated.value = false;

      // Reset UI states
      isRememberMe.value = false;
      isObscurePassword.value = true;
      obscurePassword.value = true;
      agreeTnC.value = false;

      // Navigate to login screen
      Get.offAll(() => const LoginScreen());

      REYLoaders.successSnackBar(
        title: 'Success',
        message: 'Logged out successfully',
      );
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to logout: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh user data from server
  Future<void> refreshUserData() async {
    try {
      // Call the /auth/me endpoint to get fresh user data
      final response = await httpHelper.getRequest('auth/me');

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          userController.updateUserModel(responseBody['data']);
          userController.saveUserToStorage(responseBody['data']);
        }
      } else if (response.statusCode == 401) {
        // Unauthorized, clear session
        isAuthenticated.value = false;
        userController.removeUserFromStorage();
        httpHelper.clearSession();
      }
    } catch (e) {
      // Error refreshing user data, continue with cached data
    }
  }

  /// Navigate to the appropriate screen based on user role
  void _navigateBasedOnRole() {
    try {
      final currentUser = userController.userModel.value;
      if (currentUser.role == 'ADMIN') {
        Get.off(AdminNavigationMenu(userModel: currentUser));
      } else {
        Get.off(UserNavigationMenu(userModel: currentUser));
      }
    } catch (e) {
      print('Navigation error: $e');
      // Fallback to user navigation if there's an error
      Get.off(UserNavigationMenu(userModel: userController.userModel.value));
    }
  }

  // Login UI Methods
  void toggleObscuredPassword() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }

  // Signup UI Methods
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleAgreeToC(bool? value) {
    agreeTnC.value = value ?? false;
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

  // Role checking methods
  bool hasRole(String role) {
    try {
      return userController.userModel.value.role == role;
    } catch (e) {
      return false;
    }
  }

  bool get isAdmin {
    try {
      return userController.userModel.value.role == 'ADMIN';
    } catch (e) {
      return false;
    }
  }

  bool get isPartner {
    try {
      return userController.userModel.value.role == 'PARTNER';
    } catch (e) {
      return false;
    }
  }

  bool get isUser {
    try {
      return userController.userModel.value.role == 'USER';
    } catch (e) {
      return true; // Default to user if there's an error
    }
  }
}
