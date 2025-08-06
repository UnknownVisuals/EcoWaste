import 'package:eco_waste/features/user/trash_bank/controllers/deposit_asus_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DepositImageBottomSheet extends StatelessWidget {
  const DepositImageBottomSheet({
    super.key,
    required this.depositAsusController,
  });

  final DepositAsusController depositAsusController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () async {
              Get.back();
              await depositAsusController.pickImageFromGallery();
            },
            child: Row(
              children: [
                const Icon(Iconsax.image),
                const SizedBox(width: REYSizes.spaceBtwItems),
                Text(
                  'Pilih dari Galeri',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),
          OutlinedButton(
            onPressed: () async {
              Get.back();
              await depositAsusController.captureImageWithCamera();
            },
            child: Row(
              children: [
                const Icon(Iconsax.camera),
                const SizedBox(width: REYSizes.spaceBtwItems),
                Text(
                  'takePhoto'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
