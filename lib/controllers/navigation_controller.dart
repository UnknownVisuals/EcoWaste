import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/user/leaderboard/screens/leaderboard.dart';
import 'package:eco_waste/features/news/screens/news.dart';
import 'package:eco_waste/features/user/personalization/screens/settings/settings.dart';
import 'package:eco_waste/features/user/homescreen/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;
  final UserModel userModel;

  NavigationController({required this.userModel}) {
    screens = [
      HomeScreen(userModel: userModel),
      LeaderboardScreen(userModel: userModel),
      NewsScreen(userModel: userModel),
      SettingsScreen(userModel: userModel),
    ];
  }
}
