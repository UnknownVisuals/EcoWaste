import 'package:eco_waste/features/personalization/models/user_list_model.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:eco_waste/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserListCard extends StatelessWidget {
  const UserListCard({super.key, required this.user, this.onTap, this.rank});

  final UserListModel user;
  final VoidCallback? onTap;
  final int? rank;

  @override
  Widget build(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);
    final defaultColor = dark
        ? REYColors.grey.withValues(alpha: 0.1)
        : REYColors.grey.withValues(alpha: 0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: REYSizes.spaceBtwItems / 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(REYSizes.md),
        child: Container(
          padding: const EdgeInsets.all(REYSizes.md),
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(REYSizes.md),
            border: Border.all(
              color: dark
                  ? REYColors.darkerGrey
                  : REYColors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              // Rank number (if provided)
              if (rank != null) ...[
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text(
                      rank.toString(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: REYSizes.spaceBtwItems / 2),
              ],

              // User avatar
              CircleAvatar(
                radius: 25,
                backgroundColor: REYColors.grey.withValues(alpha: 0.3),
                child: Image.asset(REYImages.user, width: 50, height: 50),
              ),
              const SizedBox(width: REYSizes.spaceBtwItems),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Email
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: REYColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: REYColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        user.role.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: REYColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                    REYFormatter.formatPoints(user.points),
                    style: Theme.of(context).textTheme.labelLarge,
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
