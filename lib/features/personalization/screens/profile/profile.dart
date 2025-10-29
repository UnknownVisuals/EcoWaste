import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/circular_image.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:eco_waste/common/widgets/image_picker_bottom_sheet.dart';
import 'package:eco_waste/common/widgets/image_preview_dialog.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/controllers/camera_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
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
                // Profile Picture Section
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Profile Picture with Camera Icon
                      Obx(() {
                        Widget profileImage;

                        // Check if user has selected a new image
                        if (cameraController.selectedImage.value != null) {
                          profileImage = ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              cameraController.selectedImage.value!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        // Show existing avatar or default
                        else if (user.avatar.isNotEmpty) {
                          profileImage = REYCircularImage(
                            image: user.avatar,
                            width: 120,
                            height: 120,
                            isNetworkImage: true,
                          );
                        }
                        // Show default avatar
                        else {
                          profileImage = const REYCircularImage(
                            image: REYImages.user,
                            width: 120,
                            height: 120,
                          );
                        }

                        return Stack(
                          children: [
                            // Profile Image with Tap to Preview
                            GestureDetector(
                              onTap: () {
                                // Preview the image
                                if (cameraController.selectedImage.value !=
                                    null) {
                                  REYImagePreviewDialog.showFile(
                                    context: context,
                                    imageFile:
                                        cameraController.selectedImage.value!,
                                  );
                                } else if (user.avatar.isNotEmpty) {
                                  REYImagePreviewDialog.showData(
                                    context: context,
                                    imageData: user.avatar,
                                  );
                                }
                              },
                              child: profileImage,
                            ),
                            // Camera Icon Button
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () => REYImagePickerBottomSheet.show(
                                  context: context,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(REYSizes.xs),
                                  decoration: BoxDecoration(
                                    color: REYColors.success,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).scaffoldBackgroundColor,
                                      width: 3,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: REYColors.white,
                                    size: REYSizes.iconMd,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(height: REYSizes.spaceBtwItems),

                      // User Name
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: REYSizes.spaceBtwItems / 2),

                      // Points Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: REYSizes.md,
                          vertical: REYSizes.xs,
                        ),
                        decoration: BoxDecoration(
                          color: REYColors.success,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${REYFormatter.formatPoints(user.points)} ${'points'.tr}',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: REYColors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
                  title: 'email'.tr,
                  value: user.email,
                  onPressed: () {},
                ),
                ProfileMenu(
                  title: 'role'.tr,
                  value: user.role,
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
