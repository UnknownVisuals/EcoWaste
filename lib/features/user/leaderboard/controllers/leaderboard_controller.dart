import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;
  Rx<bool> isLoading = false.obs;

  // GET Leaderboard
  Future<void> getLeaderboard() async {
    isLoading.value = true;

    try {
      final leaderboardResponse = await httpHelper.getRequest('leaderboard');

      if (leaderboardResponse.statusCode == 200) {
        final responseBody = leaderboardResponse.body;

        if (responseBody != null && responseBody is Map<String, dynamic>) {
          if (responseBody['status'] == 'success') {
            final dynamic data = responseBody['data'];
            if (data != null && data is List) {
              final List<dynamic> leaderboardData = data;
              leaderboard.value = leaderboardData
                  .map((item) => LeaderboardModel.fromJson(item))
                  .toList();
            } else {
              REYLoaders.errorSnackBar(
                title: "Gagal memuat peringkat",
                message: "Format data tidak valid",
              );
            }
          } else {
            REYLoaders.errorSnackBar(
              title: "Gagal memuat peringkat",
              message:
                  responseBody['message'] ??
                  "Kesalahan saat memuat data peringkat",
            );
          }
        } else {
          REYLoaders.errorSnackBar(
            title: "Gagal memuat peringkat",
            message: "Response format tidak valid",
          );
        }
      } else if (leaderboardResponse.statusCode == 401) {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat peringkat",
          message: "Sesi telah berakhir. Silakan login kembali.",
        );
        // Trigger re-authentication
        Get.find<AuthController>().logout();
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat peringkat",
          message: "Server error: ${leaderboardResponse.statusCode}",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat peringkat",
        message: "Network error: ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
