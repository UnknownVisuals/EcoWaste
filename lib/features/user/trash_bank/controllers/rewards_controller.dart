import 'package:eco_waste/features/user/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class RewardsController extends GetxController {
  REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<RewardsModel> rewards = RxList<RewardsModel>();

  Rx<bool> isLoading = false.obs;

  Future<void> fetchRewards() async {
    isLoading.value = true;

    try {
      final rewardsResponse = await httpHelper.getRequest('rewards');

      if (rewardsResponse.statusCode == 200) {
        final responseBody = rewardsResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> rewardJson = responseBody['data'];
          rewards.value = rewardJson
              .map((item) => RewardsModel.fromJson(item))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: rewardsResponse.body['status'],
          message: rewardsResponse.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
