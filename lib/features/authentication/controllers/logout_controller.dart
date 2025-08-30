import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  // Dependencies
  final UserController userController = Get.put(UserController());
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // States varables
  final Rx<bool> isLoading = false.obs;

  // Logout method
  Future<void> logout() async {
    isLoading.value = true;

    try {
      final logoutResponse = await httpHelper.postRequest('auth/logout', {});

      if (logoutResponse.statusCode == 200) {
        final responseBody = logoutResponse.body;

        if (responseBody['status'] == 'success') {
          await userController.clearSession();
          Get.offAll(() => const LoginScreen());

          REYLoaders.successSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: logoutResponse.body['status'],
          message: logoutResponse.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
