import 'package:eco_waste/features/user/trash_bank/controllers/waste_transaction_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/widgets/history_card.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryCardList extends StatelessWidget {
  const HistoryCardList({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final WasteTransactionController controller = Get.put(
      WasteTransactionController(),
    );
    controller.getTransactions(userId: userId);

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(REYColors.primary),
              ),
            )
          : Column(
              spacing: REYSizes.spaceBtwItems / 2,
              children: controller.transactions.map((transaction) {
                return HistoryCard(
                  desaId: '', // Will need to map from TPS3R
                  berat: transaction.totalWeight.toString(),
                  jenisSampah: transaction.items.isNotEmpty
                      ? controller
                                .getCategoryById(
                                  transaction.items.first.categoryId,
                                )
                                ?.name ??
                            'Unknown'
                      : 'No items',
                  poin: transaction.totalPoints,
                  waktu: transaction.createdAt != null
                      ? DateTime.tryParse(transaction.createdAt!) ??
                            DateTime.now()
                      : DateTime.now(),
                  rt: '', // Will need to map from user or TPS3R
                  rw: '', // Will need to map from user or TPS3R
                  userId: transaction.userId,
                  available: transaction.status == 'processed',
                  deposit: transaction, // Pass the transaction object
                );
              }).toList(),
            ),
    );
  }
}
