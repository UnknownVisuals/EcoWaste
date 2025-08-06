import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_waste/common/widgets/circular_container.dart';
import 'package:eco_waste/features/user/home/controllers/home_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/schedule_controller.dart';
import 'package:eco_waste/features/user/home/screens/widgets/home_schedule_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScheduleCarousel extends StatelessWidget {
  const HomeScheduleCarousel({super.key, required this.desaId});

  final String desaId;

  @override
  Widget build(BuildContext context) {
    final UserHomeController homeController = Get.put(UserHomeController());
    final ScheduleController scheduleController = Get.put(ScheduleController());
    scheduleController.getSchedule(desaId: desaId);

    return Obx(
      () => scheduleController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(REYColors.primary),
              ),
            )
          : Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) =>
                        homeController.updatePageIndicator(index),
                  ),
                  items: scheduleController.schedule.map((schedule) {
                    String formattedWaktu = scheduleController
                        .formatScheduleTime(
                          schedule.waktuMulai,
                          schedule.waktuSelesai,
                        );

                    return DepositScheduleCard(
                      child: Padding(
                        padding: const EdgeInsets.all(REYSizes.defaultSpace),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'wasteCollection'.tr,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: REYColors.white),
                            ),
                            const SizedBox(height: REYSizes.sm),
                            Text(
                              '${schedule.hari}, $formattedWaktu WIB',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: REYColors.white),
                            ),
                            const SizedBox(height: REYSizes.sm / 2),
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.location,
                                  size: REYSizes.iconSm,
                                  color: REYColors.white,
                                ),
                                const SizedBox(width: REYSizes.sm / 2),
                                Text(
                                  schedule.desa.nama,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: REYColors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < scheduleController.schedule.length; i++)
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
