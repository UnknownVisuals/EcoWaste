import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_waste/common/widgets/circular_container.dart';
import 'package:eco_waste/features/user/homescreen/controllers/home_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'deposit_tutorial_card.dart';

class DepositTutorialCarousel extends StatelessWidget {
  const DepositTutorialCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    List<Widget> items = [
      const DepositTutorialCard(
        imagePath: "assets/onboarding/onboarding_1_alt.png",
        text: 'Pilah sampah yang terkumpul!',
        // text: 'Kumpulkan dan pilah sampahmu!',
      ),
      const DepositTutorialCard(
        imagePath: "assets/onboarding/onboarding_2_alt.png",
        text: 'Catat semua jenis sampah pada aplikasi....',
        // text: 'Bawa sampahmu ke bank sampah terdekat!',
      ),
      const DepositTutorialCard(
        imagePath: "assets/onboarding/onboarding_3_alt.png",
        text: 'Saldo akan bertambah setelah dikumpulkan!',
        // text: 'Tukar sampahmu dan dapatkan poin untuk hadiah menarik!',
      ),
    ];

    return Obx(
      () => Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 4 / 3,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, _) =>
                  homeController.updatePageIndicator(index),
            ),
            items: items,
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < items.length; i++)
                REYCircularContainer(
                  width: homeController.carouselCurrentIndex.value == i
                      ? 20
                      : 16,
                  height: homeController.carouselCurrentIndex.value == i
                      ? 6
                      : 4,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  backgroundColor:
                      homeController.carouselCurrentIndex.value == i
                      ? REYColors.primary
                      : REYColors.grey,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
