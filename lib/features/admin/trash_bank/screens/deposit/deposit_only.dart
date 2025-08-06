import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/user/trash_bank/screens/deposit/widgets/deposit_card_list.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DepositOnly extends StatelessWidget {
  const DepositOnly({super.key, required this.userId, required this.desaId});

  final String userId, desaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          "Menunggu Konfirmasi",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: DepositCardList(userId: userId),
      ),
    );
  }
}
