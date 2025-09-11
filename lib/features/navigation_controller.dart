import 'package:eco_waste/features/news/screens/news.dart';
import 'package:eco_waste/features/trash_bank/screens/home/home.dart';
import 'package:eco_waste/features/leaderboard/screens/leaderboard.dart';
import 'package:eco_waste/features/personalization/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;

  NavigationController() {
    screens = [
      HomeScreen(),
      LeaderboardScreen(),
      NewsScreen(),
      SettingsScreen(),
    ];
  }
}
