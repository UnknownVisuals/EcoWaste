import 'package:eco_waste/features/authentication/controllers/onboarding_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Positioned(
      top: REYDeviceUtils.getAppBarHeight(),
      right: REYSizes.defaultSpace,
      child: TextButton(
        onPressed: controller.skipPage,
        child: Text(
          'skip'.tr,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: REYColors.primary),
        ),
      ),
    );
  }
}
