// import 'package:eco_waste/features/admin/navigation_menu.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/login_model.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  // States variables
  Rx<bool> isObscurePassword = true.obs;
  Rx<bool> isRememberMe = false.obs;
  Rx<bool> isLoading = false.obs;

  // Toggle password visibility
  void toggleObscurePassword() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }

  // Login method
  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;

    try {
      final loginModel = LoginModel(email: email, password: password);
      final loginResponse = await httpHelper.postRequest(
        'auth/login',
        loginModel.toJson(),
      );

      await REYHttpHelper.setSessionCookie(loginResponse);

      if (loginResponse.statusCode == 200) {
        final responseBody = loginResponse.body;

        if (responseBody['status'] == 'success') {
          // Set user data immediately in controller
          userController.userModel.value = UserModel.fromJson(
            responseBody['data'],
          );

          // Set remember me preference - only store this flag, not user data
          await userController.setRememberMe(isRememberMe.value);

          if (userController.userModel.value.role == 'ADMIN') {
            // Get.offAll(() => AdminNavigationMenu());
            Get.offAll(() => UserNavigationMenu());
          } else {
            Get.offAll(() => UserNavigationMenu());
          }
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: loginResponse.body['status'],
          message: loginResponse.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
