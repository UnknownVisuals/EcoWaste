import 'package:eco_waste/features/news/screens/news.dart';
import 'package:eco_waste/features/user/home/screens/home.dart';
import 'package:eco_waste/features/leaderboard/screens/leaderboard.dart';
import 'package:eco_waste/features/user/personalization/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;

  UserNavigationController() {
    screens = [
      UserHomeScreen(),
      UserLeaderboardScreen(),
      NewsScreen(),
      UserSettingsScreen(),
    ];
  }
}
