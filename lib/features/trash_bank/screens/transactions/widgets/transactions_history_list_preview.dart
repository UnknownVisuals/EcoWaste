import 'package:eco_waste/features/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/widgets/transactions_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TransactionHistoryListPreview extends StatelessWidget {
  const TransactionHistoryListPreview({super.key, this.maxItems = 10});

  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );

    return Obx(() {
      // Fetch transactions when needed
      if (transactionController.allTransactions.isEmpty &&
          !transactionController.isLoading.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          transactionController.fetchTransactions();
        });
      }

      if (transactionController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: REYColors.primary),
        );
      }

      if (transactionController.allTransactions.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.clock,
                size: REYSizes.iconLg * 2,
                color: REYColors.grey,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'noTransactionHistoryAvailable'.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: REYColors.grey),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems / 2),
              Text(
                'yourTransactionsWillAppearHere'.tr,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: REYColors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      final displayTransactions = transactionController.allTransactions
          .take(maxItems)
          .toList();

      return Column(
        spacing: REYSizes.spaceBtwItems / 2,
        children: displayTransactions.map((transaction) {
          return TransactionCard(transaction: transaction);
        }).toList(),
      );
    });
  }
}
