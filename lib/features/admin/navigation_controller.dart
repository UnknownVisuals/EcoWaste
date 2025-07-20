import 'package:eco_waste/features/admin/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;

  AdminNavigationController() {
    screens = [
      AdminHomeScreen(),
      // AdminLeaderboardScreen(),
      // NewsScreen(),
      // AdminSettingsScreen(),
    ];
  }
}
