import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RewardsCart extends StatelessWidget {
  const RewardsCart({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardsController rewardsController = Get.find<RewardsController>();

    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Obx(() {
        // For demonstration, let's assume rewardsController has a cartRewards RxList<RewardsModel> for cart items
        final cartRewards = rewardsController.rewards
            .where((r) => r.stock > 0)
            .toList(); // Replace with actual cart logic
        if (cartRewards.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: REYSizes.spaceBtwSections),
              const Icon(
                Iconsax.shopping_cart,
                size: REYSizes.iconLg * 2,
                color: Colors.grey,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
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
              const SizedBox(height: REYSizes.spaceBtwSections * 2),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            REYSectionHeading(title: 'yourCart'.tr, showActionButton: false),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartRewards.length,
                itemBuilder: (context, index) {
                  final reward = cartRewards[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        REYSizes.cardRadiusMd,
                      ),
                      child: Image.network(
                        reward.icon,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      reward.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      '${reward.pointsRequired} poin',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () {
                        /* Remove from cart logic here */
                      },
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
                  cartRewards
                      .fold<int>(0, (sum, r) => sum + r.pointsRequired)
                      .toString(),
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
            const SizedBox(height: REYSizes.spaceBtwSections * 2),
          ],
        );
      }),
    );
  }
}
