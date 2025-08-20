import 'package:eco_waste/features/user/trash_bank/models/waste_transaction_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/waste_type_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/tps3r_model.dart';
import 'package:eco_waste/features/user/trash_bank/models/reward_model.dart';
import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  // Dashboard Statistics
  Rx<bool> isLoading = false.obs;
  RxMap<String, dynamic> dashboardStats = <String, dynamic>{}.obs;
  RxList<WasteTransactionModel> recentTransactions =
      <WasteTransactionModel>[].obs;
  RxList<LeaderboardModel> topUsers = <LeaderboardModel>[].obs;

  // System Management
  RxList<WasteCategoryModel> wasteCategories = <WasteCategoryModel>[].obs;
  RxList<TPS3RModel> tps3rLocations = <TPS3RModel>[].obs;
  RxList<RewardModel> rewards = <RewardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  /// Load all dashboard data
  Future<void> loadDashboardData() async {
    await Future.wait([
      getDashboardStats(),
      getRecentTransactions(),
      getTopUsers(),
      loadWasteCategories(),
      loadTPS3RLocations(),
      loadRewards(),
    ]);
  }

  /// Get dashboard statistics
  Future<void> getDashboardStats() async {
    try {
      isLoading.value = true;

      final response = await httpHelper.getRequest('admin/dashboard/stats');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          dashboardStats.value = responseBody['data'];
        }
      }
    } catch (e) {
      // If dashboard stats API doesn't exist, calculate manually
      await calculateManualStats();
    } finally {
      isLoading.value = false;
    }
  }

  /// Calculate statistics manually if API doesn't exist
  Future<void> calculateManualStats() async {
    try {
      // Get all transactions to calculate stats
      final transactionResponse = await httpHelper.getRequest(
        'waste/transactions',
      );

      if (transactionResponse.statusCode == 200) {
        final responseBody = transactionResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> transactionsData = responseBody['data'];
          final transactions = transactionsData
              .map((item) => WasteTransactionModel.fromJson(item))
              .toList();

          // Calculate manual statistics
          final totalTransactions = transactions.length;
          final pendingTransactions = transactions
              .where((t) => t.status == 'pending')
              .length;
          final processedTransactions = transactions
              .where((t) => t.status == 'processed')
              .length;
          final totalWeight = transactions.fold(
            0.0,
            (sum, t) => sum + t.totalWeight,
          );
          final totalPoints = transactions.fold(
            0,
            (sum, t) => sum + t.totalPoints,
          );

          dashboardStats.value = {
            'totalTransactions': totalTransactions,
            'pendingTransactions': pendingTransactions,
            'processedTransactions': processedTransactions,
            'totalWeightCollected': totalWeight,
            'totalPointsDistributed': totalPoints,
            'totalUsers': 0, // Would need separate user count API
            'totalTPS3R': tps3rLocations.length,
            'totalRewards': rewards.length,
          };
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to calculate statistics: ${e.toString()}',
      );
    }
  }

  /// Get recent transactions for dashboard
  Future<void> getRecentTransactions() async {
    try {
      final response = await httpHelper.getRequest(
        'waste/transactions?limit=10&sort=createdAt',
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> transactionsData = responseBody['data'];
          recentTransactions.value = transactionsData
              .map((item) => WasteTransactionModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load recent transactions: ${e.toString()}',
      );
    }
  }

  /// Get top users from leaderboard
  Future<void> getTopUsers() async {
    try {
      final response = await httpHelper.getRequest('leaderboard?limit=5');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> leaderboardData = responseBody['data'];
          topUsers.value = leaderboardData
              .map((item) => LeaderboardModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load top users: ${e.toString()}',
      );
    }
  }

  /// Load waste categories for management
  Future<void> loadWasteCategories() async {
    try {
      final response = await httpHelper.getRequest('waste/categories');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> categoriesData = responseBody['data'];
          wasteCategories.value = categoriesData
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

  /// Load TPS3R locations for management
  Future<void> loadTPS3RLocations() async {
    try {
      final response = await httpHelper.getRequest('tps3r');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> tps3rData = responseBody['data'];
          tps3rLocations.value = tps3rData
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

  /// Load rewards for management
  Future<void> loadRewards() async {
    try {
      final response = await httpHelper.getRequest('rewards');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> rewardsData = responseBody['data'];
          rewards.value = rewardsData
              .map((item) => RewardModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load rewards: ${e.toString()}',
      );
    }
  }

  /// Create new waste category (Admin only)
  Future<void> createWasteCategory({
    required String name,
    required String description,
    required double pointsPerKg,
    String? imageUrl,
  }) async {
    try {
      isLoading.value = true;

      final categoryData = {
        'name': name,
        'description': description,
        'pointsPerKg': pointsPerKg,
        'imageUrl': imageUrl,
        'isActive': true,
      };

      final response = await httpHelper.postRequest(
        'waste/categories',
        categoryData,
      );

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'Waste category created successfully',
          );

          // Refresh categories
          await loadWasteCategories();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message:
                responseBody['message'] ?? 'Failed to create waste category',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to create waste category: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Create new TPS3R location (Admin only)
  Future<void> createTPS3R({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
    String? description,
    String? contactNumber,
  }) async {
    try {
      isLoading.value = true;

      final tps3rData = {
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'description': description,
        'contactNumber': contactNumber,
        'isActive': true,
      };

      final response = await httpHelper.postRequest('tps3r', tps3rData);

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'TPS3R location created successfully',
          );

          // Refresh TPS3R locations
          await loadTPS3RLocations();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message:
                responseBody['message'] ?? 'Failed to create TPS3R location',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to create TPS3R location: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Create new reward (Admin only)
  Future<void> createReward({
    required String name,
    required String description,
    required int pointsRequired,
    required String category,
    String? imageUrl,
    int? stockQuantity,
  }) async {
    try {
      isLoading.value = true;

      final rewardData = {
        'name': name,
        'description': description,
        'pointsRequired': pointsRequired,
        'category': category,
        'imageUrl': imageUrl,
        'stockQuantity': stockQuantity,
        'isAvailable': true,
      };

      final response = await httpHelper.postRequest('rewards', rewardData);

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'Reward created successfully',
          );

          // Refresh rewards
          await loadRewards();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to create reward',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to create reward: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh all dashboard data
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }

  /// Get dashboard statistics as formatted strings
  Map<String, String> get formattedStats {
    return {
      'totalTransactions': '${dashboardStats['totalTransactions'] ?? 0}',
      'pendingTransactions': '${dashboardStats['pendingTransactions'] ?? 0}',
      'processedTransactions':
          '${dashboardStats['processedTransactions'] ?? 0}',
      'totalWeight':
          '${(dashboardStats['totalWeightCollected'] ?? 0.0).toStringAsFixed(2)} kg',
      'totalPoints': '${dashboardStats['totalPointsDistributed'] ?? 0} pts',
      'totalUsers': '${dashboardStats['totalUsers'] ?? 0}',
      'totalTPS3R': '${dashboardStats['totalTPS3R'] ?? 0}',
      'totalRewards': '${dashboardStats['totalRewards'] ?? 0}',
    };
  }
}
