import 'package:eco_waste/features/authentication/controllers/login_controller.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
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
                validator: (value) => REYValidator.validateEmail(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: REYSizes.spaceBtwInputFields),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: loginController.isObscurePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: 'password'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(
                      loginController.isObscurePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                    onPressed: loginController.toggleObscurePassword,
                  ),
                ),
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
                        value: loginController.isRememberMe.value,
                        onChanged: loginController.toggleRememberMe,
                      ),
                      Text('rememberMe'.tr),
                    ],
                  ),

                  // Forgot Password
                  // TextButton(
                  //   onPressed: () => Get.to(const ForgetPasswordScreen()),
                  //   child: Text(
                  //     'forgetPassword'.tr,
                  //     style: const TextStyle(color: REYColors.primary),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: REYSizes.spaceBtwSections),

              // Signin Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      loginController.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  child: Text('signIn'.tr),
                ),
              ),
              const SizedBox(height: REYSizes.spaceBtwItems),

              // Create Account Button
              // SizedBox(
              //   width: double.infinity,
              //   child: OutlinedButton(
              //     onPressed: () => Get.to(const SignupScreen()),
              //     child: Text('createAccount'.tr),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
