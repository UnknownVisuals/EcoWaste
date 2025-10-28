import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/features/trash_bank/screens/rewards/widgets/rewards_redeem.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
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
    final bool dark = REYHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          reward.name,
          style: Theme.of(context).textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
        // actions: [
        //   Obx(
        //     () => REYNotificationCounter(
        //       badgeCount: rewardsController.cartItemCount,
        //       child: IconButton(
        //         icon: const Icon(Iconsax.shopping_cart),
        //         onPressed: () => RewardsCart.showCartBottomSheet(context),
        //       ),
        //     ),
        //   ),
        // ],
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
                child: reward.imageUrl != null && reward.imageUrl!.isNotEmpty
                    ? Image.network(
                        'https://api.greenappstelkom.id${reward.imageUrl}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: dark
                            ? REYColors.darkerGrey
                            : REYColors.lightGrey,
                        child: Icon(
                          Iconsax.image,
                          size: REYSizes.iconLg,
                          color: dark ? REYColors.light : REYColors.primary,
                        ),
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
                            ? (dark ? REYColors.darkerGrey : REYColors.grey)
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
                                  ? (dark
                                        ? REYColors.textWhite
                                        : REYColors.textPrimary)
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

            // Redeem Reward Button
            Obx(() {
              final bool isRedeeming = rewardsController.isRedeeming.value;
              final bool isCurrentReward =
                  rewardsController.redeemingRewardId.value == reward.id;
              final bool isDisabled = reward.stock <= 0 || isRedeeming;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isDisabled
                      ? null
                      : () async {
                          final bool? confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => RewardsRedeem(
                              rewardName: reward.name,
                              pointsRequired: reward.pointsRequired,
                            ),
                          );

                          if (confirm == true) {
                            await rewardsController.redeemRequest(
                              rewardId: reward.id,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDisabled
                        ? REYColors.grey
                        : REYColors.primary,
                  ),
                  child: isRedeeming && isCurrentReward
                      ? const SizedBox(
                          height: REYSizes.iconMd,
                          width: REYSizes.iconMd,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'redeem'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                ),
              );
            }),

            const SizedBox(height: REYSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
