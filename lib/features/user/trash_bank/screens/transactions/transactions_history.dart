import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/chip_filter.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_history_card_list.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TransactionsHistoryScreen extends StatelessWidget {
  const TransactionsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );
    final UserController userController = Get.find<UserController>();

    // Fetch transactions when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (transactionController.transactions.isEmpty) {
        final userId = userController.userModel.value.id;
        if (userId.isNotEmpty) {
          transactionController.fetchTransactions(userId: userId);
        }
      }
    });

    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'transactions'.tr,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: REYSizes.spaceBtwItems,
                children: [
                  const SizedBox(width: REYSizes.spaceBtwItems),
                  REYChipFilter(
                    chipFilterString: 'all'.tr,
                    chipFilterColor: REYColors.primary,
                    chipFilterIcon: Iconsax.filter,
                    isSelected:
                        transactionController.selectedFilter.value == 'ALL',
                    onTap: () => transactionController.setFilter('ALL'),
                  ),
                  REYChipFilter(
                    chipFilterString: 'confirmed'.tr,
                    chipFilterColor: REYColors.success,
                    chipFilterIcon: Iconsax.tick_square,
                    isSelected:
                        transactionController.selectedFilter.value ==
                        'CONFIRMED',
                    onTap: () => transactionController.setFilter('CONFIRMED'),
                  ),
                  REYChipFilter(
                    chipFilterString: 'pending'.tr,
                    chipFilterColor: REYColors.warning,
                    chipFilterIcon: Iconsax.warning_2,
                    isSelected:
                        transactionController.selectedFilter.value == 'PENDING',
                    onTap: () => transactionController.setFilter('PENDING'),
                  ),
                  const SizedBox(width: REYSizes.spaceBtwItems),
                ],
              ),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),

          // History Card List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(REYSizes.defaultSpace),
              child: Column(children: [TransactionHistoryCardList()]),
            ),
          ),
        ],
      ),
    );
  }
}
