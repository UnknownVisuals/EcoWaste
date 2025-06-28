import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYSocialButtons extends StatelessWidget {
  const REYSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: REYColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: REYSizes.iconMd,
              height: REYSizes.iconMd,
              image: AssetImage(REYImages.google),
            ),
          ),
        ),
        const SizedBox(width: REYSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: REYColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: REYSizes.iconMd,
              height: REYSizes.iconMd,
              image: AssetImage(REYImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
