import 'package:eco_waste/common/widgets/icon_button.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/deposit_asus/deposit_asus.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/poin_exchange/product_page.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminHomeCardPoin extends StatelessWidget {
  const AdminHomeCardPoin({
    super.key,
    required this.username,
    required this.userId,
    required this.desaId,
  });

  final String username, userId, desaId;

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    userController.refreshUserData();

    return Obx(() {
      final poin = userController.userModel.value.points;

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
              // Admin Points Balance
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'balance'.tr, // Admin balance
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: REYColors.white),
                  ),
                  Text(
                    '$poin ${'points'.tr}',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: REYColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Admin Action Buttons
              Row(
                children: [
                  REYIconButton(
                    icon: Iconsax.add,
                    title: 'depositWasteShort'.tr, // Admin inputs trash
                    onPressed: () => Get.to(
                      DepositAsusScreen(
                        username: username,
                        userId: userId,
                        desaId: desaId,
                      ),
                    ),
                  ),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  REYIconButton(
                    icon: Iconsax.bitcoin_convert,
                    title: 'exchangePoints'.tr,
                    onPressed: () => Get.to(const ProductPageScreen()),
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
