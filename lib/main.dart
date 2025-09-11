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

  // Initialize storage first
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  // Initialize other controllers
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put(REYHttpHelper());

  // Load session cookie before initializing UserController
  REYHttpHelper.loadSessionCookie();

  // Initialize UserController after storage is ready
  Get.put(UserController());

  final storage = REYLocalStorage();
  final bool seenOnboarding =
      storage.readData<bool>('hasSeenOnboarding') ?? false;
  final bool rememberMe = storage.readData<bool>('rememberMe') ?? false;

  runApp(App(seenOnboarding: seenOnboarding, rememberMe: rememberMe));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.seenOnboarding,
    required this.rememberMe,
  });

  final bool seenOnboarding, rememberMe;

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
    if (!seenOnboarding) {
      return const OnBoardingScreen();
    }

    // Check both rememberMe flag and session cookie existence
    final storage = REYLocalStorage();
    final sessionCookie = storage.readData<String>('sessionCookie');

    // If remember me is false or no session cookie, go to login
    if (!rememberMe || sessionCookie == null) {
      return const LoginScreen();
    }

    // If remember me is true and we have a session cookie, go to navigation menu
    // UserController will fetch fresh user data and handle session validation
    return const NavigationMenu();
  }
}
