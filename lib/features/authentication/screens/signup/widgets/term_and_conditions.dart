import 'package:eco_waste/features/authentication/controllers/signup_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());

    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: signupController.agreeTnC.value,
              onChanged: signupController.toggleAgreeToC,
            ),
          ),
          const SizedBox(width: REYSizes.spaceBtwItems),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${'iAgreeTo'.tr} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: 'privacyPolicy'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: REYColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: REYColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${'and'.tr} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: 'termsOfUse'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: REYColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: REYColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
