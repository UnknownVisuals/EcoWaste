import 'package:eco_waste/common/widgets/primary_header_container.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/transactions_history.dart';
import 'package:eco_waste/features/trash_bank/screens/home/widgets/home_appbar.dart';
import 'package:eco_waste/features/trash_bank/screens/home/widgets/home_card_poin.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/widgets/transactions_history_list_preview.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          REYPrimaryHeaderContainer(
            child: Column(
              children: [
                UserHomeAppBar(),
                const SizedBox(height: REYSizes.spaceBtwSections),
                HomeCardPoin(),
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
                // HomeScheduleCarousel(desaId: user.locationId),

                // History
                REYSectionHeading(
                  title: 'transactions'.tr,
                  showActionButton: true,
                  onPressed: () => Get.to(TransactionsHistoryScreen()),
                ),
                SizedBox(
                  height: REYDeviceUtils.getScreenHeight() * 0.5,
                  child: SingleChildScrollView(
                    child: TransactionHistoryListPreview(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
