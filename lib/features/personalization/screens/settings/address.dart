import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/personalization/controllers/address_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());
    final location = addressController.getCurrentLocation();

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'address'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        if (location == null) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Location Icon
                const Icon(
                  Iconsax.location,
                  color: REYColors.primary,
                  size: REYSizes.iconLg * 2,
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),

                // Title
                Text(
                  'collectWasteAt'.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: REYSizes.spaceBtwItems),

                // Full Address
                Text(
                  '${location.desa}, ${location.kecamatan}, ${location.kabupaten}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: REYSizes.spaceBtwSections),

                // Map Preview
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      REYSizes.borderRadiusLg,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: addressController.isLoadingLocation.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: REYColors.primary,
                          ),
                        )
                      : FlutterMap(
                          options: MapOptions(
                            initialCenter:
                                addressController.locationCoordinates.value ??
                                const LatLng(-6.9175, 107.6191),
                            initialZoom: 16.0,
                            minZoom: 3.0,
                            maxZoom: 19.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                              userAgentPackageName: 'com.ecowaste.app',
                              maxZoom: 20,
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point:
                                      addressController
                                          .locationCoordinates
                                          .value ??
                                      const LatLng(-6.9175, 107.6191),
                                  width: 50,
                                  height: 70,
                                  // alignment: Alignment.topCenter,
                                  child: const Icon(
                                    Icons.location_on,
                                    size: REYSizes.iconLg,
                                    color: REYColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
