import 'package:eco_waste/common/widgets/rounded_container.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.onTap,
    this.onAddToCart,
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
          borderRadius: BorderRadius.circular(REYSizes.productImageRadius),
          color: dark ? REYColors.darkerGrey : REYColors.white,
        ),
        child: Column(
          children: [
            // Product Image
            REYRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(REYSizes.sm),
              backgroundColor: dark ? REYColors.darkerGrey : REYColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  REYSizes.productImageRadius,
                ),
                child: Image.network(imageUrl, fit: BoxFit.cover),
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
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          margin: const EdgeInsets.only(left: REYSizes.sm),
                          padding: const EdgeInsets.all(REYSizes.sm / 2),
                          decoration: BoxDecoration(
                            color: REYColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(REYSizes.cardRadiusMd),
                              bottomRight: Radius.circular(
                                REYSizes.productImageRadius,
                              ),
                            ),
                          ),
                          child: const SizedBox(
                            width: REYSizes.iconMd,
                            height: REYSizes.iconMd,
                            child: Icon(Iconsax.add, color: REYColors.white),
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
