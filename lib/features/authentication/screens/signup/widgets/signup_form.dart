import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:eco_waste/features/authentication/screens/signup/widgets/term_and_conditions.dart';
import 'package:eco_waste/features/authentication/utils/auth_validators.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Controllers for form fields
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Obx(
      () => Form(
        key: formKey,
        child: Column(
          children: [
            // First Name & Last Name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: REYTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                    validator: (value) => AuthValidators.validateName(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(width: REYSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: REYTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                    validator: (value) => AuthValidators.validateName(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ],
            ),
            const SizedBox(height: REYSizes.spaceBtwInputFields),

            // Email
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: REYTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
              validator: (value) => AuthValidators.validateEmail(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: REYSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: passwordController,
              obscureText: authController.obscurePassword.value,
              decoration: InputDecoration(
                labelText: REYTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    authController.obscurePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: authController.togglePasswordVisibility,
                ),
              ),
              validator: (value) => AuthValidators.validatePassword(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Agree to Terms & Conditions
            const TermAndConditions(),
            const SizedBox(height: REYSizes.spaceBtwSections),

            // Signup Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        if (formKey.currentState?.validate() ?? false) {
                          final fullName =
                              '${firstNameController.text.trim()} ${lastNameController.text.trim()}';
                          authController.signup(
                            name: fullName,
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      },
                child: authController.isLoading.value
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
                    : const Text(REYTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
