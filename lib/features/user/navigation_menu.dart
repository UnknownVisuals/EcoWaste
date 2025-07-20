import 'package:eco_waste/features/user/navigation_controller.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserNavigationController(userModel: userModel));
    final dark = REYHelperFunctions.isDarkMode(context);
    Get.lazyPut(
      () => UserModel(
        id: userModel.id,
        email: userModel.email,
        username: userModel.username,
        desaId: userModel.desaId,
        poin: userModel.poin,
      ),
    );

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
          tabs: const [
            GButton(icon: Iconsax.home, text: 'Beranda'),
            GButton(icon: Iconsax.award, text: 'Peringkat'),
            GButton(icon: Iconsax.global, text: 'Berita'),
            GButton(icon: Iconsax.user, text: 'Profil'),
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
