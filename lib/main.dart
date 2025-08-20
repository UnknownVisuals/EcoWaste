import 'package:eco_waste/controllers/theme_controller.dart';
import 'package:eco_waste/controllers/language_controller.dart';
import 'package:eco_waste/features/authentication/screens/login/login.dart';
import 'package:eco_waste/features/authentication/screens/onboarding/onboarding.dart';
import 'package:eco_waste/features/authentication/services/auth_service.dart';
import 'package:eco_waste/features/user/navigation_menu.dart';
import 'package:eco_waste/features/admin/navigation_menu.dart';
import 'package:eco_waste/utils/constants/text_strings.dart';
import 'package:eco_waste/utils/theme/theme.dart';
import 'package:eco_waste/utils/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController());
  Get.put(LanguageController());

  await dotenv.load(fileName: ".env");

  await GetStorage.init();

  // Initialize authentication service
  await Get.putAsync(() => AuthService().init());

  final GetStorage storage = GetStorage();

  bool seenOnboarding = storage.read('hasSeenOnboarding') ?? false;

  runApp(App(seenOnboarding: seenOnboarding));
}

class App extends StatelessWidget {
  const App({super.key, required this.seenOnboarding});

  final bool seenOnboarding;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LanguageController languageController = Get.find();
    final AuthService authService = Get.find();

    return Obx(
      () => GetMaterialApp(
        title: REYTexts.appName,
        themeMode: themeController.theme,
        theme: REYAppTheme.lightTheme,
        darkTheme: REYAppTheme.darkTheme,
        translations: AppTranslations(),
        locale: languageController.currentLocale.value,
        fallbackLocale: const Locale('id', 'ID'),
        home: seenOnboarding
            ? (authService.isAuthenticated
                  ? () {
                      final userModel = authService.currentUser;
                      return userModel.role == 'ADMIN'
                          ? AdminNavigationMenu(userModel: userModel)
                          : UserNavigationMenu(userModel: userModel);
                    }()
                  : const LoginScreen())
            : const OnBoardingScreen(),
      ),
    );
  }
}
