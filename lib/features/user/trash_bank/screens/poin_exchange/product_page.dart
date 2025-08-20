import 'package:badges/badges.dart' as badges;
import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/reward_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/product_card.dart'; // Ensure this path is correct
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/widgets/cart_bottom_sheet.dart';
import 'package:eco_waste/features/user/trash_bank/screens/poin_exchange/product_details.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductPageScreen extends StatelessWidget {
  const ProductPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Updated to use RewardController instead of ProductController
    final RewardController rewardController = Get.put(RewardController());

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'exchangePointsAction'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Obx(
            () => badges.Badge(
              position: badges.BadgePosition.topEnd(top: -4, end: 4),
              showBadge: rewardController.itemCount > 0,
              badgeContent: Text(
                rewardController.itemCount.toString(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(milliseconds: 150),
              ),
              child: IconButton(
                icon: const Icon(Iconsax.shopping_cart),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const CartBottomSheet(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Obx(() {
          if (rewardController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final rewards = rewardController.availableRewards;

          return GridView.builder(
            itemCount: rewards.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: REYSizes.gridViewSpacing,
              mainAxisSpacing: REYSizes.gridViewSpacing,
              mainAxisExtent: 262,
            ),
            itemBuilder: (_, index) {
              final reward = rewards[index];
              return ProductCard(
                name: reward.name,
                price: '${reward.pointsRequired} pts',
                imageUrl: reward.imageUrl ?? 'https://picsum.photos/400/400',
                onTap: () => Get.to(
                  () => ProductDetailsPage(
                    name: reward.name,
                    price: '${reward.pointsRequired} pts',
                    imageUrl:
                        reward.imageUrl ?? 'https://picsum.photos/400/400',
                  ),
                ),
                onAddToCart: () {
                  rewardController.addToCart(reward);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const CartBottomSheet(),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
