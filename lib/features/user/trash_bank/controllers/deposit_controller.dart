import 'package:eco_waste/features/user/trash_bank/models/waste_transaction_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/tps3r_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/confirmation_model.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WasteTransactionController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  RxList<WasteTransactionModel> transactions = <WasteTransactionModel>[].obs;
  RxList<WasteCategoryModel> categories = <WasteCategoryModel>[].obs;
  RxList<TPS3RModel> tps3rList = <TPS3RModel>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWasteCategories();
    loadTPS3RList();
  }

  /// Get all waste categories from API
  Future<void> loadWasteCategories() async {
    try {
      isLoading.value = true;

      final response = await httpHelper.getRequest('waste/categories');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> categoriesData = responseBody['data'];
          categories.value = categoriesData
              .map((item) => WasteCategoryModel.fromJson(item))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message:
                responseBody['message'] ?? 'Failed to load waste categories',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load waste categories: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get all TPS3R locations from API
  Future<void> loadTPS3RList() async {
    try {
      final response = await httpHelper.getRequest('tps3r');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> tps3rData = responseBody['data'];
          tps3rList.value = tps3rData
              .map((item) => TPS3RModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load TPS3R locations: ${e.toString()}',
      );
    }
  }

  /// Get user waste transactions from API
  Future<void> getTransactions({
    String? userId,
    String? tps3rId,
    String? status,
  }) async {
    try {
      isLoading.value = true;

      String endpoint = 'waste/transactions';
      Map<String, String> queryParams = {};

      if (userId != null) queryParams['userId'] = userId;
      if (tps3rId != null) queryParams['tps3rId'] = tps3rId;
      if (status != null) queryParams['status'] = status;

      if (queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) => '${e.key}=${e.value}')
            .join('&');
        endpoint += '?$queryString';
      }

      final response = await httpHelper.getRequest(endpoint);

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> transactionsData = responseBody['data'];
          transactions.value = transactionsData
              .map((item) => WasteTransactionModel.fromJson(item))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to load transactions',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load transactions: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Confirm deposit transaction
  Future<void> confirmDeposit({
    required String depositId,
    required bool depositValue,
  }) async {
    try {
      final confirmationModel = ConfirmationModel(
        id: depositId,
        value: depositValue,
      );

      final confirmationResponse = await httpHelper.patchRequest(
        'pengumpulan-sampah',
        confirmationModel.toJson(),
      );

      Get.back();

      if (confirmationResponse.statusCode == 200) {
        REYLoaders.successSnackBar(
          title: "Sukses mengonfirmasi pengumpulan sampah",
          message: "Pengumpulan sampah berhasil dikonfirmasi",
        );
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal mengonfirmasi pengumpulan sampah",
          message: "Terjadi kesalahan saat mengonfirmasi pengumpulan sampah",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal mengonfirmasi pengumpulan sampah",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatDepositTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm');
    return formatter.format(dateTime);
  }
}
