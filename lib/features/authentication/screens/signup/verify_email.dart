import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/features/authentication/screens/signup/widgets/success_screen.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(REYImages.deliveredEmailIllustration),
                width: REYHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Title & SubTitle
              Text(
                REYTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                'support@sobatsampah.id',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              Text(
                REYTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    SuccessScreen(
                      image: REYImages.staticSuccessIllustration,
                      title: REYTexts.yourAccountCreatedTitle,
                      subTitle: REYTexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.offAll(const LoginScreen()),
                    ),
                  ),
                  child: const Text(REYTexts.rContinue),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(REYTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
