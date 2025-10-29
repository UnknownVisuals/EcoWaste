import 'package:eco_waste/common/widgets/icon_button.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/screens/rewards/rewards.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/transactions.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeCardPoin extends StatelessWidget {
  const HomeCardPoin({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Obx(() {
      final user = userController.userModel.value;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: REYSizes.defaultSpace),
        decoration: BoxDecoration(
          color: REYColors.dark.withValues(alpha: 0.2),
          border: Border.all(color: REYColors.white),
          borderRadius: BorderRadius.circular(REYSizes.borderRadiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Poin Balance
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'balance'.tr,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: REYColors.white),
                  ),
                  Text(
                    REYFormatter.formatPoints(user.points),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: REYColors.white,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.coin_1,
                        size: REYSizes.iconSm,
                        color: REYColors.white,
                      ),
                      const SizedBox(width: REYSizes.sm / 2),
                      Text(
                        'points'.tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: REYColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Icon Buttons
              Row(
                children: [
                  REYIconButton(
                    icon: Iconsax.send_2,
                    title: 'depositWasteShort'.tr,
                    onPressed: () => Get.to(
                      TransactionsScreen(
                        userId: user.id,
                        locationId: user.locationId,
                      ),
                    ),
                  ),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  REYIconButton(
                    icon: Iconsax.bitcoin_convert,
                    title: 'exchangePoints'.tr,
                    onPressed: () => Get.to(const RewardsScreen()),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
