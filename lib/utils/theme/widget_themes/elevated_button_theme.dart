import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/* -- Light & Dark Elevated Button Themes -- */
class REYElevatedButtonTheme {
  REYElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: REYColors.light,
      backgroundColor: REYColors.primary,
      disabledForegroundColor: REYColors.darkGrey,
      disabledBackgroundColor: REYColors.buttonDisabled,
      side: const BorderSide(color: REYColors.primary),
      textStyle: const TextStyle(
        fontSize: 16,
        color: REYColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: REYSizes.buttonHeight,
        horizontal: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(REYSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: REYColors.light,
      backgroundColor: REYColors.primary,
      disabledForegroundColor: REYColors.darkGrey,
      disabledBackgroundColor: REYColors.darkerGrey,
      side: const BorderSide(color: REYColors.primary),
      textStyle: const TextStyle(
        fontSize: 16,
        color: REYColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: REYSizes.buttonHeight,
        horizontal: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(REYSizes.buttonRadius),
      ),
    ),
  );
}
