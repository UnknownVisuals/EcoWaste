import 'package:eco_waste/features/trash_bank/models/waste_category_model.dart';
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
    if (isLoading.value) return;
    isLoading.value = true;

    final List<WasteCategoryModel> fetchedCategories = [];
    var encounteredError = false;

    try {
      int currentPage = 1;
      int totalPages = 1;
      int? pageSize;

      // Iterate through each paginated page until we've gathered all categories.
      while (currentPage <= totalPages) {
        final endpoint = _buildEndpoint(currentPage, pageSize);
        final response = await httpHelper.getRequest(endpoint);

        if (response.statusCode != 200) {
          REYLoaders.errorSnackBar(
            title: response.body['status'] ?? 'error'.tr,
            message: response.body['message'] ?? 'error'.tr,
          );
          encounteredError = true;
          break;
        }

        final responseBody = response.body;
        if (responseBody['status'] != 'success') {
          REYLoaders.errorSnackBar(
            title: responseBody['status'] ?? 'error'.tr,
            message: responseBody['message'] ?? 'error'.tr,
          );
          encounteredError = true;
          break;
        }

        final List<dynamic> categoriesJson =
            (responseBody['data'] as List<dynamic>?) ?? const [];
        fetchedCategories.addAll(
          categoriesJson.map((json) => WasteCategoryModel.fromJson(json)),
        );

        final meta = responseBody['meta'];
        if (meta is Map<String, dynamic>) {
          final int parsedPage = _parseInt(meta['page']) ?? currentPage;
          final int parsedTotal =
              _parseInt(meta['total']) ?? fetchedCategories.length;
          final int resolvedPageSize =
              _parseInt(meta['pageSize']) ?? pageSize ?? categoriesJson.length;

          pageSize = resolvedPageSize;

          if (resolvedPageSize > 0) {
            totalPages = (parsedTotal / resolvedPageSize).ceil();
          } else {
            totalPages = parsedPage;
          }

          if (parsedPage >= totalPages) {
            break;
          }
        } else {
          // Stop if the API does not return pagination metadata and we received fewer items.
          if (categoriesJson.isEmpty) {
            break;
          }
        }

        currentPage++;
      }

      if (!encounteredError) {
        wasteCategories.assignAll(fetchedCategories);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String _buildEndpoint(int page, int? pageSize) {
    if (pageSize != null && pageSize > 0) {
      return 'waste/categories?page=$page&pageSize=$pageSize';
    }
    return 'waste/categories?page=$page';
  }

  int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
