import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYChipFilter extends StatelessWidget {
  const REYChipFilter({
    super.key,
    required this.chipFilterString,
    required this.chipFilterColor,
    required this.chipFilterIcon,
  });

  final String chipFilterString;
  final Color chipFilterColor;
  final IconData chipFilterIcon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        chipFilterIcon,
        color: REYColors.white,
        size: REYSizes.iconSm,
      ),
      label: Text(
        chipFilterString,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: REYColors.white),
      ),
      backgroundColor: chipFilterColor,
    );
  }
}
