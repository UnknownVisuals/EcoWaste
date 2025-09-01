import 'package:eco_waste/features/user/trash_bank/models/transaction_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // Data variables
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<TransactionModel> filteredTransactions = <TransactionModel>[].obs;

  // Filter state
  RxString selectedFilter = 'ALL'.obs;

  // States variable
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load session cookie from storage
    REYHttpHelper.loadSessionCookie();
    // Initialize filtered transactions as all transactions
    filteredTransactions.value = transactions;
    // Ensure filter starts as 'ALL'
    selectedFilter.value = 'ALL';
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

          // Update the transaction in local cache if it exists
          final index = transactions.indexWhere((tx) => tx.id == transactionId);
          if (index != -1) {
            transactions[index] = updatedTransaction;
            applyFilter(); // Reapply filter to update UI
          }

          return updatedTransaction;
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'] ?? 'Error',
            message:
                responseBody['message'] ?? 'Failed to load transaction details',
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${response.statusCode}',
          message: 'Failed to fetch transaction details',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load transaction details: ${e.toString()}',
      );
    }
    return null;
  }

  // Get all transactions and filter by user
  Future<void> fetchTransactions({
    String? userId,
    bool forceRefresh = false,
  }) async {
    try {
      // Skip loading if we already have data and not forcing refresh
      if (!forceRefresh && transactions.isNotEmpty && !isLoading.value) {
        return;
      }

      isLoading.value = true;

      // Build query parameters if userId is provided
      String endpoint = 'waste/transactions';
      if (userId != null && userId.isNotEmpty) {
        endpoint += '?userId=$userId';
      }

      final transactionsResponse = await httpHelper.getRequest(endpoint);

      if (transactionsResponse.statusCode == 200) {
        final responseBody = transactionsResponse.body;

        if (responseBody is Map<String, dynamic> &&
            responseBody['status'] == 'success') {
          final List<dynamic> transactionsJson = responseBody['data'] ?? [];

          List<TransactionModel> allTransactions = transactionsJson
              .map(
                (json) =>
                    TransactionModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();

          // If we used userId in query params, the API should have filtered for us
          // But if not, we'll filter client-side as fallback
          if (userId != null &&
              userId.isNotEmpty &&
              !endpoint.contains('userId')) {
            transactions.value = allTransactions
                .where((transaction) => transaction.userId == userId)
                .toList();
          } else {
            transactions.value = allTransactions;
          }

          // Sort by creation date (newest first)
          transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          // Apply current filter
          applyFilter();
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'] ?? 'Error',
            message: responseBody['message'] ?? 'Failed to load transactions',
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${transactionsResponse.statusCode}',
          message: 'Failed to fetch transactions',
        );
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

  // Method to refresh transactions
  Future<void> refreshTransactions({String? userId}) async {
    await fetchTransactions(userId: userId, forceRefresh: true);
  }

  // Filter methods
  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void resetFilter() {
    selectedFilter.value = 'ALL';
    applyFilter();
  }

  void applyFilter() {
    if (selectedFilter.value == 'ALL') {
      filteredTransactions.value = List.from(transactions);
    } else {
      filteredTransactions.value = transactions.where((transaction) {
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

    // Print transaction statuses for debugging
    if (transactions.isNotEmpty) {
      final statusCounts = <String, int>{};
      for (final transaction in transactions) {
        final status = transaction.status.toUpperCase();
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      }
    }
  }

  // Create a new transaction
  Future<bool> createTransaction(TransactionModel transaction) async {
    isLoading.value = true;

    try {
      final transactionsResponse = await httpHelper.postRequest(
        'waste/transactions',
        transaction.toJson(),
      );

      if (transactionsResponse.statusCode == 201) {
        final responseBody = transactionsResponse.body;

        if (responseBody['status'] == 'success') {
          final newTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );
          transactions.insert(
            0,
            newTransaction,
          ); // Add to beginning (newest first)
          // Reapply filter to update UI
          applyFilter();

          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction created successfully',
          );
          return true;
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${transactionsResponse.statusCode}',
          message: 'Failed to create transaction',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  // Process a transaction (Admin/Partner only)
  Future<void> processTransaction(String transactionId) async {
    isLoading.value = true;

    try {
      final transactionsResponse = await httpHelper.postRequest(
        'waste/transactions/$transactionId/process',
        {},
      );

      if (transactionsResponse.statusCode == 200) {
        final responseBody = transactionsResponse.body;

        if (responseBody['status'] == 'success') {
          final updatedTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );
          final index = transactions.indexWhere((tx) => tx.id == transactionId);
          if (index != -1) {
            transactions[index] = updatedTransaction;
            // Reapply filter to update UI
            applyFilter();
          }
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction processed successfully',
          );
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${transactionsResponse.statusCode}',
          message: 'Failed to process transaction',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Cancel a transaction
  Future<void> cancelTransaction(String transactionId) async {
    isLoading.value = true;

    try {
      final transactionsResponse = await httpHelper.postRequest(
        'waste/transactions/$transactionId/cancel',
        {},
      );

      if (transactionsResponse.statusCode == 200) {
        final responseBody = transactionsResponse.body;

        if (responseBody['status'] == 'success') {
          final updatedTransaction = TransactionModel.fromJson(
            responseBody['data'],
          );
          final index = transactions.indexWhere((tx) => tx.id == transactionId);
          if (index != -1) {
            transactions[index] = updatedTransaction;
            // Reapply filter to update UI
            applyFilter();
          }
          REYLoaders.successSnackBar(
            title: 'Success',
            message:
                responseBody['message'] ?? 'Transaction cancelled successfully',
          );
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${transactionsResponse.statusCode}',
          message: 'Failed to cancel transaction',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
