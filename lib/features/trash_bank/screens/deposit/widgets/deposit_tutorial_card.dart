import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DepositTutorialCard extends StatelessWidget {
  const DepositTutorialCard({
    super.key,
    required this.imagePath,
    required this.text,
  });

  final String imagePath, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: REYColors.borderPrimary),
        borderRadius: BorderRadius.circular(REYSizes.borderRadiusLg),
      ),
      child: Column(
        children: [
          Flexible(flex: 4, child: Image(image: AssetImage(imagePath))),
          const SizedBox(height: REYSizes.spaceBtwItems),
          Flexible(
            flex: 1,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
