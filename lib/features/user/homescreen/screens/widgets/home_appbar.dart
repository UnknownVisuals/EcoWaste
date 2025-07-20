import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/notification_menu_icon.dart';
import 'package:eco_waste/features/user/trash_bank/controllers/deposit_controller.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/deposit_only.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.username,
    required this.userId,
    required this.desaId,
  });

  final String username, userId, desaId;

  @override
  Widget build(BuildContext context) {
    final DepositController controller = Get.put(DepositController());

    int availableCount = controller.deposit
        .where(
          (deposit) => deposit.available == false && deposit.userId == userId,
        )
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
        REYNotificationCounterIcon(
          onPressed: () => Get.to(DepositOnly(userId: userId, desaId: desaId)),
          iconColor: REYColors.white,
          availableCount: availableCount,
        ),
      ],
    );
  }
}
