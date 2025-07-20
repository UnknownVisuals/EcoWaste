import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/history.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/widgets/history_card_list.dart';
import 'package:eco_waste/features/user/homescreen/screens/widgets/home_appbar.dart';
import 'package:eco_waste/features/user/homescreen/screens/widgets/home_card_poin.dart';
import 'package:eco_waste/features/user/homescreen/screens/widgets/home_schedule_carousel.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          REYPrimaryHeaderContainer(
            child: Column(
              children: [
                HomeAppBar(
                  username: userModel.username,
                  userId: userModel.id,
                  desaId: userModel.desaId,
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),
                HomeCardPoin(
                  username: userModel.username,
                  userId: userModel.id,
                  desaId: userModel.desaId,
                ),
                const SizedBox(height: REYSizes.spaceBtwSections * 2),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                // Schedule Carousel
                HomeScheduleCarousel(desaId: userModel.desaId),

                // History
                REYSectionHeading(
                  title: 'Riwayat',
                  showActionButton: true,
                  onPressed: () => Get.to(
                    HistoryScreen(
                      userId: userModel.id,
                      desaId: userModel.desaId,
                    ),
                  ),
                ),
                SizedBox(
                  height: REYDeviceUtils.getScreenHeight() * 0.5,
                  child: SingleChildScrollView(
                    child: HistoryCardList(userId: userModel.id),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
