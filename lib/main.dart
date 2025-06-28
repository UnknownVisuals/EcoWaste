import 'package:eco_waste/features/authentication/screens/onboarding/onboarding.dart';
import 'package:eco_waste/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eco Waste',
      theme: REYAppTheme.lightTheme,
      darkTheme: REYAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
