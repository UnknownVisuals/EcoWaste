import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/chip_filter.dart';
import 'package:eco_waste/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:eco_waste/features/leaderboard/screens/widgets/leaderboard_card.dart';
import 'package:eco_waste/features/personalization/screens/profile/profile.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaderboardController leaderboardController = Get.put(
      LeaderboardController(),
    );
    final LocationsController locationsController = Get.put(
      LocationsController(),
    );

    // Fetch both leaderboard and locations data
    leaderboardController.getLeaderboard();
    locationsController.fetchLocations();

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'leaderboard'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(ProfileScreen()),
            child: Image.asset(
              REYImages.user,
              width: REYSizes.iconMd,
              height: REYSizes.iconMd,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Obx(
            () => Row(
              spacing: REYSizes.spaceBtwItems,
              children: [
                const SizedBox(width: REYSizes.spaceBtwItems),
                REYChipFilter(
                  chipFilterString: 'allVillages'.tr,
                  chipFilterColor: REYColors.primary,
                  chipFilterIcon: Iconsax.global,
                  isSelected:
                      leaderboardController.selectedFilter.value ==
                      'ALL_VILLAGES',
                  onTap: () => leaderboardController.setFilter('ALL_VILLAGES'),
                ),
                REYChipFilter(
                  chipFilterString: 'myVillage'.tr,
                  chipFilterColor: REYColors.success,
                  chipFilterIcon: Iconsax.location,
                  isSelected:
                      leaderboardController.selectedFilter.value ==
                      'MY_VILLAGE',
                  onTap: () => leaderboardController.setFilter('MY_VILLAGE'),
                ),
                const SizedBox(width: REYSizes.spaceBtwItems),
              ],
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),

          // Leaderboard List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(REYSizes.defaultSpace),
              child: Obx(() {
                if (leaderboardController.isLoading.value ||
                    locationsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: REYColors.primary),
                  );
                }

                if (leaderboardController.leaderboard.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.medal_star,
                          size: REYSizes.iconLg,
                          color: REYColors.grey,
                        ),
                        const SizedBox(height: REYSizes.spaceBtwItems),
                        Text(
                          'noDataFound'.tr,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: REYColors.grey),
                        ),
                        const SizedBox(height: REYSizes.spaceBtwItems / 2),
                        Text(
                          'trySelectingDifferentFilter'.tr,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: REYColors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: leaderboardController.leaderboard
                      .asMap()
                      .entries
                      .map((entry) {
                        int index = entry.key;
                        var leaderboardItem = entry.value;
                        Color? color;

                        if (index == 0) {
                          color = REYColors.firstPodium;
                        } else if (index == 1) {
                          color = REYColors.secondPodium;
                        } else if (index == 2) {
                          color = REYColors.thirdPodium;
                        }

                        return LeaderboardCard(
                          color: color,
                          leaderboardItem: leaderboardItem,
                          rank: index + 1,
                        );
                      })
                      .toList(),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
