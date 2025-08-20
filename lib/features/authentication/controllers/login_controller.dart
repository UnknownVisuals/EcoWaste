import 'package:eco_waste/features/admin/navigation_menu.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/login_model.dart';
import 'package:eco_waste/features/user/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());
  final GetStorage storage = GetStorage();

  // Temporary variables
  Rx<bool> isObscurePassword = true.obs;
  Rx<bool> isRememberMe = false.obs;
  Rx<bool> isLoading = false.obs;

  /// Login user with email and password
  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;

    try {
      final loginModel = LoginModel(email: email, password: password);

      final loginResponse = await httpHelper.postRequest(
        'auth/login',
        loginModel.toJson(),
      );

      if (loginResponse.statusCode == 200) {
        final responseBody = loginResponse.body;

        if (responseBody['status'] == 'success') {
          final userData = responseBody['data'];

          userController.updateUserModel(userData);
          userController.saveUserToStorage(userData);
          _navigateBasedOnRole();

          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Login successful',
          );
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Login failed',
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

  /// Navigate to the appropriate screen based on user role
  void _navigateBasedOnRole() {
    if (userController.userModel.value.role == 'ADMIN') {
      Get.off(AdminNavigationMenu(userModel: userController.userModel.value));
    } else {
      Get.off(UserNavigationMenu(userModel: userController.userModel.value));
    }
  }

  // Toggle obscured password
  void toggleObscuredPassword() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }
}
