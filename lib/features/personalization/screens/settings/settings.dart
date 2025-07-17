import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/common/widgets/settings_menu_tile.dart';
import 'package:eco_waste/common/widgets/user_profile_tile.dart';
import 'package:eco_waste/controllers/theme_controller.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/authentication/screens/logout/logout.dart';
import 'package:eco_waste/features/personalization/screens/settings/address.dart';
import 'package:eco_waste/features/trash_bank/screens/deposit/deposit_only.dart';
import 'package:eco_waste/features/trash_bank/screens/history/history.dart';
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
                      'Akun',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: REYColors.white),
                    ),
                  ),

                  // Profile Card
                  REYUserProfileTile(
                    username: userModel.username,
                    email: userModel.email,
                    desaId: userModel.desaId,
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
                  const REYSectionHeading(
                    title: 'Pengaturan Akun',
                    showActionButton: false,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  REYSettingsMenuTile(
                    icon: Iconsax.receipt,
                    title: 'Riwayat',
                    subTitle: 'Lihat riwayat setor sampah',
                    onTap: () => Get.to(
                      HistoryScreen(
                        userId: userModel.id,
                        desaId: userModel.desaId,
                      ),
                    ),
                  ),
                  REYSettingsMenuTile(
                    icon: Iconsax.check,
                    title: 'Konfirmasi',
                    subTitle: 'Konfirmasi setor sampah',
                    onTap: () => Get.to(
                      DepositOnly(
                        userId: userModel.id,
                        desaId: userModel.desaId,
                      ),
                    ),
                  ),
                  REYSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Alamat Setor',
                    subTitle: 'Lihat alamat tempat setor sampah',
                    onTap: () =>
                        Get.to(AddressScreen(desaId: userModel.desaId)),
                  ),

                  // App Settings
                  const SizedBox(height: REYSizes.spaceBtwSections),
                  const REYSectionHeading(
                    title: 'Pengaturan Aplikasi',
                    showActionButton: false,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Obx(() {
                    bool isDark = themeController.isDarkMode.value;

                    return REYSettingsMenuTile(
                      icon: Iconsax.moon,
                      title: 'Mode Gelap',
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
                      child: const Text('Logout'),
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
