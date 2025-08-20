import 'package:eco_waste/features/admin/trash_bank/controllers/admin_waste_transaction_controller.dart';
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
    final AdminWasteTransactionController controller = Get.put(
      AdminWasteTransactionController(),
    );

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(REYColors.primary),
              ),
            )
          : Column(
              spacing: REYSizes.spaceBtwItems / 2,
              children: controller.allTransactions.map((transaction) {
                return HistoryCard(
                  desaId: transaction.tps3rId,
                  berat: transaction.totalWeight.toString(),
                  jenisSampah: transaction.items.isNotEmpty
                      ? controller
                                .getCategoryById(
                                  transaction.items.first.categoryId,
                                )
                                ?.name ??
                            'Unknown'
                      : 'Unknown',
                  poin: transaction.totalPoints,
                  waktu: transaction.createdAt != null
                      ? DateTime.tryParse(transaction.createdAt!) ??
                            DateTime.now()
                      : DateTime.now(),
                  rt: '',
                  rw: '',
                  userId: transaction.userId,
                  available: transaction.status == 'PROCESSED',
                );
              }).toList(),
            ),
    );
  }
}
