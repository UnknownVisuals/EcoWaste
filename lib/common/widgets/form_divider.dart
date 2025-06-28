import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class REYFormDivider extends StatelessWidget {
  const REYFormDivider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? REYColors.darkGrey : REYColors.darkerGrey,
            thickness: 0.5,
            indent: 30,
            endIndent: 10,
          ),
        ),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium),
        Flexible(
          child: Divider(
            color: dark ? REYColors.darkGrey : REYColors.darkerGrey,
            thickness: 0.5,
            indent: 10,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}
