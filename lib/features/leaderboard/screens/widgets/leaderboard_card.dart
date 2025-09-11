import 'package:eco_waste/features/leaderboard/models/leaderboard_model.dart';
import 'package:eco_waste/features/trash_bank/controllers/locations_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
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
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
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
          ],
        ),
        title: Text(
          leaderboardItem.name,
          style: Theme.of(context).textTheme.titleLarge,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          locationText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.coin_1, size: REYSizes.iconLg),
            Text(
              leaderboardItem.points.toString(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
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
