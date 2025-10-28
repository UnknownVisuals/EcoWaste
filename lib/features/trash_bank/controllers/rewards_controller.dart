import 'package:eco_waste/features/trash_bank/models/rewards_history_model.dart';
import 'package:eco_waste/features/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class RewardsController extends GetxController {
  REYHttpHelper httpHelper = Get.put(REYHttpHelper());

  RxList<RewardsModel> rewards = RxList<RewardsModel>();
  RxList<RewardsModel> cartRewards = RxList<RewardsModel>();

  RxList<RewardsHistoryModel> rewardsHistory = RxList<RewardsHistoryModel>();
  RxList<RewardsHistoryModel> filteredRewardsHistory =
      RxList<RewardsHistoryModel>();

  Rx<bool> isLoading = false.obs;
  RxBool isHistoryLoading = false.obs;
  RxBool hasLoadedHistory = false.obs;
  RxString selectedHistoryFilter = 'ALL'.obs;
  RxBool isRedeeming = false.obs;
  RxString redeemingRewardId = ''.obs;

  // Fetch Rewards from API
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
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Rewards History from API
  Future<void> fetchRewardsHistory({bool forceRefresh = false}) async {
    if (isHistoryLoading.value) return;

    if (forceRefresh) {
      hasLoadedHistory.value = false;
    } else if (hasLoadedHistory.value) {
      applyHistoryFilter();
      return;
    }

    isHistoryLoading.value = true;

    try {
      final rewardsResponse = await httpHelper.getRequest('rewards/history');

      if (rewardsResponse.statusCode == 200) {
        final responseBody = rewardsResponse.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> rewardJson =
              (responseBody['data'] as List<dynamic>? ?? <dynamic>[]);
          final List<RewardsHistoryModel> parsedHistory = rewardJson
              .map((item) => RewardsHistoryModel.fromJson(item))
              .toList();

          parsedHistory.sort((a, b) {
            final DateTime aDate =
                a.redeemedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final DateTime bDate =
                b.redeemedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bDate.compareTo(aDate);
          });

          rewardsHistory.value = parsedHistory;
          hasLoadedHistory.value = true;
          applyHistoryFilter();
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
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isHistoryLoading.value = false;
      if (hasLoadedHistory.value || rewardsHistory.isNotEmpty) {
        applyHistoryFilter();
      }
    }
  }

  void applyHistoryFilter() {
    final String filter = selectedHistoryFilter.value;

    if (filter == 'ALL') {
      filteredRewardsHistory.value = List<RewardsHistoryModel>.from(
        rewardsHistory,
      );
      return;
    }

    filteredRewardsHistory.value = rewardsHistory.where((historyItem) {
      final String status = historyItem.status.toUpperCase();
      switch (filter) {
        case 'APPROVED':
          return status == 'APPROVED';
        case 'PENDING':
          return status == 'PENDING';
        default:
          return true;
      }
    }).toList();
  }

  void setHistoryFilter(String filter) {
    selectedHistoryFilter.value = filter;
    applyHistoryFilter();
  }

  void resetHistoryFilter() {
    setHistoryFilter('ALL');
  }

  Future<void> redeemRequest({required String rewardId}) async {
    if (isRedeeming.value) return;

    isRedeeming.value = true;
    redeemingRewardId.value = rewardId;

    try {
      final response = await httpHelper.postRequest('rewards/redeem-request', {
        'rewardId': rewardId,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
          await fetchRewardsHistory(forceRefresh: true);
        } else {
          REYLoaders.errorSnackBar(
            title: responseBody['status'],
            message: responseBody['message'],
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: response.body['status'],
          message: response.body['message'],
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(title: 'error'.tr, message: e.toString());
    } finally {
      isRedeeming.value = false;
      redeemingRewardId.value = '';
    }
  }

  // Cart Management Methods
  void addToCart(RewardsModel reward) {
    if (reward.stock > 0) {
      if (!cartRewards.any((item) => item.id == reward.id)) {
        cartRewards.add(reward);
        REYLoaders.successSnackBar(
          title: 'addToCart'.tr,
          message: '${reward.name} ${'addedToCart'.tr}',
        );
      } else {
        REYLoaders.warningSnackBar(
          title: 'alreadyInCart'.tr,
          message: '${reward.name} ${'isAlreadyInCart'.tr}',
        );
      }
    } else {
      REYLoaders.errorSnackBar(
        title: 'outOfStock'.tr,
        message: '${reward.name} ${'isOutOfStock'.tr}',
      );
    }
  }

  void removeFromCart(RewardsModel reward) {
    cartRewards.removeWhere((item) => item.id == reward.id);
    REYLoaders.successSnackBar(
      title: 'removedFromCart'.tr,
      message: '${reward.name} ${'removedFromCartMessage'.tr}',
    );
  }

  void clearCart() {
    cartRewards.clear();
    REYLoaders.successSnackBar(
      title: 'cartCleared'.tr,
      message: 'cartClearedMessage'.tr,
    );
  }

  bool isInCart(RewardsModel reward) {
    return cartRewards.any((item) => item.id == reward.id);
  }

  int get cartItemCount {
    return cartRewards.length;
  }

  int get totalCartPoints {
    return cartRewards.fold(0, (sum, reward) => sum + reward.pointsRequired);
  }
}
