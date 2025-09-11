import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/notification_menu_icon.dart';
import 'package:eco_waste/features/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/features/trash_bank/screens/rewards/widgets/rewards_cart.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eco_waste/features/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class RewardsDetail extends StatelessWidget {
  const RewardsDetail({super.key, required this.reward});

  final RewardsModel reward;

  @override
  Widget build(BuildContext context) {
    final RewardsController rewardsController = Get.find<RewardsController>();

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          reward.name,
          style: Theme.of(context).textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Obx(
            () => REYNotificationCounter(
              badgeCount: rewardsController.cartItemCount,
              child: IconButton(
                icon: const Icon(Iconsax.shopping_cart),
                onPressed: () => RewardsCart.showCartBottomSheet(context),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Reward Image
            ClipRRect(
              borderRadius: BorderRadius.circular(REYSizes.cardRadiusLg),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  "https://greenappstelkom.id/generic-reward-image.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            // Reward Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    reward.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.coin_1,
                          size: REYSizes.iconSm,
                          color: REYColors.primary,
                        ),
                        const SizedBox(width: REYSizes.spaceBtwItems / 4),
                        Text(
                          reward.pointsRequired.toString(),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: REYSizes.spaceBtwItems / 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: REYSizes.sm,
                        vertical: REYSizes.xs,
                      ),
                      decoration: BoxDecoration(
                        color: reward.stock > 0
                            ? REYColors.grey
                            : REYColors.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        reward.stock > 0
                            ? '${'stock'.tr} ${reward.stock}'
                            : 'outOfStock'.tr,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: reward.stock > 0
                                  ? REYColors.textPrimary
                                  : REYColors.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: REYSizes.spaceBtwItems),

            Text(
              reward.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),

            const Spacer(),

            // Add to Cart Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: rewardsController.isInCart(reward)
                    ? OutlinedButton(
                        onPressed: null,
                        child: Text(
                          'alreadyInCart'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: reward.stock > 0
                            ? () => rewardsController.addToCart(reward)
                            : null,
                        child: Text(
                          'addToCart'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: reward.stock > 0 ? Colors.white : null,
                              ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: REYSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
