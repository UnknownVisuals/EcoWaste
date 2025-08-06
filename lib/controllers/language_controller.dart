import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final GetStorage storage = GetStorage();

  // Observable for current language (default to Indonesian)
  final Rx<Locale> currentLocale = const Locale('id', 'ID').obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage =
        storage.read('language') ?? 'id'; // Default to Indonesian
    if (savedLanguage == 'id') {
      currentLocale.value = const Locale('id', 'ID');
    } else {
      currentLocale.value = const Locale('en', 'US');
    }
    Get.updateLocale(currentLocale.value);
  }

  void changeLanguage(String languageCode) {
    if (languageCode == 'id') {
      currentLocale.value = const Locale('id', 'ID');
    } else {
      currentLocale.value = const Locale('en', 'US');
    }

    storage.write('language', languageCode);
    Get.updateLocale(currentLocale.value);
  }

  bool get isEnglish => currentLocale.value.languageCode == 'en';
  bool get isIndonesian => currentLocale.value.languageCode == 'id';
}
