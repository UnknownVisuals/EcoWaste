import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class REYShadowStyles {
  static final productCardShadow = BoxShadow(
    color: REYColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50.0,
    spreadRadius: 7.0,
    offset: const Offset(0, 2),
  );
}
