import 'package:eco_waste/features/user/personalization/screens/profile/profile.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class REYUserProfileTile extends StatelessWidget {
  const REYUserProfileTile({
    super.key,
    required this.username,
    required this.email,
    required this.desaId,
  });

  final String username, email, desaId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(REYImages.user, width: 50, height: 50),
      title: Text(
        username,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.apply(color: REYColors.white),
      ),
      subtitle: Text(
        email,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: REYColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(
          ProfileScreen(username: username, email: email, desaId: desaId),
        ),
        icon: const Icon(Iconsax.edit, color: REYColors.white),
      ),
    );
  }
}
