import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  // Dependencies
  final GetStorage storage = GetStorage();
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // User model
  late Rx<UserModel> userModel = UserModel(
    id: '',
    name: '',
    email: '',
    role: 'USER',
    locationId: '',
    points: 0,
    avatar: '',
    tps3rId: null,
  ).obs;

  Rx<bool> isLoading = false.obs;

  /// Update user model with API response data
  void updateUserModel(Map<String, dynamic> userData) {
    try {
      userModel.value = UserModel.fromJson(userData);
    } catch (e) {
      print('Error updating user model: $e');
      // Keep the existing model if update fails
    }
  }

  /// Save user to local storage
  void saveUserToStorage(userData) {
    try {
      storage.write('user', userModel.value.toJson());
      storage.write('rememberMe', true);
    } catch (e) {
      print('Error saving user to storage: $e');
    }
  }

  /// Remove user from local storage
  void removeUserFromStorage() {
    storage.remove('user');
    storage.write('rememberMe', false);
  }

  /// Refresh user data from server
  Future<void> refreshUserData() async {
    try {
      isLoading.value = true;

      // Make API call to get fresh user data
      final response = await httpHelper.getRequest('users/profile');

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          updateUserModel(responseBody['data']);
          saveUserToStorage(responseBody['data']);
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to refresh user data: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
