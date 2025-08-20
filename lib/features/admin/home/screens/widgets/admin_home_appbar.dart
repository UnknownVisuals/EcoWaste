import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/admin/trash_bank/controllers/admin_waste_transaction_controller.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/deposit/deposit_only.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeAppBar extends StatelessWidget {
  const AdminHomeAppBar({
    super.key,
    required this.username,
    required this.userId,
    required this.desaId,
  });

  final String username, userId, desaId;

  @override
  Widget build(BuildContext context) {
    final AdminWasteTransactionController controller = Get.put(
      AdminWasteTransactionController(),
    );

    // Count pending confirmations for this TPS3R
    int pendingCount = controller.pendingTransactions
        .where((transaction) => transaction.tps3rId == desaId)
        .length;

    return REYAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            REYTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: REYColors.white),
          ),
          Text(
            'Hello, $username!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: REYColors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(DepositOnly(userId: userId, desaId: desaId)),
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: REYColors.white,
                size: 24,
              ),
              if (pendingCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: REYColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      pendingCount > 99 ? '99+' : pendingCount.toString(),
                      style: const TextStyle(
                        color: REYColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
