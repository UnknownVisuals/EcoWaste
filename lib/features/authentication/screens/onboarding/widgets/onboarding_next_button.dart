import 'package:eco_waste/features/authentication/controllers/onboarding_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Positioned(
      right: REYSizes.defaultSpace,
      bottom: REYDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: controller.nextPage,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: REYColors.primary,
        ),
        child: const Icon(Iconsax.arrow_right_3, color: REYColors.white),
      ),
    );
  }
}
