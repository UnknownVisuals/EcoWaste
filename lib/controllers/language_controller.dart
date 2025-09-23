import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final GetStorage storage = GetStorage();

  // Default to Indonesian
  final Rx<Locale> currentLocale = const Locale('id', 'ID').obs;

  @override
  void onInit() {
    super.onInit();
    final savedLanguage =
        storage.read('language') ?? 'id'; // Default to Indonesian
    changeLanguage(savedLanguage);
  }

  void changeLanguage(String languageCode) {
    currentLocale.value = languageCode == 'id'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');

    storage.write('language', languageCode);
    Get.updateLocale(currentLocale.value);
  }

  bool get isEnglish => currentLocale.value.languageCode == 'en';
  bool get isIndonesian => currentLocale.value.languageCode == 'id';
}
