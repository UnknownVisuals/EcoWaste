import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class REYIconButton extends StatelessWidget {
  const REYIconButton({
    super.key,
    required this.icon,
    required this.title,
    this.color = REYColors.white,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: REYSizes.iconLg, color: color),
          const SizedBox(height: REYSizes.sm / 2),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: color),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
