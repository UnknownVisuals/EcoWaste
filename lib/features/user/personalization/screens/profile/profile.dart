import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/circular_image.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final LocationsController locationsController = Get.put(
      LocationsController(),
    );

    // Fetch user data if not already loaded
    if (userController.userModel.value.id.isEmpty) {
      userController.fetchCurrentUser();
    }

    // Fetch locations if not already loaded
    if (locationsController.locations.isEmpty) {
      locationsController.fetchLocations();
    }

    return Scaffold(
      appBar: const REYAppBar(showBackArrow: true, title: Text('Profil')),
      body: Obx(() {
        final user = userController.userModel.value;

        // Show loading state
        if (userController.isLoading.value ||
            locationsController.isLoading.value ||
            user.id.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        // Find location
        final location = locationsController.getLocationById(user.locationId);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                // Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      user.avatar.isNotEmpty
                          ? REYCircularImage(
                              image: user.avatar,
                              width: 100,
                              height: 100,
                              isNetworkImage: true,
                            )
                          : const REYCircularImage(
                              image: REYImages.user,
                              width: 100,
                              height: 100,
                            ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ubah gambar profil',
                          style: TextStyle(color: REYColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                const SizedBox(height: REYSizes.spaceBtwSections / 2),
                const Divider(),
                const SizedBox(height: REYSizes.spaceBtwSections),

                // Profile Info
                const REYSectionHeading(title: 'Informasi profil'),
                const SizedBox(height: REYSizes.spaceBtwItems),

                ProfileMenu(title: 'Nama', value: user.name, onPressed: () {}),
                ProfileMenu(
                  title: 'Email',
                  value: user.email,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Desa',
                  value: location?.desa ?? 'Unknown',
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Kecamatan',
                  value: location?.kecamatan ?? 'Unknown',
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'Kabupaten/Kota',
                  value: location?.kabupaten ?? 'Unknown',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
