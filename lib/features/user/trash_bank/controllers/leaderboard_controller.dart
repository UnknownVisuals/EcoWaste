import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class TrashBankLeaderboardController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;
  Rx<bool> isLoading = false.obs;
  RxString selectedPeriod = 'monthly'.obs; // weekly, monthly, yearly

  @override
  void onInit() {
    super.onInit();
    loadLeaderboard();
  }

  /// Get leaderboard from API
  Future<void> loadLeaderboard({String? period}) async {
    try {
      isLoading.value = true;

      String endpoint = 'leaderboard';
      if (period != null) {
        endpoint += '?period=$period';
        selectedPeriod.value = period;
      } else {
        endpoint += '?period=${selectedPeriod.value}';
      }

      final response = await httpHelper.getRequest(endpoint);

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> leaderboardData = responseBody['data'];
          leaderboard.value = leaderboardData
              .map((item) => LeaderboardModel.fromJson(item))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to load leaderboard',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load leaderboard: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Change leaderboard period
  Future<void> changePeriod(String period) async {
    if (selectedPeriod.value != period) {
      await loadLeaderboard(period: period);
    }
  }

  /// Get user rank by ID
  int getUserRank(String userId) {
    for (int i = 0; i < leaderboard.length; i++) {
      if (leaderboard[i].userId == userId) {
        return i + 1; // Rank starts from 1
      }
    }
    return -1; // User not found in leaderboard
  }

  /// Get user leaderboard entry
  LeaderboardModel? getUserEntry(String userId) {
    return leaderboard.firstWhereOrNull((entry) => entry.userId == userId);
  }

  /// Get top N users
  List<LeaderboardModel> getTopUsers(int count) {
    return leaderboard.take(count).toList();
  }

  /// Check if user is in top N
  bool isUserInTop(String userId, int topCount) {
    final userRank = getUserRank(userId);
    return userRank > 0 && userRank <= topCount;
  }

  /// Get available periods
  List<Map<String, String>> get availablePeriods => [
    {'value': 'weekly', 'label': 'Weekly'},
    {'value': 'monthly', 'label': 'Monthly'},
    {'value': 'yearly', 'label': 'Yearly'},
  ];

  /// Format period label
  String get currentPeriodLabel {
    switch (selectedPeriod.value) {
      case 'weekly':
        return 'Weekly';
      case 'monthly':
        return 'Monthly';
      case 'yearly':
        return 'Yearly';
      default:
        return 'Monthly';
    }
  }
}
