import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogoutController extends GetxController {
  final GetStorage storage = GetStorage();

  Future<void> logout() async {
    storage.remove('user');
    storage.write('rememberMe', false);
    Get.offAll(() => const LoginScreen());
  }
}
