import 'package:eco_waste/features/user/trash_bank/controllers/deposit_controller.dart';
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
    final DepositController controller = Get.put(DepositController());
    controller.getDeposit(userId: userId);

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(REYColors.primary),
              ),
            )
          : Column(
              spacing: REYSizes.spaceBtwItems / 2,
              children: controller.deposit.map((deposit) {
                return HistoryCard(
                  desaId: deposit.desaId,
                  berat: deposit.berat,
                  jenisSampah: deposit.jenisSampah,
                  poin: deposit.poin,
                  waktu: deposit.waktu,
                  rt: deposit.rt,
                  rw: deposit.rw,
                  userId: deposit.userId,
                  available: deposit.available,
                );
              }).toList(),
            ),
    );
  }
}
