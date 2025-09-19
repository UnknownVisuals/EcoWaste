import 'package:eco_waste/features/personalization/models/user_list_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserListController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // Data variable
  RxList<UserListModel> usersList = <UserListModel>[].obs;

  // States variable
  Rx<bool> isLoading = false.obs;

  // Fetch all users
  Future<void> fetchUsersList() async {
    isLoading.value = true;

    try {
      final response = await httpHelper.getRequest('users');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> usersJson = responseBody['data'];
          usersList.value = usersJson
              .map((json) => UserListModel.fromJson(json))
              .where((user) => user.role.toUpperCase() == 'NASABAH')
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
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
    }
  }
}
