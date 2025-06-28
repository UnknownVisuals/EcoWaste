import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYTextFormFieldTheme {
  REYTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: REYColors.darkGrey,
    suffixIconColor: REYColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: REYSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: REYSizes.fontSizeMd,
      color: REYColors.black,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: REYSizes.fontSizeSm,
      color: REYColors.black,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: REYColors.black.withValues(alpha: 0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: REYColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: REYColors.darkGrey,
    suffixIconColor: REYColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: REYSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: REYSizes.fontSizeMd,
      color: REYColors.white,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: REYSizes.fontSizeSm,
      color: REYColors.white,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: REYColors.white.withValues(alpha: 0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: REYColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(REYSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: REYColors.warning),
    ),
  );
}
