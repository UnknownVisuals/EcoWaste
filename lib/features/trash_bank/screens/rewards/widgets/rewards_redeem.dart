import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsRedeem extends StatelessWidget {
  const RewardsRedeem({
    super.key,
    required this.rewardName,
    required this.pointsRequired,
  });

  final String rewardName;
  final int pointsRequired;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(REYSizes.cardRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'redeemRewardTitle'.tr,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Text(
              'redeemRewardMessage'.trParams({
                'reward': rewardName,
                'points': REYFormatter.formatPoints(pointsRequired),
              }),
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: REYSizes.defaultSpace * 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('cancel'.tr),
                  ),
                ),
                const SizedBox(width: REYSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: REYColors.primary,
                    ),
                    child: Text('redeem'.tr),
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
