import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/circular_image.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:eco_waste/common/widgets/image_picker_bottom_sheet.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/controllers/camera_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final LocationsController locationsController = Get.put(
      LocationsController(),
    );
    final CameraController cameraController = Get.put(CameraController());

    if (userController.userModel.value.id.isEmpty) {
      userController.fetchCurrentUser();
    }

    if (locationsController.locations.isEmpty) {
      locationsController.fetchLocations();
    }

    return Scaffold(
      appBar: REYAppBar(showBackArrow: true, title: Text('profile'.tr)),
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
                      Obx(() {
                        // Check if user has selected a new image
                        if (cameraController.selectedImage.value != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              cameraController.selectedImage.value!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        // Show existing avatar or default
                        else if (user.avatar.isNotEmpty) {
                          return REYCircularImage(
                            image: user.avatar,
                            width: 100,
                            height: 100,
                            isNetworkImage: true,
                          );
                        }
                        // Show default avatar
                        else {
                          return const REYCircularImage(
                            image: REYImages.user,
                            width: 100,
                            height: 100,
                          );
                        }
                      }),
                      TextButton(
                        onPressed: () =>
                            REYImagePickerBottomSheet.show(context: context),
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
                REYSectionHeading(title: 'profileInformation'.tr),
                const SizedBox(height: REYSizes.spaceBtwItems),

                ProfileMenu(
                  title: 'name'.tr,
                  value: user.name,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'email'.tr,
                  value: user.email,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'rtRw'.tr,
                  value: user.rt.isEmpty && user.rw.isEmpty
                      ? '--/--'
                      : '${user.rt.isEmpty ? '--' : user.rt}/${user.rw.isEmpty ? '--' : user.rw}',
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'village'.tr,
                  value: location?.desa ?? 'unknown'.tr,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'district'.tr,
                  value: location?.kecamatan ?? 'unknown'.tr,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'kabupatenKota'.tr,
                  value: location?.kabupaten ?? 'unknown'.tr,
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
