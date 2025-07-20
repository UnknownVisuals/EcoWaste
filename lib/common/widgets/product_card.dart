import 'package:eco_waste/common/styles/shadow_styles.dart';
import 'package:eco_waste/common/widgets/rounded_container.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class REYProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const REYProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = REYHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [REYShadowStyles.productCardShadow],
          borderRadius: BorderRadius.circular(REYSizes.productImageRadius),
          color: dark ? REYColors.darkerGrey : REYColors.white,
        ),
        child: Column(
          children: [
            // Product Image
            REYRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(1),
              backgroundColor: dark ? REYColors.dark : REYColors.light,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      REYSizes.productImageRadius,
                    ),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(REYSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: REYColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(REYSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              REYSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: REYSizes.iconLg * 1.2,
                          height: REYSizes.iconLg * 1.2,
                          child: Center(
                            child: const Icon(
                              Iconsax.add,
                              color: REYColors.white,
                            ),
                          ),
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
