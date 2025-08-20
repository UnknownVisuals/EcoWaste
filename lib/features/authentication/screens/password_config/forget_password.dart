import 'package:eco_waste/features/authentication/controllers/password_controller.dart';
import 'package:eco_waste/features/authentication/utils/auth_validators.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController = Get.put(PasswordController());
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(REYSizes.defaultSpace),
          child: Obx(
            () => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headings
                  Text(
                    REYTexts.forgetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Text(
                    REYTexts.forgetPasswordSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwSections * 2),

                  // Email TextField
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: REYTexts.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                    validator: (value) => AuthValidators.validateEmail(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwSections),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: passwordController.isLoading.value
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                passwordController.forgotPassword(
                                  email: emailController.text.trim(),
                                );
                              }
                            },
                      child: passwordController.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(REYTexts.submit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
