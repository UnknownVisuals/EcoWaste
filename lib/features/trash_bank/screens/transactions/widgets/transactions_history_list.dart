import 'package:eco_waste/features/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/trash_bank/screens/transactions/widgets/transactions_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );

    return Obx(() {
      // Fetch transactions when user data becomes available
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

      if (transactionController.filteredTransactions.isEmpty) {
        String emptyMessage;
        if (transactionController.allTransactions.isEmpty) {
          emptyMessage = 'noTransactionHistoryAvailable'.tr;
        } else {
          // There are transactions but none match the current filter
          final filterName =
              {
                'ALL': 'all',
                'CONFIRMED': 'confirmed',
                'PENDING': 'pending',
                'REJECTED': 'rejected',
              }[transactionController.selectedFilter.value] ??
              'selected';
          emptyMessage = '${'noFilteredTransactionsFound'.tr} ($filterName)';
        }

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
                emptyMessage,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: REYColors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await transactionController.refreshTransactions();
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: transactionController.filteredTransactions.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: REYSizes.spaceBtwItems),
          itemBuilder: (context, index) {
            final transaction =
                transactionController.filteredTransactions[index];
            return TransactionCard(transaction: transaction);
          },
        ),
      );
    });
  }
}
