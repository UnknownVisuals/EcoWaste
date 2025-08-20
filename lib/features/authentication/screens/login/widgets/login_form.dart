import 'package:eco_waste/features/authentication/controllers/auth_controller.dart';
import 'package:eco_waste/features/authentication/screens/password_config/forget_password.dart';
import 'package:eco_waste/features/authentication/screens/signup/signup.dart';
import 'package:eco_waste/features/authentication/utils/auth_validators.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Obx(
      () => Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: REYSizes.spaceBtwSections,
          ),
          child: Column(
            children: [
              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.direct_right),
                  labelText: 'email'.tr,
                ),
                validator: (value) => AuthValidators.validateEmail(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: REYSizes.spaceBtwInputFields),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: authController.isObscurePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: 'password'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authController.isObscurePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                    onPressed: authController.toggleObscuredPassword,
                  ),
                ),
                validator: (value) => AuthValidators.validatePassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: REYSizes.spaceBtwInputFields / 2),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember Me
                  Row(
                    children: [
                      Checkbox(
                        value: authController.isRememberMe.value,
                        onChanged: authController.toggleRememberMe,
                      ),
                      Text('rememberMe'.tr),
                    ],
                  ),

                  // Forgot Password
                  TextButton(
                    onPressed: () => Get.to(const ForgetPasswordScreen()),
                    child: Text(
                      'forgetPassword'.tr,
                      style: const TextStyle(color: REYColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Signin Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => authController.login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                  child: authController.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      : Text('signIn'.tr),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.to(const SignupScreen()),
                  child: Text('createAccount'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
