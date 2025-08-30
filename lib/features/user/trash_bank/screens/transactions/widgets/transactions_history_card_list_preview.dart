import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryCardListPreview extends StatelessWidget {
  const TransactionHistoryCardListPreview({super.key, this.maxItems = 3});

  final int maxItems;

  @override
  Widget build(BuildContext context) {
    // Use Get.put to ensure controller exists, it will return existing instance if already created
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );
    final UserController userController = Get.find<UserController>();

    // Ensure transactions are fetched if not already loaded
    if (transactionController.transactions.isEmpty &&
        !transactionController.isLoading.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final userId = userController.userModel.value.id;
        if (userId.isNotEmpty) {
          transactionController.fetchTransactions(userId: userId);
        }
      });
    }

    return Obx(() {
      if (transactionController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: REYColors.primary),
        );
      }

      if (transactionController.transactions.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, size: 48, color: REYColors.grey),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'No transaction history available',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: REYColors.grey),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems / 2),
              Text(
                'Your transactions will appear here',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: REYColors.grey),
              ),
            ],
          ),
        );
      }

      // Get the most recent transactions, limited by maxItems
      final recentTransactions = transactionController.transactions
          .take(maxItems)
          .toList();

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentTransactions.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: REYSizes.spaceBtwItems / 2),
        itemBuilder: (context, index) {
          final transaction = recentTransactions[index];
          return TransactionCard(transaction: transaction);
        },
      );
    });
  }
}
