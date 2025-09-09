import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/features/user/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/rewards/widgets/rewards_card.dart';
import 'package:eco_waste/features/user/trash_bank/screens/rewards/rewards_detail.dart';
import 'package:eco_waste/features/user/trash_bank/screens/rewards/widgets/rewards_cart.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardsController rewardsController = Get.put(RewardsController());
    rewardsController.fetchRewards();

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'exchangePointsAction'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(Iconsax.shopping_cart),
                  onPressed: () => RewardsCart.showCartBottomSheet(context),
                ),
                if (rewardsController.cartItemCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: REYColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        rewardsController.cartItemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (rewardsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }
        final List<RewardsModel> rewards = rewardsController.rewards;
        if (rewards.isEmpty) {
          return Center(
            child: Text(
              'No rewards available',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: GridView.builder(
            itemCount: rewards.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: REYSizes.gridViewSpacing,
              mainAxisSpacing: REYSizes.gridViewSpacing,
              mainAxisExtent: 274,
            ),
            itemBuilder: (_, index) {
              final reward = rewards[index];
              return RewardsCard(
                reward: reward,
                name: reward.name,
                description: reward.description,
                pointsRequired: reward.pointsRequired,
                stock: reward.stock,
                image: 'https://greenappstelkom.id/generic-reward-image.png',
                onTap: () => Get.to(() => RewardsDetail(reward: reward)),
              );
            },
          ),
        );
      }),
    );
  }
}
