import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/common/widgets/chip_filter.dart';
import 'package:eco_waste/features/user/trash_bank/screens/history/widgets/history_card_list.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
      body: Column(
        children: [
          // Filter Section
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: REYSizes.spaceBtwItems,
              children: [
                const SizedBox(width: REYSizes.spaceBtwItems),
                REYChipFilter(
                  chipFilterString: 'Sudah Dikonfirmasi',
                  chipFilterColor: REYColors.success,
                  chipFilterIcon: Iconsax.tick_square,
                ),
                REYChipFilter(
                  chipFilterString: 'Menuggu Konfirmasi',
                  chipFilterColor: REYColors.warning,
                  chipFilterIcon: Iconsax.warning_2,
                ),
                REYChipFilter(
                  chipFilterString: 'Ditolak',
                  chipFilterColor: REYColors.error,
                  chipFilterIcon: Iconsax.close_circle,
                ),
                const SizedBox(width: REYSizes.spaceBtwItems),
              ],
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwItems),

          // History Card List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(REYSizes.defaultSpace),
              child: Column(children: [HistoryCardList(userId: userId)]),
            ),
          ),
        ],
      ),
    );
  }
}
