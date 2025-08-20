import 'package:eco_waste/features/user/trash_bank/models/reward_model.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class RewardController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final UserController userController = Get.put(UserController());

  RxList<RewardModel> rewards = <RewardModel>[].obs;
  RxList<RewardModel> cartItems = <RewardModel>[].obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRewards();
  }

  /// Get all rewards from API
  Future<void> loadRewards() async {
    try {
      isLoading.value = true;

      final response = await httpHelper.getRequest('rewards');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> rewardsData = responseBody['data'];
          rewards.value = rewardsData
              .map((item) => RewardModel.fromJson(item))
              .toList();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to load rewards',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load rewards: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get reward details by ID
  Future<RewardModel?> getRewardDetails(String rewardId) async {
    try {
      final response = await httpHelper.getRequest('rewards/$rewardId');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          return RewardModel.fromJson(responseBody['data']);
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load reward details: ${e.toString()}',
      );
    }

    return null;
  }

  /// Redeem reward using points
  Future<void> redeemReward(String rewardId) async {
    try {
      isLoading.value = true;

      final redeemModel = RedeemRewardModel(
        userId: userController.userModel.value.id,
        rewardId: rewardId,
      );

      final response = await httpHelper.postRequest(
        'rewards/redeem',
        redeemModel.toJson(),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: responseBody['message'] ?? 'Reward redeemed successfully',
          );

          // Update user points
          await userController.refreshUserData();

          // Refresh rewards list
          await loadRewards();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to redeem reward',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to redeem reward: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Add reward to cart
  void addToCart(RewardModel reward) {
    cartItems.add(reward);
    REYLoaders.successSnackBar(
      title: 'Added to Cart',
      message: '${reward.name} added to cart',
    );
  }

  /// Remove reward from cart
  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      final removedItem = cartItems.removeAt(index);
      REYLoaders.successSnackBar(
        title: 'Removed from Cart',
        message: '${removedItem.name} removed from cart',
      );
    }
  }

  /// Clear all items from cart
  void clearCart() {
    cartItems.clear();
    REYLoaders.successSnackBar(
      title: 'Cart Cleared',
      message: 'All items removed from cart',
    );
  }

  /// Get cart item count
  int get itemCount => cartItems.length;

  /// Calculate total points required for cart items
  int get totalPointsRequired {
    int total = 0;
    for (var item in cartItems) {
      total += item.pointsRequired;
    }
    return total;
  }

  /// Check if user has enough points for cart
  bool get canRedeemCart {
    return userController.userModel.value.points >= totalPointsRequired;
  }

  /// Redeem all items in cart
  Future<void> redeemCartItems() async {
    if (!canRedeemCart) {
      REYLoaders.errorSnackBar(
        title: 'Insufficient Points',
        message:
            'You need ${totalPointsRequired - userController.userModel.value.points} more points',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Redeem each item in cart
      for (var reward in cartItems) {
        await redeemReward(reward.id);
      }

      // Clear cart after successful redemption
      clearCart();
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to redeem cart items: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get rewards by category
  List<RewardModel> getRewardsByCategory(String category) {
    return rewards.where((reward) => reward.category == category).toList();
  }

  /// Search rewards by name
  List<RewardModel> searchRewards(String query) {
    return rewards
        .where(
          (reward) => reward.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// Get available rewards (in stock)
  List<RewardModel> get availableRewards {
    return rewards.where((reward) => reward.isAvailable).toList();
  }

  /// Check if reward is in cart
  bool isInCart(String rewardId) {
    return cartItems.any((item) => item.id == rewardId);
  }
}
