import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: authController.agreeTnC.value,
              onChanged: authController.toggleAgreeToC,
            ),
          ),
          const SizedBox(width: REYSizes.spaceBtwItems),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${REYTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: REYTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: REYColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: REYColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${REYTexts.and} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: REYTexts.termsOfUse,
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
