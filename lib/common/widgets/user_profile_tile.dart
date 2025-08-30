import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/profile.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class REYUserProfileTile extends StatelessWidget {
  const REYUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    // Fetch user data if not already loaded
    if (userController.userModel.value.id.isEmpty) {
      userController.fetchCurrentUser();
    }

    return Obx(() {
      final user = userController.userModel.value;

      // Show loading state if user data is not loaded yet
      if (userController.isLoading.value || user.id.isEmpty) {
        return ListTile(
          leading: Image.asset(REYImages.user, width: 50, height: 50),
          title: Text(
            'Loading...',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: REYColors.white),
          ),
          subtitle: Text(
            'Please wait...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: REYColors.white),
          ),
          trailing: IconButton(
            onPressed: () => Get.to(ProfileScreen()),
            icon: const Icon(Iconsax.edit, color: REYColors.white),
          ),
        );
      }

      return ListTile(
        leading: user.avatar.isNotEmpty
            ? CircleAvatar(
                radius: 25,
                backgroundColor: REYColors.grey.withValues(alpha: 0.3),
                child: ClipOval(
                  child: Image.network(
                    user.avatar,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(REYImages.user, width: 50, height: 50);
                    },
                  ),
                ),
              )
            : Image.asset(REYImages.user, width: 50, height: 50),
        title: Text(
          user.name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: REYColors.white),
        ),
        subtitle: Text(
          user.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: REYColors.white),
        ),
        trailing: IconButton(
          onPressed: () => Get.to(ProfileScreen()),
          icon: const Icon(Iconsax.edit, color: REYColors.white),
        ),
      );
    });
  }
}
