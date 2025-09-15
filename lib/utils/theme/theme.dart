import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/theme/widget_themes/appbar_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/chip_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/text_field_theme.dart';
import 'package:eco_waste/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class REYAppTheme {
  REYAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: REYColors.primary,
      brightness: Brightness.light,
    ).copyWith(surface: REYColors.white, onSurface: REYColors.black),
    disabledColor: REYColors.grey,
    textTheme: REYTextTheme.lightTextTheme,
    chipTheme: REYChipTheme.lightChipTheme,
    scaffoldBackgroundColor: REYColors.white,
    appBarTheme: REYAppBarTheme.lightAppBarTheme,
    checkboxTheme: REYCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: REYBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: REYElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: REYOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: REYTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: REYColors.primary,
      brightness: Brightness.dark,
    ).copyWith(surface: REYColors.dark, onSurface: REYColors.white),
    disabledColor: REYColors.grey,
    textTheme: REYTextTheme.darkTextTheme,
    chipTheme: REYChipTheme.darkChipTheme,
    scaffoldBackgroundColor: REYColors.black,
    appBarTheme: REYAppBarTheme.darkAppBarTheme,
    checkboxTheme: REYCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: REYBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: REYElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: REYOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: REYTextFormFieldTheme.darkInputDecorationTheme,
  );
}
