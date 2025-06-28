import 'package:eco_waste/features/authentication/controllers/onboarding_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotIndicator extends StatelessWidget {
  const OnBoardingDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());
    final dark = REYHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: REYDeviceUtils.getBottomNavigationBarHeight() + 24,
      left: REYSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? REYColors.light : REYColors.dark,
          dotHeight: 8,
        ),
      ),
    );
  }
}
