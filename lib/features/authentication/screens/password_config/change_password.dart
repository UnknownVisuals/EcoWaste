import 'package:eco_waste/features/authentication/controllers/password_controller.dart';
import 'package:eco_waste/features/authentication/utils/auth_validators.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController = Get.put(PasswordController());
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
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
                    'Change Your Password',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwItems),
                  Text(
                    'Enter your current password and choose a new one.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwSections * 2),

                  // Current Password
                  TextFormField(
                    controller: currentPasswordController,
                    obscureText: passwordController.obscurePassword.value,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordController.obscurePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                        onPressed: passwordController.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) =>
                        AuthValidators.validateCurrentPassword(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwInputFields),

                  // New Password
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: passwordController.obscurePassword.value,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordController.obscurePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                        onPressed: passwordController.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) => AuthValidators.validateNewPassword(
                      value,
                      currentPasswordController.text,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: REYSizes.spaceBtwInputFields),

                  // Confirm Password
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText:
                        passwordController.obscureConfirmPassword.value,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordController.obscureConfirmPassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                        onPressed:
                            passwordController.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    validator: (value) =>
                        AuthValidators.validateConfirmPassword(
                          newPasswordController.text,
                          value,
                        ),
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
                                passwordController.changePassword(
                                  currentPassword:
                                      currentPasswordController.text,
                                  newPassword: newPasswordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
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
                          : const Text('Change Password'),
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
