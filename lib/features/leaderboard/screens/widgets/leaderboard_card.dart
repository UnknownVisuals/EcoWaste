import 'package:eco_waste/features/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({
    super.key,
    this.color,
    required this.leaderboardItem,
    required this.rank,
  });

  final Color? color;
  final LeaderboardModel leaderboardItem;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);
    final defaultColor = dark
        ? REYColors.grey.withValues(alpha: 0.1)
        : REYColors.grey.withValues(alpha: 0.6);

    final LocationsController locationsController =
        Get.find<LocationsController>();

    // Get formatted location name
    final locationText = locationsController.getFormattedLocationName(
      leaderboardItem.locationId,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: REYSizes.spaceBtwItems / 2),
      child: Container(
        padding: const EdgeInsets.all(REYSizes.md),
        decoration: BoxDecoration(
          color: color ?? defaultColor,
          borderRadius: BorderRadius.circular(REYSizes.md),
          border: Border.all(
            color: dark
                ? REYColors.darkerGrey
                : REYColors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            // Rank number
            SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  rank.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color != null ? Colors.white : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: REYSizes.spaceBtwItems / 2),
            // User avatar
            CircleAvatar(
              radius: 25,
              backgroundColor: REYColors.grey.withValues(alpha: 0.3),
              child: leaderboardItem.avatar.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        leaderboardItem.avatar,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            REYImages.user,
                            width: 50,
                            height: 50,
                          );
                        },
                      ),
                    )
                  : Image.asset(REYImages.user, width: 50, height: 50),
            ),
            const SizedBox(width: REYSizes.spaceBtwItems),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leaderboardItem.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    locationText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            // Points
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.coin_1, size: REYSizes.iconLg),
                Text(
                  REYFormatter.formatPoints(leaderboardItem.points),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
