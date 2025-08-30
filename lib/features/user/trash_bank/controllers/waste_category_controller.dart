import 'package:eco_waste/features/user/trash_bank/models/waste_category_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class WasteCategoryController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // Data variables
  RxList<WasteCategoryModel> wasteCategories = <WasteCategoryModel>[].obs;

  // States variables
  Rx<bool> isLoading = false.obs;

  // Get all waste categories
  Future<void> fetchWasteCategories() async {
    isLoading.value = true;

    try {
      final response = await httpHelper.getRequest('waste/categories');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> categoriesJson = responseBody['data'];
          wasteCategories.value = categoriesJson
              .map((json) => WasteCategoryModel.fromJson(json))
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
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
