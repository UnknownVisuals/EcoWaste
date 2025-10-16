import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/common/widgets/settings_menu_tile.dart';
import 'package:eco_waste/common/widgets/user_profile_tile.dart';
import 'package:eco_waste/controllers/theme_controller.dart';
import 'package:eco_waste/controllers/language_controller.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/screens/logout/logout.dart';
import 'package:eco_waste/features/authentication/screens/signup/signup.dart';
import 'package:eco_waste/features/personalization/screens/settings/address.dart';
import 'package:eco_waste/features/personalization/screens/settings/user_list.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/transactions_history.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();
    final UserController userController = Get.find();
    final user = userController.userModel.value;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            REYPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  REYAppBar(
                    showBackArrow: false,
                    title: Text(
                      'account'.tr,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: REYColors.white),
                    ),
                  ),

                  // Profile Card
                  REYUserProfileTile(),
                  const SizedBox(height: REYSizes.spaceBtwSections),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(REYSizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  REYSectionHeading(
                    title: 'accountSettings'.tr,
                    showActionButton: false,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  if (user.role == 'PETUGAS')
                    REYSettingsMenuTile(
                      icon: Iconsax.user_add,
                      title: 'createAccount'.tr,
                      subTitle: 'signupTitle'.tr,
                      onTap: () => Get.to(SignupScreen()),
                    ),
                  if (user.role == 'PETUGAS')
                    REYSettingsMenuTile(
                      icon: Iconsax.profile_2user,
                      title: 'users'.tr,
                      subTitle: 'userManagement'.tr,
                      onTap: () => Get.to(UserListScreen()),
                    ),
                  REYSettingsMenuTile(
                    icon: Iconsax.receipt,
                    title: 'transactionHistory'.tr,
                    subTitle: 'historySubtitle'.tr,
                    onTap: () => Get.to(TransactionsHistoryScreen()),
                  ),
                  REYSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'address'.tr,
                    subTitle: 'addressSubtitle'.tr,
                    onTap: () => Get.to(AddressScreen()),
                  ),
                  const SizedBox(height: REYSizes.spaceBtwSections),

                  // App Settings
                  REYSectionHeading(
                    title: 'appSettings'.tr,
                    showActionButton: false,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Obx(() {
                    bool isDark = themeController.isDarkMode.value;

                    return REYSettingsMenuTile(
                      icon: Iconsax.moon,
                      title: 'darkMode'.tr,
                      subTitle: 'adjustDisplayAmbientLighting'.tr,
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) {
                          themeController.toggleTheme(value);
                        },
                        activeThumbColor: REYColors.primary,
                      ),
                    );
                  }),

                  Obx(() {
                    bool isEnglish = languageController.isEnglish;

                    return REYSettingsMenuTile(
                      icon: Iconsax.language_circle,
                      title: 'language'.tr,
                      subTitle: isEnglish ? 'english'.tr : 'indonesian'.tr,
                      trailing: Switch(
                        value: isEnglish,
                        onChanged: (value) {
                          languageController.changeLanguage(
                            value ? 'en' : 'id',
                          );
                        },
                        activeThumbColor: REYColors.primary,
                      ),
                    );
                  }),

                  const SizedBox(height: REYSizes.spaceBtwSections),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const LogoutScreen();
                          },
                        );
                      },
                      child: Text('logout'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
