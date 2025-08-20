import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/admin/trash_bank/screens/history/widgets/admin_history_card_list.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHistoryScreen extends StatelessWidget {
  const AdminHistoryScreen({
    super.key,
    required this.userId,
    required this.desaId,
  });

  final String userId, desaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(title: Text('history'.tr), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'allUsersHistory'.tr, // Show history for all users in this desa
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),
            Expanded(child: AdminHistoryCardList(desaId: desaId)),
          ],
        ),
      ),
    );
  }
}
