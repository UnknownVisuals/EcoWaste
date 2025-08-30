import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsCardList extends StatelessWidget {
  const TransactionsCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Get.put(
      TransactionController(),
    );
    final UserController userController = Get.find<UserController>();

    // Fetch transactions with current user ID
    final userId = userController.userModel.value.id;
    if (userId.isNotEmpty && transactionController.transactions.isEmpty) {
      transactionController.fetchTransactions(userId: userId);
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
              Icon(Icons.inbox_outlined, size: 64, color: REYColors.grey),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'No transactions available',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: REYColors.grey),
              ),
            ],
          ),
        );
      }

      final displayTransactions = transactionController.transactions.toList();

      return Column(
        spacing: REYSizes.spaceBtwItems / 2,
        children: displayTransactions.map((transaction) {
          return TransactionCard(transaction: transaction);
        }).toList(),
      );
    });
  }
}
