import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class REYChipTheme {
  REYChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: REYColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: REYColors.black),
    selectedColor: REYColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: REYColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: REYColors.darkerGrey,
    labelStyle: TextStyle(color: REYColors.white),
    selectedColor: REYColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: REYColors.white,
  );
}
