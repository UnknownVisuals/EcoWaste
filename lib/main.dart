import 'package:eco_waste/theme_test.dart';
import 'package:eco_waste/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Waste',
      theme: REYAppTheme.lightTheme,
      darkTheme: REYAppTheme.darkTheme,
      home: const ThemeTest(),
    );
  }
}
