import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/common/widgets/settings_menu_tile.dart';
import 'package:eco_waste/common/widgets/user_profile_tile.dart';
import 'package:eco_waste/controllers/theme_controller.dart';
import 'package:eco_waste/controllers/language_controller.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/authentication/screens/logout/logout.dart';
import 'package:eco_waste/features/user/personalization/screens/settings/address.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/deposit_only.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/history.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();

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
                  REYUserProfileTile(
                    username: userModel.name,
                    email: userModel.email,
                    desaId: userModel.tps3rId ?? '',
                  ),
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
                  REYSettingsMenuTile(
                    icon: Iconsax.receipt,
                    title: 'history'.tr,
                    subTitle: 'historySubtitle'.tr,
                    onTap: () => Get.to(
                      HistoryScreen(
                        userId: userModel.id,
                        desaId: userModel.tps3rId ?? '',
                      ),
                    ),
                  ),
                  REYSettingsMenuTile(
                    icon: Iconsax.check,
                    title: 'confirmation'.tr,
                    subTitle: 'confirmationSubtitle'.tr,
                    onTap: () => Get.to(
                      DepositOnly(
                        userId: userModel.id,
                        desaId: userModel.tps3rId ?? '',
                      ),
                    ),
                  ),
                  REYSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'address'.tr,
                    subTitle: 'addressSubtitle'.tr,
                    onTap: () =>
                        Get.to(AddressScreen(desaId: userModel.tps3rId ?? '')),
                  ),

                  // App Settings
                  const SizedBox(height: REYSizes.spaceBtwSections),
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
                      subTitle: 'Sesuaikan tampilan dengan cahaya sekitar',
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) {
                          themeController.toggleTheme(value);
                        },
                        activeColor: REYColors.primary,
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
                        activeColor: REYColors.primary,
                      ),
                    );
                  }),

                  const SizedBox(height: REYSizes.spaceBtwSections * 2),

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
