import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RewardsCart extends StatelessWidget {
  const RewardsCart({super.key});

  /// Static method to show the cart as a bottom sheet
  static void showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(REYSizes.cardRadiusLg),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: const RewardsCart(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RewardsController rewardsController = Get.find<RewardsController>();

    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Obx(() {
        final cartRewards = rewardsController.cartRewards;

        // If cart is empty, show empty state
        if (cartRewards.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: REYSizes.spaceBtwSections),
              const Icon(
                Iconsax.shopping_cart,
                size: REYSizes.iconLg * 2,
                color: Colors.grey,
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),
              Text(
                'cartEmpty'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'addToCartMessage'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),
            ],
          );
        }

        // If cart has items, show the list
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            REYSectionHeading(
              title: 'yourCart'.tr,
              showActionButton: true,
              buttonTitle: 'remove'.tr,
              onPressed: () => rewardsController.clearCart(),
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartRewards.length,
                itemBuilder: (context, index) {
                  final reward = cartRewards[index];

                  return ListTile(
                    title: Text(
                      reward.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Iconsax.coin_1,
                          size: REYSizes.iconSm,
                          color: REYColors.primary,
                        ),
                        const SizedBox(width: REYSizes.xs),
                        Text(
                          reward.pointsRequired.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () => rewardsController.removeFromCart(reward),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: REYSizes.spaceBtwItems / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalItems'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${cartRewards.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'points'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  rewardsController.totalCartPoints.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const SizedBox(height: REYSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: REYSizes.spaceBtwSections),

            ElevatedButton(
              onPressed: () {
                Get.back();
                REYLoaders.errorSnackBar(
                  title: 'checkout'.tr,
                  message: 'checkoutNotImplemented'.tr,
                );
              },
              child: Text('checkout'.tr),
            ),

            const SizedBox(height: REYSizes.spaceBtwSections),
          ],
        );
      }),
    );
  }
}
