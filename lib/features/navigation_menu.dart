import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/features/navigation_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    final userController = Get.find<UserController>();
    final dark = REYHelperFunctions.isDarkMode(context);

    // Listen to user authentication state
    return Obx(() {
      // Wait for UserController to complete its initial session check
      if (!userController.isInitialized.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          ),
        );
      }

      final storage = REYLocalStorage();
      final rememberMe = storage.readData<bool>('rememberMe') ?? false;

      // If remember me is false, redirect to login
      if (!rememberMe) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => const LoginScreen());
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          ),
        );
      }

      // If session is invalid, redirect to login
      if (!userController.isSessionValid.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => const LoginScreen());
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          ),
        );
      }

      // If user is loading (fetching current user), show loading
      if (userController.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          ),
        );
      }

      // If we still don't have user data after loading, redirect to login
      if (userController.userModel.value.id.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => const LoginScreen());
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          ),
        );
      }

      return Scaffold(
        bottomNavigationBar: Obx(
          () => GNav(
            selectedIndex: navigationController.selectedIndex.value,
            onTabChange: (index) =>
                navigationController.selectedIndex.value = index,
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
            index: navigationController.selectedIndex.value,
            children: navigationController.screens,
          ),
        ),
      );
    });
  }
}
