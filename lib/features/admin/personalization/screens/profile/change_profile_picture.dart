import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeProfilePictureScreen extends StatelessWidget {
  const ChangeProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const REYAppBar(
        showBackArrow: true,
        title: Text('Change Profile Picture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: REYSizes.spaceBtwSections),

            Text(
              'Choose how you\'d like to update your profile picture',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: REYSizes.spaceBtwSections * 2),

            // Camera Option
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: REYSizes.spaceBtwItems),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement camera functionality
                  Get.snackbar(
                    'Camera',
                    'Camera functionality will be implemented soon!',
                    backgroundColor: REYColors.primary,
                    colorText: Colors.white,
                  );
                  Get.back();
                },
                icon: const Icon(Iconsax.camera),
                label: const Text('Take Photo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: REYSizes.md),
                ),
              ),
            ),

            // Gallery Option
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: REYSizes.spaceBtwItems),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement gallery functionality
                  Get.snackbar(
                    'Gallery',
                    'Gallery functionality will be implemented soon!',
                    backgroundColor: REYColors.primary,
                    colorText: Colors.white,
                  );
                  Get.back();
                },
                icon: const Icon(Iconsax.gallery),
                label: const Text('Choose from Gallery'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: REYSizes.md),
                ),
              ),
            ),

            // Remove Photo Option
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    'Profile Picture',
                    'Profile picture removed successfully!',
                    backgroundColor: REYColors.primary,
                    colorText: Colors.white,
                  );
                  Get.back();
                },
                icon: const Icon(Iconsax.trash, color: Colors.red),
                label: const Text(
                  'Remove Current Photo',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: REYSizes.md),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
