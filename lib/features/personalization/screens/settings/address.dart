import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final user = userController.userModel.value;

    final LocationsController locationsController = Get.put(
      LocationsController(),
    );

    final location = locationsController.locations.firstWhere(
      (location) => location.id == user.locationId,
    );

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'address'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.location,
                color: REYColors.primary,
                size: REYSizes.iconLg * 2,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'collectWasteAt'.tr,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                '${location.desa}, ${location.kecamatan}, ${location.kabupaten}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
