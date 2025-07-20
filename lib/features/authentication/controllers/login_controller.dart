import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/models/login_model.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());
  final GetStorage storage = GetStorage();

  Rx<bool> isLoading = false.obs;
  Rx<bool> rememberMe = false.obs;
  Rx<bool> obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(userController.userModel.value);
    _loadUserFromStorage();
  }

  void _loadUserFromStorage() {
    if (storage.read('rememberMe') == true) {
      final storedUser = storage.read('user');
      if (storedUser != null) {
        userController.userModel.value = UserModel.fromJson(storedUser);
        Get.off(UserNavigationMenu(userModel: userController.userModel.value));
      }
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required String role,
  }) async {
    isLoading.value = true;

    try {
      final loginModel = LoginModel(
        email: email,
        password: password,
        role: role,
      );

      final loginResponse = await httpHelper.postRequest(
        'auth/login',
        loginModel.toJson(),
      );

      if (loginResponse.statusCode == 200) {
        final responseBody = loginResponse.body;

        userController.updateUserModel(responseBody['user'], 0);
        await userController.refreshUserPoin(responseBody['user']['id']);

        if (rememberMe.value) {
          userController.saveUserToStorage();
        } else {
          userController.removeUserFromStorage();
        }

        Get.off(UserNavigationMenu(userModel: userController.userModel.value));
      } else {
        REYLoaders.errorSnackBar(
          title: 'Login Gagal',
          message: "Kesalahan Identitas",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Login Gagal',
        message: 'Gagal memproses login: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }
}
