import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/history/admin_history.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/history/widgets/admin_history_card_list.dart';
import 'package:eco_waste/features/admin/home/screens/widgets/admin_home_appbar.dart';
import 'package:eco_waste/features/admin/home/screens/widgets/admin_home_card_poin.dart';
import 'package:eco_waste/features/admin/home/screens/widgets/admin_home_schedule_carousel.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header - Same structure as WARGA but admin content
          REYPrimaryHeaderContainer(
            child: Column(
              children: [
                AdminHomeAppBar(
                  username: userModel.name,
                  userId: userModel.id,
                  desaId: userModel.tps3rId ?? '',
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),
                AdminHomeCardPoin(
                  username: userModel.name,
                  userId: userModel.id,
                  desaId: userModel.tps3rId ?? '',
                ),
                const SizedBox(height: REYSizes.spaceBtwSections * 2),
              ],
            ),
          ),

          // Body - Same structure as WARGA but admin content
          Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                // Schedule Carousel for admin input
                AdminHomeScheduleCarousel(desaId: userModel.tps3rId ?? ''),

                // History - Shows ALL users in the desa
                REYSectionHeading(
                  title: 'history'.tr,
                  showActionButton: true,
                  onPressed: () => Get.to(
                    AdminHistoryScreen(
                      userId: userModel.id, // admin user id
                      desaId:
                          userModel.tps3rId ??
                          '', // will show all users in this desa
                    ),
                  ),
                ),
                SizedBox(
                  height: REYDeviceUtils.getScreenHeight() * 0.5,
                  child: SingleChildScrollView(
                    child: AdminHistoryCardList(
                      desaId: userModel.tps3rId ?? '',
                    ), // Show all users
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
