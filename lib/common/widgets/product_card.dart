import 'package:eco_waste/common/styles/shadow_styles.dart';
import 'package:eco_waste/common/widgets/rounded_container.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class REYProductCard extends StatelessWidget {
  const REYProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = REYHelperFunctions.isDarkMode(context);

    return Container(
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
            padding: const EdgeInsets.all(REYSizes.sm),
            backgroundColor: dark ? REYColors.dark : REYColors.light,
            child: Stack(
              children: [
                // Thumbnail Image with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    REYSizes.productImageRadius,
                  ),
                  child: Image.network(
                    'https://picsum.photos/400/400',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(REYSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Produk',
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: REYSizes.spaceBtwItems / 2),
                Text(
                  'Rp 100.000',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: REYColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
