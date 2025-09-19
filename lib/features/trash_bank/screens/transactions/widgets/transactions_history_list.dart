import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
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
    // Use Get.put to ensure controller exists, it will return existing instance if already created
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );
    final UserController userController = Get.find<UserController>();

    return Obx(() {
      // Ensure transactions are fetched when user data becomes available
      final userId = userController.userModel.value.id;
      if (userId.isNotEmpty &&
          transactionController.transactions.isEmpty &&
          !transactionController.isLoading.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          transactionController.fetchTransactions(userId: userId);
        });
      }
      if (transactionController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: REYColors.primary),
        );
      }

      if (transactionController.filteredTransactions.isEmpty) {
        String emptyMessage;
        if (transactionController.transactions.isEmpty) {
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
              ),
              const SizedBox(height: REYSizes.spaceBtwItems / 2),
              Text(
                transactionController.transactions.isEmpty
                    ? 'yourTransactionsWillAppearHere'.tr
                    : 'trySelectingDifferentFilter'.tr,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: REYColors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactionController.filteredTransactions.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: REYSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          final transaction = transactionController.filteredTransactions[index];
          return TransactionCard(transaction: transaction);
        },
      );
    });
  }
}
