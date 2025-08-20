import 'package:eco_waste/common/styles/spacing_styles.dart';
import 'package:eco_waste/features/authentication/screens/login/widgets/login_form.dart';
import 'package:eco_waste/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: REYSpacingStyles.paddingWithAppBarHeight,
        child: Column(
          children: [
            // Logo, Title, & Subtitle
            const LoginHeader(),

            // Form Fields
            const LoginForm(),

            // Divider
            // REYFormDivider(dividerText: REYTexts.orSignInWith.capitalize!),
            // const SizedBox(height: REYSizes.spaceBtwSections),

            // Signin with Socials
            // const REYSocialButtons(),
          ],
        ),
      ),
    );
  }
}
