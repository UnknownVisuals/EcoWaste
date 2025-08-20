import 'package:eco_waste/features/admin/trash_bank/controllers/admin_waste_transaction_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_card.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositCardList extends StatelessWidget {
  const DepositCardList({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final AdminWasteTransactionController controller = Get.put(
      AdminWasteTransactionController(),
    );

    return Obx(
      () => Column(
        spacing: REYSizes.spaceBtwItems / 2,
        children: controller.pendingTransactions.map((transaction) {
          return DepositCard(
            id: transaction.id,
            desaId: transaction.tps3rId,
            berat: transaction.totalWeight.toString(),
            jenisSampah: transaction.items.isNotEmpty
                ? transaction.items.first.categoryId
                : '',
            poin: transaction.totalPoints,
            waktu: transaction.createdAt != null
                ? DateTime.tryParse(transaction.createdAt!) ?? DateTime.now()
                : DateTime.now(),
            rt: '',
            rw: '',
            userId: transaction.userId,
            available: transaction.status == 'PENDING',
          );
        }).toList(),
      ),
    );
  }
}
