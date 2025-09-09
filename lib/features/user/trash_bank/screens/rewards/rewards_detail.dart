import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eco_waste/features/user/trash_bank/models/rewards_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class RewardsDetail extends StatelessWidget {
  const RewardsDetail({super.key, required this.reward});

  final RewardsModel reward;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          reward.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            Text(reward.name, style: Theme.of(context).textTheme.headlineSmall),
            Row(
              children: [
                const Icon(Iconsax.coin_1, size: 16, color: REYColors.primary),
                const SizedBox(width: 4),
                Text(
                  reward.pointsRequired.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Text(
              reward.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: REYSizes.spaceBtwSections),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: reward.stock > 0
                        ? REYColors.success
                        : REYColors.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reward.stock > 0
                        ? '${'stock'.tr} ${reward.stock}'
                        : 'outOfStock'.tr,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
