import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final REYLocalStorage storage = REYLocalStorage();

  // User model - starts empty
  late Rx<UserModel> userModel = UserModel(
    id: '',
    name: '',
    email: '',
    role: '',
    locationId: '',
    points: 0,
    avatar: '',
    rt: '',
    rw: '',
  ).obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _autoLogin();
  }

  @override
  void onClose() {
    // Clear session cookie if remember me is false (when app is closed)
    final rememberMe = storage.readData<bool>('rememberMe') ?? false;
    if (!rememberMe) {
      REYHttpHelper.clearSessionCookie();
    }
    super.onClose();
  }

  // Auto-login if user has remember me enabled and valid session
  void _autoLogin() {
    final rememberMe = storage.readData<bool>('rememberMe') ?? false;
    final sessionCookie = storage.readData<String>('sessionCookie');

    if (rememberMe && sessionCookie != null) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    isLoading.value = true;

    try {
      final response = await httpHelper.getRequest('auth/me');

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          userModel.value = UserModel.fromJson(responseBody['data']);
        } else {
          _handleAuthError(
            responseBody['message'] ?? 'failedToFetchUserData'.tr,
          );
        }
      } else if (response.statusCode == 401) {
        // Session expired
        await clearSession();
        _redirectToLogin();
      } else {
        _handleAuthError(response.body['message'] ?? 'error'.tr);
      }
    } catch (e) {
      _handleAuthError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _handleAuthError(String message) {
    REYLoaders.errorSnackBar(title: 'error'.tr, message: message);
  }

  void _redirectToLogin() {
    if (Get.currentRoute != '/LoginScreen') {
      Future.delayed(Duration.zero, () {
        Get.offAll(() => const LoginScreen());
      });
    }
  }

  // Set remember me preference
  Future<void> setRememberMe(bool value) async {
    await storage.saveData('rememberMe', value);
  }

  // Clear all session data
  Future<void> clearSession() async {
    await storage.removeData('rememberMe');
    await REYHttpHelper.clearSessionCookie();

    // Reset user model
    userModel.value = UserModel(
      id: '',
      name: '',
      email: '',
      role: '',
      locationId: '',
      points: 0,
      avatar: '',
      rt: '',
      rw: '',
    );
  }
}
