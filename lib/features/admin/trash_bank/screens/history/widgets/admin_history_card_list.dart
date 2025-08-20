import 'package:eco_waste/features/admin/trash_bank/controllers/admin_waste_transaction_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/widgets/history_card.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHistoryCardList extends StatelessWidget {
  const AdminHistoryCardList({super.key, required this.desaId});

  final String desaId;

  @override
  Widget build(BuildContext context) {
    final AdminWasteTransactionController controller = Get.put(
      AdminWasteTransactionController(),
    );
    // For admin, get all transactions for TPS3R in this location
    controller.loadAllTransactions(tps3rId: desaId);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Filter transactions for this TPS3R location
      final locationTransactions = controller.allTransactions
          .where((transaction) => transaction.tps3rId == desaId)
          .toList();

      if (locationTransactions.isEmpty) {
        return Center(
          child: Text(
            'noHistoryFound'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: locationTransactions.length > 5
            ? 5
            : locationTransactions.length, // Show max 5
        separatorBuilder: (context, index) =>
            const SizedBox(height: REYSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          final transaction = locationTransactions[index];
          return HistoryCard(
            desaId: desaId,
            berat: transaction.totalWeight.toString(),
            jenisSampah: transaction.items.isNotEmpty
                ? controller
                          .getCategoryById(transaction.items.first.categoryId)
                          ?.name ??
                      'Unknown'
                : 'No items',
            rt: '', // Map from user or TPS3R if needed
            rw: '', // Map from user or TPS3R if needed
            poin: transaction.totalPoints,
            waktu: transaction.createdAt != null
                ? DateTime.tryParse(transaction.createdAt!) ?? DateTime.now()
                : DateTime.now(),
            userId: transaction.userId, // Show which user made the transaction
            available: transaction.status == 'processed',
            deposit: transaction, // Pass the whole transaction object
          );
        },
      );
    });
  }
}
