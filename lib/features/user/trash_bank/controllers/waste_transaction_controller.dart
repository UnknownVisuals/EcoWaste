import 'package:eco_waste/features/user/trash_bank/models/waste_transaction_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/tps3r_model.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

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

  /// Create new waste transaction
  Future<void> createTransaction({
    required String tps3rId,
    required List<WasteTransactionItem> items,
  }) async {
    try {
      isLoading.value = true;

      final createModel = CreateWasteTransactionModel(
        userId: userController.userModel.value.id,
        tps3rId: tps3rId,
        items: items,
      );

      final response = await httpHelper.postRequest(
        'waste/transactions',
        createModel.toJson(),
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction created successfully',
          );

          // Refresh transactions list
          await getTransactions(userId: userController.userModel.value.id);
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to create transaction',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to create transaction: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Process waste transaction (Admin/Partner only)
  Future<void> processTransaction(String transactionId) async {
    try {
      isLoading.value = true;

      final response = await httpHelper.postRequest(
        'waste/transactions/$transactionId/process',
        {},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction processed successfully',
          );

          // Refresh transactions list
          await getTransactions();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to process transaction',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to process transaction: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Cancel waste transaction
  Future<void> cancelTransaction(String transactionId) async {
    try {
      isLoading.value = true;

      final response = await httpHelper.postRequest(
        'waste/transactions/$transactionId/cancel',
        {},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction cancelled successfully',
          );

          // Refresh transactions list
          await getTransactions(userId: userController.userModel.value.id);
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to cancel transaction',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to cancel transaction: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get transaction details
  Future<WasteTransactionModel?> getTransactionDetails(
    String transactionId,
  ) async {
    try {
      final response = await httpHelper.getRequest(
        'waste/transactions/$transactionId',
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          return WasteTransactionModel.fromJson(responseBody['data']);
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load transaction details: ${e.toString()}',
      );
    }

    return null;
  }

  /// Calculate points for waste items
  int calculateTotalPoints(List<WasteTransactionItem> items) {
    int totalPoints = 0;

    for (var item in items) {
      final category = categories.firstWhereOrNull(
        (cat) => cat.id == item.categoryId,
      );

      if (category != null) {
        totalPoints += (category.pointsPerKg * item.weight).round();
      }
    }

    return totalPoints;
  }

  /// Get category by ID
  WasteCategoryModel? getCategoryById(String categoryId) {
    return categories.firstWhereOrNull((cat) => cat.id == categoryId);
  }

  /// Get TPS3R by ID
  TPS3RModel? getTPS3RById(String tps3rId) {
    return tps3rList.firstWhereOrNull((tps3r) => tps3r.id == tps3rId);
  }
}
