import 'package:eco_waste/controllers/camera_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class REYImagePickerBottomSheet extends StatelessWidget {
  const REYImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraController cameraController = Get.put(CameraController());

    return Container(
      padding: const EdgeInsets.all(REYSizes.defaultSpace),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text('selectImage'.tr, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: REYSizes.spaceBtwSections),

          // Camera Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await cameraController.captureImageWithCamera();
              },
              icon: const Icon(Iconsax.camera),
              label: Text(
                'takeFromCamera'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),

          // Gallery Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await cameraController.pickImageFromGallery();
              },
              icon: const Icon(Iconsax.gallery),
              label: Text(
                'selectFromGallery'.tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwSections),
        ],
      ),
    );
  }

  /// Static method to show the bottom sheet
  static void show({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const REYImagePickerBottomSheet();
      },
    );
  }
}
