import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/leaderboard/controllers/leaderboard_controller.dart';
import 'package:eco_waste/features/user/leaderboard/screens/widgets/leaderboard_card.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/profile.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final LeaderboardController leaderboardController = Get.put(
      LeaderboardController(),
    );

    leaderboardController.getLeaderboard();

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'Peringkat',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(
              ProfileScreen(
                username: userModel.username,
                email: userModel.email,
                desaId: userModel.desaId,
              ),
            ),
            child: Image.asset(REYImages.user, width: 40, height: 40),
          ),
        ],
      ),
      body: Obx(() {
        if (leaderboardController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        if (leaderboardController.leaderboard.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                Column(
                  children: leaderboardController.leaderboard.asMap().entries.map((
                    entry,
                  ) {
                    var item = entry.value;
                    int index = entry.key;
                    Color? color;

                    if (index == 0) {
                      color = REYColors.firstPodium;
                    } else if (index == 1) {
                      color = REYColors.secondPodium;
                    } else if (index == 2) {
                      color = REYColors.thirdPodium;
                    }

                    return LeaderboardCard(
                      username: item.user.username,
                      jumlahPengumpulan:
                          '${item.jumlahPengumpulan.toString().padLeft(2, '0')} kali pengumpulan',
                      totalPoin: item.totalPoin.toString(),
                      color: color,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
