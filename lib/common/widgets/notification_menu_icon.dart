import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class REYNotificationCounterIcon extends StatelessWidget {
  const REYNotificationCounterIcon({
    super.key,
    required this.availableCount,
    required this.iconColor,
    required this.onPressed,
  });

  final int availableCount;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.notification, color: iconColor),
        ),
        availableCount == 0
            ? const SizedBox.shrink()
            : Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: REYColors.error,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      availableCount.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: REYColors.white,
                        fontSizeFactor: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
