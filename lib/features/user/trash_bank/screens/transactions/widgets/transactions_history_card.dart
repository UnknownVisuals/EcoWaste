import 'package:eco_waste/common/widgets/icon_button.dart';
import 'package:eco_waste/features/user/trash_bank/screens/transactions/widgets/transactions_history_card_detail.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.desaId,
    required this.berat,
    required this.jenisSampah,
    required this.rt,
    required this.rw,
    required this.poin,
    required this.waktu,
    required this.userId,
    required this.available,
    this.deposit,
  });

  final String desaId, berat, jenisSampah, rt, rw, userId;
  final int poin;
  final DateTime waktu;
  final bool available;
  final dynamic deposit; // Pass the whole deposit object for details

  @override
  Widget build(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy, HH:mm').format(waktu);

    if (!available) {
      return const SizedBox.shrink();
    }

    return InkWell(
      borderRadius: BorderRadius.circular(REYSizes.borderRadiusLg),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HistoryDetailPage(
              desaId: desaId,
              berat: berat,
              jenisSampah: jenisSampah,
              rt: rt,
              rw: rw,
              poin: poin,
              waktu: waktu,
              userId: userId,
              available: available,
              deposit: deposit,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: dark
              ? REYColors.grey.withValues(alpha: 0.1)
              : REYColors.grey.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(REYSizes.borderRadiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Picture Thumbnail
              ClipOval(
                child: Image.network(
                  'https://picsum.photos/200',
                  width: REYSizes.lg * 2.5,
                  height: REYSizes.lg * 2.5,
                  fit: BoxFit.cover,
                ),
              ),

              // Date and Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$formattedDate WIB',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems / 4),
                  Text(
                    '${berat}Kg $jenisSampah',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems / 4),
                  Row(
                    children: [
                      const Icon(Iconsax.coin_1, size: REYSizes.iconSm),
                      const SizedBox(width: REYSizes.sm / 2),
                      Text(
                        "$poin Poin",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),

              // Icon Information
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  REYIconButton(
                    icon: Iconsax.tick_square,
                    title: '',
                    color: REYColors.success,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
