import 'package:eco_waste/features/trash_bank/controllers/rewards_controller.dart';
import 'package:eco_waste/features/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/features/trash_bank/screens/rewards/widgets/rewards_redeem.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({
    super.key,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.stock,
    this.image,
    this.onTap,
    this.reward,
  });

  final String name;
  final String description;
  final int pointsRequired;
  final int stock;
  final String? image;
  final VoidCallback? onTap;
  final RewardsModel? reward;

  @override
  Widget build(BuildContext context) {
    final bool dark = REYHelperFunctions.isDarkMode(context);
    final RewardsController rewardsController = Get.find<RewardsController>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: dark ? REYColors.dark : REYColors.light,
          borderRadius: BorderRadius.circular(REYSizes.productImageRadius),
          border: Border.all(
            color: dark ? REYColors.darkerGrey : REYColors.grey,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Reward Image
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  REYSizes.productImageRadius,
                ),
                child: image != null && image!.isNotEmpty
                    ? Image.network(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Container(
                        color: dark
                            ? REYColors.darkerGrey
                            : REYColors.lightGrey,
                        child: Icon(
                          Iconsax.image,
                          color: REYColors.primary,
                          size: REYSizes.iconLg,
                        ),
                      ),
              ),
            ),

            // Reward Details
            Padding(
              padding: const EdgeInsets.all(REYSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: REYSizes.spaceBtwItems),

                  // Row with Points/Stock Column and Add to Cart Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Column: Points and Stock
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Points
                          Row(
                            children: [
                              const Icon(
                                Iconsax.coin_1,
                                size: REYSizes.iconSm,
                                color: REYColors.primary,
                              ),
                              const SizedBox(width: REYSizes.xs),
                              Text(
                                pointsRequired.toString(),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: REYSizes.xs),

                          // Stock
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: REYSizes.sm,
                              vertical: REYSizes.xs,
                            ),
                            decoration: BoxDecoration(
                              color: stock > 0
                                  ? (dark
                                        ? REYColors.darkerGrey
                                        : REYColors.grey)
                                  : REYColors.error,
                              borderRadius: BorderRadius.circular(
                                REYSizes.borderRadiusMd,
                              ),
                            ),
                            child: Text(
                              stock > 0
                                  ? '${'stock'.tr} $stock'
                                  : 'outOfStock'.tr,
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: stock > 0
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

                      // Right: Add to Cart Plus Icon
                      if (reward != null)
                        Obx(() {
                          final bool isRedeeming =
                              rewardsController.isRedeeming.value;
                          final bool isCurrentReward =
                              rewardsController.redeemingRewardId.value ==
                              reward!.id;
                          final bool isDisabled = stock <= 0 || isRedeeming;

                          return GestureDetector(
                            onTap: isDisabled
                                ? null
                                : () async {
                                    final bool? confirm =
                                        await showDialog<bool>(
                                          context: context,
                                          builder: (_) => RewardsRedeem(
                                            rewardName: reward!.name,
                                            pointsRequired:
                                                reward!.pointsRequired,
                                          ),
                                        );

                                    if (confirm == true) {
                                      await rewardsController.redeemRequest(
                                        rewardId: reward!.id,
                                      );
                                    }
                                  },
                            child: Container(
                              padding: const EdgeInsets.all(REYSizes.md / 1.5),
                              decoration: BoxDecoration(
                                color: isDisabled
                                    ? REYColors.grey
                                    : REYColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(REYSizes.md),
                                  topRight: Radius.circular(REYSizes.xs),
                                  bottomLeft: Radius.circular(REYSizes.xs),
                                  bottomRight: Radius.circular(REYSizes.md),
                                ),
                              ),
                              child: isRedeeming && isCurrentReward
                                  ? const SizedBox(
                                      width: REYSizes.iconMd,
                                      height: REYSizes.iconMd,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : Icon(
                                      Iconsax.ticket,
                                      size: REYSizes.iconMd,
                                      color: Colors.white,
                                    ),
                            ),
                          );
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
