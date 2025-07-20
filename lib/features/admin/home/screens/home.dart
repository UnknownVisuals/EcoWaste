import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          REYPrimaryHeaderContainer(
            child: Column(
              children: [
                REYAppBar(),
                const SizedBox(height: REYSizes.spaceBtwSections),

                const SizedBox(height: REYSizes.spaceBtwSections * 2),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(REYSizes.defaultSpace),
            child: Column(
              children: [
                // Schedule Carousel
                // HomeScheduleCarousel(desaId: userModel.desaId),

                // History
                REYSectionHeading(
                  title: 'Riwayat',
                  showActionButton: true,
                  onPressed: () {},
                ),
                SizedBox(
                  height: REYDeviceUtils.getScreenHeight() * 0.5,
                  child: SingleChildScrollView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
