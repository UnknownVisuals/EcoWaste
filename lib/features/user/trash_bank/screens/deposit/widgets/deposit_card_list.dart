import 'package:eco_waste/features/user/trash_bank/controllers/waste_transaction_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_card.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositCardList extends StatelessWidget {
  const DepositCardList({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final WasteTransactionController controller = Get.put(
      WasteTransactionController(),
    );
    controller.getTransactions(userId: userId);

    return Obx(
      () => Column(
        spacing: REYSizes.spaceBtwItems / 2,
        children: controller.transactions.map((transaction) {
          return DepositCard(
            id: transaction.id,
            desaId: '', // Map from TPS3R if needed
            berat: transaction.totalWeight.toString(),
            jenisSampah: transaction.items.isNotEmpty
                ? controller
                          .getCategoryById(transaction.items.first.categoryId)
                          ?.name ??
                      'Unknown'
                : 'No items',
            poin: transaction.totalPoints,
            waktu: transaction.createdAt != null
                ? DateTime.tryParse(transaction.createdAt!) ?? DateTime.now()
                : DateTime.now(),
            rt: '', // Map from user or TPS3R if needed
            rw: '', // Map from user or TPS3R if needed
            userId: transaction.userId,
            available: transaction.status == 'processed',
          );
        }).toList(),
      ),
    );
  }
}
