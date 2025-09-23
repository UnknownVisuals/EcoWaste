import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _localStorage = REYLocalStorage();
  final _key = 'isDarkMode';

  // Default to light theme (false)
  var isDarkMode = false.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value =
        _localStorage.readData<bool>(_key) ?? false; // Default to light theme
  }

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _localStorage.saveData(_key, isDark);
  }
}
