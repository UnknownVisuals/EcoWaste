import 'package:eco_waste/common/widgets/rounded_container.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({
    super.key,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.stock,
    required this.icon,
    this.onTap,
  });

  final String name;
  final String description;
  final int pointsRequired;
  final int stock;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool dark = REYHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(REYSizes.productImageRadius),
          color: dark ? REYColors.darkerGrey : REYColors.white,
        ),
        child: Column(
          children: [
            // Reward Icon/Image
            REYRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(REYSizes.sm),
              backgroundColor: dark ? REYColors.darkerGrey : REYColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  REYSizes.productImageRadius,
                ),
                child: Image.network(icon, fit: BoxFit.cover),
              ),
            ),
            // Reward Details
            Padding(
              padding: const EdgeInsets.all(REYSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems / 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Iconsax.coin_1,
                            size: 16,
                            color: REYColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pointsRequired.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: stock > 0
                              ? REYColors.success
                              : REYColors.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          stock > 0 ? 'Stok: $stock' : 'Habis',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
