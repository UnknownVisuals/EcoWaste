import 'package:eco_waste/features/user/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AdminLeaderboardController extends GetxController {
  final REYHttpHelper httpHelper = Get.find<REYHttpHelper>();

  RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;
  Rx<bool> isLoading = false.obs;

  // GET Leaderboard
  Future<void> getLeaderboard() async {
    isLoading.value = true;

    try {
      final leaderboardResponse = await httpHelper.getRequest('leaderboard');

      if (leaderboardResponse.statusCode == 200) {
        final jsonData = leaderboardResponse.body;

        leaderboard.value = (jsonData as List)
            .map((item) => LeaderboardModel.fromJson(item))
            .toList();
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat peringkat",
          message: "Kesalahan saat memuat data peringkat",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat peringkat",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Admin specific method to update leaderboard
  Future<void> updateLeaderboard(String userId, int newPoints) async {
    isLoading.value = true;

    try {
      final updateResponse = await httpHelper.putRequest(
        'leaderboard/$userId',
        {'poinSaatIni': newPoints},
      );

      if (updateResponse.statusCode == 200) {
        REYLoaders.successSnackBar(
          title: "Berhasil memperbarui peringkat",
          message: "Poin pengguna berhasil diperbarui",
        );
        await getLeaderboard(); // Refresh leaderboard
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memperbarui peringkat",
          message: "Kesalahan saat memperbarui data peringkat",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memperbarui peringkat",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
