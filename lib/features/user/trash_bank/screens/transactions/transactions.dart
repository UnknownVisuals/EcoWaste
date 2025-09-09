import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/section_heading.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/transactions_history.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_input.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_tutorial_carousel.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({
    super.key,
    required this.userId,
    required this.locationId,
  });

  final String userId, locationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'depositWaste'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          children: [
            // Tutorial Carousel
            const DepositTutorialCarousel(),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Transactions List
            REYSectionHeading(
              title: 'transactions'.tr,
              showActionButton: true,
              onPressed: () => Get.to(TransactionsHistoryScreen()),
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            TransactionsInput(userId: userId, locationId: locationId),
          ],
        ),
      ),
    );
  }
}
