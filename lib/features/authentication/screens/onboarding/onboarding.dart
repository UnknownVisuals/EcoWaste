import 'package:eco_waste/features/authentication/controllers/onboarding_controller.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/widgets/onboarding_dot_indicator.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/widgets/onboarding_skip_button.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: REYImages.onBoardingImage1,
                title: 'onBoardingTitle1'.tr,
                subTitle: 'onBoardingSubTitle1'.tr,
              ),
              OnBoardingPage(
                image: REYImages.onBoardingImage2,
                title: 'onBoardingTitle2'.tr,
                subTitle: 'onBoardingSubTitle2'.tr,
              ),
              OnBoardingPage(
                image: REYImages.onBoardingImage3,
                title: 'onBoardingTitle3'.tr,
                subTitle: 'onBoardingSubTitle3'.tr,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkipButton(),

          // Dots Indicator
          const OnBoardingDotIndicator(),

          // Next Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
