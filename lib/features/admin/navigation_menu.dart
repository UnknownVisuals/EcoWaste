import 'package:eco_waste/features/admin/navigation_controller.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController(userModel: userModel));
    final dark = REYHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => GNav(
          selectedIndex: controller.selectedIndex.value,
          onTabChange: (index) => controller.selectedIndex.value = index,
          haptic: true,
          gap: 8,
          iconSize: 24,
          tabBorderRadius: 100,
          duration: const Duration(milliseconds: 300),
          color: dark ? REYColors.white : REYColors.darkGrey,
          backgroundColor: dark ? REYColors.black : REYColors.white,
          activeColor: REYColors.primary,
          hoverColor: REYColors.primary.withValues(alpha: 0.2),
          rippleColor: REYColors.primary.withValues(alpha: 0.2),
          tabBackgroundColor: REYColors.primary.withValues(alpha: 0.1),
          tabs: [
            GButton(icon: Iconsax.home, text: 'home'.tr),
            GButton(icon: Iconsax.award, text: 'leaderboard'.tr),
            GButton(icon: Iconsax.global, text: 'news'.tr),
            GButton(icon: Iconsax.user, text: 'profile'.tr),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
    );
  }
}
