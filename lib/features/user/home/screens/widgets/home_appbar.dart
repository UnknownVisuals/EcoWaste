import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/notification_menu_icon.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/transactions_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/transactions_history.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeAppBar extends StatelessWidget {
  const UserHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final UserController userController = Get.find<UserController>();
      final user = userController.userModel.value;

      // Get the transaction controller if it exists, otherwise use 0 for count
      final TransactionController? transactionController =
          Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : null;

      final pendingCount =
          transactionController?.transactions
              .where((t) => t.status.toUpperCase() == 'PENDING')
              .length ??
          0;

      return REYAppBar(
        showBackArrow: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'homeAppbarTitle'.tr,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: REYColors.white),
            ),
            Text(
              '${'hello'.tr}, ${user.name}!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: REYColors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          REYNotificationCounterIcon(
            onPressed: () => Get.to(TransactionsHistoryScreen()),
            iconColor: REYColors.white,
            availableCount: pendingCount,
          ),
        ],
      );
    });
  }
}
