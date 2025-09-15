import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final storage = REYLocalStorage();

  // Initialize with empty user model - will be populated from API
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
  final RxBool isSessionValid = true.obs;
  final RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Add a small delay to ensure GetStorage is fully initialized
    Future.delayed(const Duration(milliseconds: 100), () {
      _initializeSession();
    });
  }

  void _initializeSession() {
    // Check if user has active session (remember me was checked)
    final rememberMe = storage.readData<bool>('rememberMe') ?? false;
    final sessionCookie = storage.readData<String>('sessionCookie');

    if (rememberMe && sessionCookie != null) {
      // Set loading to true immediately to prevent race condition in UI
      isLoading.value = true;
      // Ensure session cookie is loaded in HTTP helper
      REYHttpHelper.loadSessionCookie();
      // If remember me is true and we have a session cookie, fetch current user data
      fetchCurrentUser();
    } else {
      // Mark as initialized even if we don't have a session to restore
      isInitialized.value = true;
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
          isSessionValid.value = true;
          // We don't save user data to storage anymore - only session token is persisted
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'] ?? 'error'.tr,
            message: responseBody['message'] ?? 'failedToFetchUserData'.tr,
          );
        }
      } else if (response.statusCode == 401) {
        // Session expired or invalid, clear stored data and mark session as invalid
        isSessionValid.value = false;
        await clearSession();
        _redirectToLogin();
      } else {
        REYLoaders.errorSnackBar(
          title: response.body['status'],
          message: response.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
      isInitialized.value = true;
    }
  }

  void _redirectToLogin() {
    // Only redirect if we're not already on the login screen
    if (Get.currentRoute != '/LoginScreen') {
      Future.delayed(Duration.zero, () {
        Get.offAll(() => const LoginScreen());
      });
    }
  }

  // Simplified storage methods - only handle rememberMe flag and session token
  Future<void> setRememberMe(bool value) async {
    await storage.saveData('rememberMe', value);
  }

  Future<void> clearSession() async {
    await storage.removeData('rememberMe');
    await REYHttpHelper.clearSessionCookie();
    // Reset user model to empty state
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
    isSessionValid.value = false;
  }
}
