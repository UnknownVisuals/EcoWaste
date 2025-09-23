import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/models/transactions_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.find<UserController>();

  // Data variables
  RxList<TransactionModel> allTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> filteredTransactions = <TransactionModel>[].obs;

  // Filter state
  RxString selectedFilter = 'ALL'.obs;

  // State variables
  RxBool isLoading = false.obs;
  RxBool hasInitialFetch = false.obs;

  @override
  void onInit() {
    super.onInit();
    filteredTransactions.value = allTransactions;
    selectedFilter.value = 'ALL';
  }

  // Get all transactions from API and apply role-based filtering
  Future<void> fetchTransactions({bool forceRefresh = false}) async {
    try {
      // Skip if already loading or have data (unless forcing refresh)
      if (!forceRefresh &&
          (allTransactions.isNotEmpty || hasInitialFetch.value) &&
          !isLoading.value) {
        return;
      }

      if (forceRefresh) hasInitialFetch.value = false;

      isLoading.value = true;

      // Fetch all transactions from API (no server-side filtering)
      final response = await httpHelper.getRequest('waste/transactions');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody is Map<String, dynamic> &&
            responseBody['status'] == 'success') {
          final List<dynamic> transactionsJson = responseBody['data'] ?? [];

          // Parse all transactions
          List<TransactionModel> apiTransactions = transactionsJson
              .map(
                (json) =>
                    TransactionModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();

          // Apply role-based filtering
          allTransactions.value = _applyRoleBasedFilter(apiTransactions);

          // Sort by creation date (newest first)
          allTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          hasInitialFetch.value = true;
          applyStatusFilter();
        } else {
          _handleError(responseBody['status'], responseBody['message']);
        }
      } else {
        _handleError(response.body['status'], response.body['message']);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Apply role-based filtering
  List<TransactionModel> _applyRoleBasedFilter(
    List<TransactionModel> transactions,
  ) {
    final userRole = userController.userModel.value.role.toUpperCase();
    final userId = userController.userModel.value.id;

    if (userRole == 'NASABAH') {
      // Filter transactions by current user ID
      return transactions
          .where((transaction) => transaction.userId == userId)
          .toList();
    } else if (userRole == 'PETUGAS') {
      // Show all transactions for PETUGAS
      return transactions;
    }

    // Default: show user's own transactions
    return transactions
        .where((transaction) => transaction.userId == userId)
        .toList();
  }

  // Apply status-based filtering
  void applyStatusFilter() {
    if (selectedFilter.value == 'ALL') {
      filteredTransactions.value = List.from(allTransactions);
    } else {
      filteredTransactions.value = allTransactions.where((transaction) {
        final status = transaction.status.toUpperCase();
        switch (selectedFilter.value) {
          case 'CONFIRMED':
            return status == 'COMPLETED' ||
                status == 'PROCESSED' ||
                status == 'SUCCESS' ||
                status == 'APPROVED';
          case 'PENDING':
            return status == 'PENDING';
          case 'REJECTED':
            return status == 'CANCELLED' ||
                status == 'REJECTED' ||
                status == 'FAILED' ||
                status == 'DENIED';
          default:
            return true;
        }
      }).toList();
    }
  }

  // Set status filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyStatusFilter();
  }

  // Reset filter to show all
  void resetFilter() {
    selectedFilter.value = 'ALL';
    applyStatusFilter();
  }

  // Refresh transactions
  Future<void> refreshTransactions() async {
    await fetchTransactions(forceRefresh: true);
  }

  // Get single transaction details and update local cache
  Future<TransactionModel?> fetchTransactionDetails(
    String transactionId,
  ) async {
    try {
      final response = await httpHelper.getRequest(
        'waste/transactions/$transactionId',
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody is Map<String, dynamic> &&
            responseBody['status'] == 'success') {
          final updatedTransaction = TransactionModel.fromJson(
            responseBody['data'] as Map<String, dynamic>,
          );

          // Update in local cache
          final index = allTransactions.indexWhere(
            (tx) => tx.id == transactionId,
          );
          if (index != -1) {
            allTransactions[index] = updatedTransaction;
            applyStatusFilter();
          }

          return updatedTransaction;
        } else {
          _handleError(responseBody['status'], responseBody['message']);
        }
      } else {
        _handleError(response.body['status'], response.body['message']);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    }
    return null;
  }

  // Helper method for error handling
  void _handleError(String? title, String? message) {
    REYLoaders.errorSnackBar(
      title: title ?? 'error'.tr,
      message: message ?? 'error'.tr,
    );
  }

  // Create a new transaction
  Future<bool> createTransaction(TransactionModel transaction) async {
    isLoading.value = true;

    try {
      final response = await httpHelper.postRequest(
        'waste/transactions',
        transaction.toJson(),
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final newTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );

          // Add to beginning (newest first) and reapply filters
          allTransactions.insert(0, newTransaction);
          applyStatusFilter();

          REYLoaders.successSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
          return true;
        } else {
          _handleError(responseBody['status'], responseBody['message']);
        }
      } else {
        _handleError(response.body['status'], response.body['message']);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  // Process a transaction (Admin/PETUGAS only)
  Future<void> processTransaction(String transactionId) async {
    isLoading.value = true;

    try {
      final response = await httpHelper.postRequest(
        'waste/transactions/$transactionId/process',
        {},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final updatedTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );

          // Update in local cache
          final index = allTransactions.indexWhere(
            (tx) => tx.id == transactionId,
          );
          if (index != -1) {
            allTransactions[index] = updatedTransaction;
            applyStatusFilter();
          }

          REYLoaders.successSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        } else {
          _handleError(responseBody['status'], responseBody['message']);
        }
      } else {
        _handleError(response.body['status'], response.body['message']);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Cancel a transaction
  Future<void> cancelTransaction(String transactionId) async {
    isLoading.value = true;

    try {
      final response = await httpHelper.postRequest(
        'waste/transactions/$transactionId/cancel',
        {},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final updatedTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );

          // Update in local cache
          final index = allTransactions.indexWhere(
            (tx) => tx.id == transactionId,
          );
          if (index != -1) {
            allTransactions[index] = updatedTransaction;
            applyStatusFilter();
          }

          REYLoaders.successSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        } else {
          _handleError(responseBody['status'], responseBody['message']);
        }
      } else {
        _handleError(response.body['status'], response.body['message']);
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Getter for backwards compatibility
  RxList<TransactionModel> get transactions => allTransactions;
}
