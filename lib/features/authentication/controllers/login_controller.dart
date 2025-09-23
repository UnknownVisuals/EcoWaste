import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/login_model.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  // State variables
  Rx<bool> isObscurePassword = true.obs;
  Rx<bool> isRememberMe = false.obs;
  Rx<bool> isLoading = false.obs;

  void toggleObscurePassword() =>
      isObscurePassword.value = !isObscurePassword.value;
  void toggleRememberMe(bool? value) => isRememberMe.value = value ?? false;

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
          // Set user data in controller
          userController.userModel.value = UserModel.fromJson(
            responseBody['data'],
          );

          // Set session cookie (persist only if remember me is checked)
          await REYHttpHelper.setSessionCookie(
            loginResponse,
            persist: isRememberMe.value,
          );

          // Save remember me preference
          await userController.setRememberMe(isRememberMe.value);

          Get.offAll(() => const NavigationMenu());
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
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
