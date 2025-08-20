import 'package:eco_waste/features/user/trash_bank/models/waste_transaction_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/tps3r_model.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AdminWasteTransactionController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  RxList<WasteTransactionModel> allTransactions = <WasteTransactionModel>[].obs;
  RxList<WasteTransactionModel> pendingTransactions =
      <WasteTransactionModel>[].obs;
  RxList<WasteTransactionModel> processedTransactions =
      <WasteTransactionModel>[].obs;
  RxList<WasteCategoryModel> categories = <WasteCategoryModel>[].obs;
  RxList<TPS3RModel> tps3rList = <TPS3RModel>[].obs;

  Rx<bool> isLoading = false.obs;
  RxString selectedFilter = 'all'.obs; // all, pending, processed, cancelled

  @override
  void onInit() {
    super.onInit();
    loadWasteCategories();
    loadTPS3RList();
    loadAllTransactions();
  }

  /// Get all waste categories from API
  Future<void> loadWasteCategories() async {
    try {
      final response = await httpHelper.getRequest('waste/categories');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> categoriesData = responseBody['data'];
          categories.value = categoriesData
              .map((item) => WasteCategoryModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load waste categories: ${e.toString()}',
      );
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

  /// Get all waste transactions (Admin view)
  Future<void> loadAllTransactions({String? status, String? tps3rId}) async {
    try {
      isLoading.value = true;

      String endpoint = 'waste/transactions';
      Map<String, String> queryParams = {};

      if (status != null) queryParams['status'] = status;
      if (tps3rId != null) queryParams['tps3rId'] = tps3rId;

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
          final transactions = transactionsData
              .map((item) => WasteTransactionModel.fromJson(item))
              .toList();

          allTransactions.value = transactions;

          // Filter transactions by status
          pendingTransactions.value = transactions
              .where((t) => t.status == 'pending')
              .toList();

          processedTransactions.value = transactions
              .where((t) => t.status == 'processed')
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

  /// Process waste transaction (Admin action)
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
          await loadAllTransactions();
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

  /// Reject waste transaction (Admin action)
  Future<void> rejectTransaction(String transactionId, {String? reason}) async {
    try {
      isLoading.value = true;

      final requestData = reason != null
          ? {'reason': reason}
          : <String, dynamic>{};

      final response = await httpHelper.postRequest(
        'waste/transactions/$transactionId/reject',
        requestData,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction rejected successfully',
          );

          // Refresh transactions list
          await loadAllTransactions();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to reject transaction',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to reject transaction: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Update transaction weight and points (Admin action)
  Future<void> updateTransactionWeight(
    String transactionId,
    List<WasteTransactionItem> updatedItems,
  ) async {
    try {
      isLoading.value = true;

      final updateData = {
        'items': updatedItems.map((item) => item.toJson()).toList(),
      };

      final response = await httpHelper.putRequest(
        'waste/transactions/$transactionId',
        updateData,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'Transaction updated successfully',
          );

          // Refresh transactions list
          await loadAllTransactions();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to update transaction',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update transaction: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get filtered transactions based on selected filter
  List<WasteTransactionModel> get filteredTransactions {
    switch (selectedFilter.value) {
      case 'pending':
        return pendingTransactions;
      case 'processed':
        return processedTransactions;
      case 'cancelled':
        return allTransactions.where((t) => t.status == 'cancelled').toList();
      default:
        return allTransactions;
    }
  }

  /// Change filter and refresh data if needed
  void changeFilter(String filter) {
    selectedFilter.value = filter;
    if (filter != 'all') {
      loadAllTransactions(status: filter);
    } else {
      loadAllTransactions();
    }
  }

  /// Get transactions by TPS3R
  List<WasteTransactionModel> getTransactionsByTPS3R(String tps3rId) {
    return allTransactions.where((t) => t.tps3rId == tps3rId).toList();
  }

  /// Get transaction statistics
  Map<String, int> get transactionStats {
    return {
      'total': allTransactions.length,
      'pending': pendingTransactions.length,
      'processed': processedTransactions.length,
      'cancelled': allTransactions.where((t) => t.status == 'cancelled').length,
    };
  }

  /// Calculate total points distributed
  int get totalPointsDistributed {
    return processedTransactions.fold(
      0,
      (sum, transaction) => sum + transaction.totalPoints,
    );
  }

  /// Calculate total weight collected
  double get totalWeightCollected {
    return processedTransactions.fold(
      0.0,
      (sum, transaction) => sum + transaction.totalWeight,
    );
  }

  /// Get transactions by date range
  List<WasteTransactionModel> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return allTransactions.where((transaction) {
      final createdAtString = transaction.createdAt;
      if (createdAtString == null) return false;

      try {
        final createdAt = DateTime.parse(createdAtString);
        return createdAt.isAfter(startDate) &&
            createdAt.isBefore(endDate.add(const Duration(days: 1)));
      } catch (e) {
        return false; // Invalid date format
      }
    }).toList();
  }

  /// Search transactions by user name or transaction ID
  List<WasteTransactionModel> searchTransactions(String query) {
    if (query.isEmpty) return filteredTransactions;

    return filteredTransactions.where((transaction) {
      return transaction.id.toLowerCase().contains(query.toLowerCase()) ||
          transaction.userId.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  /// Get waste category by ID
  WasteCategoryModel? getCategoryById(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null; // Category not found
    }
  }
}
