import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/admin/home/screens/home.dart';
import 'package:eco_waste/features/admin/leaderboard/screens/leaderboard.dart';
import 'package:eco_waste/features/news/screens/news.dart';
import 'package:eco_waste/features/admin/personalization/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;
  final UserModel userModel;

  AdminNavigationController({required this.userModel}) {
    screens = [
      AdminHomeScreen(userModel: userModel),
      AdminLeaderboardScreen(userModel: userModel),
      NewsScreen(userModel: userModel),
      SettingsScreen(userModel: userModel),
    ];
  }
}
