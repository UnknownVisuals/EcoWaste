import 'package:eco_waste/controllers/theme_controller.dart';
import 'package:eco_waste/controllers/language_controller.dart';
import 'package:eco_waste/features/authentication/controllers/user_controller.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/onboarding.dart';
import 'package:eco_waste/features/navigation_menu.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/local_storage/storage_utility.dart';
import 'package:eco_waste/utils/theme/theme.dart';
import 'package:eco_waste/utils/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage and environment
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  // Initialize core controllers
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put(REYHttpHelper());

  // Load session cookie and initialize UserController
  REYHttpHelper.loadSessionCookie();
  Get.put(UserController());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();

    return Obx(
      () => GetMaterialApp(
        title: 'appName'.tr,
        themeMode: themeController.theme,
        theme: REYAppTheme.lightTheme,
        darkTheme: REYAppTheme.darkTheme,
        translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale: const Locale('id', 'ID'),
        home: _determineHomeScreen(),
      ),
    );
  }

  Widget _determineHomeScreen() {
    final storage = REYLocalStorage();
    final bool seenOnboarding =
        storage.readData<bool>('hasSeenOnboarding') ?? false;
    final bool rememberMe = storage.readData<bool>('rememberMe') ?? false;
    final String? sessionCookie = storage.readData<String>('sessionCookie');

    // Show onboarding for first-time users
    if (!seenOnboarding) {
      return const OnBoardingScreen();
    }

    // If user chose remember me and has valid session cookie, go to main app
    if (rememberMe && sessionCookie != null) {
      return const NavigationMenu();
    }

    // Otherwise, show login screen
    return const LoginScreen();
  }
}
