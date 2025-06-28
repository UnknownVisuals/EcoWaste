import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<bool> rememberMe = false.obs;
  Rx<bool> obscurePassword = true.obs;

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }
}
