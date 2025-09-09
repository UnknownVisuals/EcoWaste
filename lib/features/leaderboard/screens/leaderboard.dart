import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:eco_waste/features/leaderboard/screens/widgets/leaderboard_card.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/profile.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLeaderboardScreen extends StatelessWidget {
  const UserLeaderboardScreen({super.key});

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
          'Peringkat',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(ProfileScreen()),
            child: Image.asset(REYImages.user, width: 40, height: 40),
          ),
        ],
      ),
      body: Obx(() {
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
                  Icons.leaderboard_outlined,
                  size: 64,
                  color: REYColors.grey,
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),
                Text(
                  'No leaderboard data available',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: REYColors.grey),
                ),
                const SizedBox(height: REYSizes.spaceBtwItems / 2),
                Text(
                  'Check back later or try refreshing',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: REYColors.grey),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                Column(
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
