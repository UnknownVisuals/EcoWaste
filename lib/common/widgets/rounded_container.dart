import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYRoundedContainer extends StatelessWidget {
  const REYRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.child,
    this.radius = REYSizes.cardRadiusLg,
    this.showBorder = false,
    this.backgroundColor = REYColors.white,
    this.borderColor = REYColors.borderPrimary,
  });

  final double? width, height;
  final EdgeInsetsGeometry? margin, padding;
  final Widget? child;
  final double radius;
  final bool showBorder;
  final Color backgroundColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: child,
    );
  }
}
