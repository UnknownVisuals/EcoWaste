import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({
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
  final dynamic deposit;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy, HH:mm').format(waktu);
    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'Detail Setoran',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(REYSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Details of the depositer
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://picsum.photos/200',
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: REYSizes.spaceBtwItems),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pengumumpul',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Email Pengumpul',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),

            // Picture of Proof
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/320/180',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: REYSizes.spaceBtwItems),

            // Details of the deposit
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

            // Status
            const SizedBox(height: REYSizes.spaceBtwSections),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('cancel'.tr),
                  ),
                ),
                const SizedBox(width: REYSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('confirm'.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
