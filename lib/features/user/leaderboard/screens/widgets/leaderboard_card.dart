import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({
    super.key,
    required this.username,
    required this.jumlahPengumpulan,
    required this.totalPoin,
    this.color,
  });

  final String username, jumlahPengumpulan, totalPoin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);
    final defaultColor = dark
        ? REYColors.grey.withValues(alpha: 0.1)
        : REYColors.grey.withValues(alpha: 0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: REYSizes.spaceBtwItems / 2),
      child: ListTile(
        leading: Image.asset(REYImages.user, width: 50, height: 50),
        title: Text(
          username,
          style: Theme.of(context).textTheme.titleLarge,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          jumlahPengumpulan,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.coin_1, size: REYSizes.iconLg),
            Text(totalPoin, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        tileColor: color ?? defaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(REYSizes.md),
        ),
      ),
    );
  }
}
