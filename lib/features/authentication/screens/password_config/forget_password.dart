import 'package:eco_waste/features/authentication/screens/password_config/reset_password.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headings
              Text(
                'forgetPasswordTitle'.tr,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'forgetPasswordSubTitle'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: REYSizes.spaceBtwSections * 2),

              // TextFields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                  prefixIcon: const Icon(Iconsax.direct_right),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.off(const ResetPasswordScreen()),
                  child: Text('submit'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
