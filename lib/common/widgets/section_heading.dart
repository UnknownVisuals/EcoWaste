import 'package:flutter/material.dart';

class REYSectionHeading extends StatelessWidget {
  const REYSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'Lihat semua',
    required this.title,
    this.showActionButton = false,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
      ],
    );
  }
}
