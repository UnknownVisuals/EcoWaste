import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _localStorage = REYLocalStorage();
  final _key = 'isDarkMode';
  var isDarkMode = false.obs;

  ThemeMode get theme {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeController() {
    isDarkMode.value = _loadThemeFromStorage();
  }

  bool _loadThemeFromStorage() {
    return _localStorage.readData<bool>(_key) ?? false;
  }

  void _saveThemeToStorage(bool isDark) {
    _localStorage.saveData(_key, isDark);
  }

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToStorage(isDark);
  }
}
