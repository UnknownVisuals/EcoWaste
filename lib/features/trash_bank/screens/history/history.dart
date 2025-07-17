import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/trash_bank/screens/history/widgets/history_card_list.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.userId, required this.desaId});

  final String userId, desaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(
        showBackArrow: true,
        title: Text(
          'Riwayat',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: HistoryCardList(userId: userId),
      ),
    );
  }
}
