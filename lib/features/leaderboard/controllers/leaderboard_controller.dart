import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.find<REYHttpHelper>();
  final UserController userController = Get.find<UserController>();

  // Data variables
  RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;
  RxList<LeaderboardModel> allLeaderboard = <LeaderboardModel>[].obs;

  // State variables
  Rx<bool> isLoading = false.obs;
  Rx<String> selectedFilter = 'ALL_VILLAGES'.obs;

  // Filter method
  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  // Apply filter to leaderboard data
  void applyFilter() {
    if (selectedFilter.value == 'MY_VILLAGE') {
      final currentUserLocationId = userController.userModel.value.locationId;
      if (currentUserLocationId.isNotEmpty) {
        leaderboard.value = allLeaderboard
            .where((item) => item.locationId == currentUserLocationId)
            .toList();
      } else {
        leaderboard.value = allLeaderboard.toList();
      }
    } else {
      // ALL_VILLAGES or any other filter shows all data
      leaderboard.value = allLeaderboard.toList();
    }

    // Sort by points (descending) for proper ranking in UI
    leaderboard.sort((a, b) => b.points.compareTo(a.points));
  }

  // GET Leaderboard method
  Future<void> getLeaderboard() async {
    try {
      isLoading.value = true;

      final leaderboardResponse = await httpHelper.getRequest('leaderboard');

      if (leaderboardResponse.statusCode == 200) {
        final responseBody = leaderboardResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> leaderboardData = responseBody['data'] ?? [];

          allLeaderboard.value = leaderboardData
              .map(
                (item) =>
                    LeaderboardModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

          // Sort by rank if not already sorted
          allLeaderboard.sort((a, b) => a.rank.compareTo(b.rank));

          // Apply current filter
          applyFilter();
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'] ?? 'error'.tr,
            message: responseBody['message'] ?? 'failedToLoadLeaderboard'.tr,
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'HTTP ${leaderboardResponse.statusCode}',
          message:
              leaderboardResponse.body['message'] ??
              'failedToLoadLeaderboard'.tr,
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'error'.tr,
        message: '${'failedToLoadLeaderboard'.tr}: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
