import 'package:eco_waste/features/authentication/controllers/signup_controller.dart';
import 'package:eco_waste/features/authentication/screens/signup/verify_email.dart';
import 'package:eco_waste/features/authentication/screens/signup/widgets/term_and_conditions.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.put(SignupController());

    return Form(
      child: Column(
        children: [
          // // First Name & Last Name
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextFormField(
          //         expands: false,
          //         decoration: InputDecoration(
          //           labelText: 'firstName'.tr,
          //           prefixIcon: const Icon(Iconsax.user),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: REYSizes.spaceBtwInputFields),
          //     Expanded(
          //       child: TextFormField(
          //         expands: false,
          //         decoration: InputDecoration(
          //           labelText: 'lastName'.tr,
          //           prefixIcon: const Icon(Iconsax.user),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: REYSizes.spaceBtwInputFields),

          // Username
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: 'username'.tr,
              prefixIcon: const Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: 'email'.tr,
              prefixIcon: const Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwInputFields),

          // // Phone Number
          // TextFormField(
          //   expands: false,
          //   decoration: InputDecoration(
          //     labelText: 'phoneNo'.tr,
          //     prefixIcon: const Icon(Iconsax.call),
          //   ),
          // ),
          // const SizedBox(height: REYSizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              expands: false,
              obscureText: signupController.obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.obscurePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: signupController.togglePasswordVisibility,
                ),
              ),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwInputFields),

          // Confirm Password
          Obx(
            () => TextFormField(
              expands: false,
              obscureText: signupController.obscureConfirmPassword.value,
              decoration: InputDecoration(
                labelText: 'confirmPassword'.tr,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.obscureConfirmPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: signupController.toggleConfirmPasswordVisibility,
                ),
              ),
            ),
          ),
          const SizedBox(height: REYSizes.spaceBtwSections),

          // Agree to Terms & Conditions
          const TermAndConditions(),
          const SizedBox(height: REYSizes.spaceBtwSections),

          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(const VerifyEmailScreen()),
              child: Text('createAccount'.tr),
            ),
          ),
        ],
      ),
    );
  }
}
