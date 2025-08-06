import 'package:eco_waste/controllers/language_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSettingsDialog extends StatelessWidget {
  const LanguageSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.find();

    return AlertDialog(
      title: Text('selectLanguage'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => RadioListTile<String>(
              title: Row(
                children: [
                  const Text('🇺🇸'),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  Text('english'.tr),
                ],
              ),
              value: 'en',
              groupValue: languageController.currentLocale.value.languageCode,
              onChanged: (value) {
                if (value != null) {
                  languageController.changeLanguage(value);
                  Get.back();
                }
              },
              activeColor: REYColors.primary,
            ),
          ),
          Obx(
            () => RadioListTile<String>(
              title: Row(
                children: [
                  const Text('🇮🇩'),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  Text('indonesian'.tr),
                ],
              ),
              value: 'id',
              groupValue: languageController.currentLocale.value.languageCode,
              onChanged: (value) {
                if (value != null) {
                  languageController.changeLanguage(value);
                  Get.back();
                }
              },
              activeColor: REYColors.primary,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('done'.tr)),
      ],
    );
  }
}
