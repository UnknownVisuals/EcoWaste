import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYChipFilter extends StatelessWidget {
  const REYChipFilter({
    super.key,
    required this.chipFilterString,
    required this.chipFilterColor,
    required this.chipFilterIcon,
    this.isSelected = false,
    this.onTap,
  });

  final String chipFilterString;
  final Color chipFilterColor;
  final IconData chipFilterIcon;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
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
        backgroundColor: isSelected
            ? chipFilterColor
            : chipFilterColor.withValues(alpha: 0.3),
        side: isSelected
            ? BorderSide(color: chipFilterColor, width: 2)
            : BorderSide.none,
      ),
    );
  }
}
