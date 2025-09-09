import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(height: 150, image: AssetImage(REYImages.logo)),
          Text(
            'loginTitle'.tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: REYSizes.sm),
          Text(
            'loginSubTitle'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
