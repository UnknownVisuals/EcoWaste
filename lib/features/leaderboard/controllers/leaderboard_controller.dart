import 'package:eco_waste/features/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  // Dependencies
  final REYHttpHelper httpHelper = Get.find<REYHttpHelper>();

  // Data variables
  RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;

  // State variables
  Rx<bool> isLoading = false.obs;

  // GET Leaderboard method
  Future<void> getLeaderboard() async {
    try {
      isLoading.value = true;

      final leaderboardResponse = await httpHelper.getRequest('leaderboard');

      if (leaderboardResponse.statusCode == 200) {
        final responseBody = leaderboardResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> leaderboardData = responseBody['data'] ?? [];

          leaderboard.value = leaderboardData
              .map(
                (item) =>
                    LeaderboardModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

          // Sort by rank if not already sorted
          leaderboard.sort((a, b) => a.rank.compareTo(b.rank));
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
