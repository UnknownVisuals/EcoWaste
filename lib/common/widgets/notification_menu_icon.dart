import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class REYNotificationCounter extends StatelessWidget {
  const REYNotificationCounter({
    super.key,
    required this.child,
    this.badgeCount = 0,
    this.showBadgeWhenZero = false,
  });

  final Widget child;
  final int badgeCount;
  final bool showBadgeWhenZero;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 2),
      showBadge: showBadgeWhenZero ? true : badgeCount > 0,
      badgeContent: Text(
        badgeCount.toString(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      badgeAnimation: badges.BadgeAnimation.scale(
        animationDuration: const Duration(milliseconds: 100),
        curve: Curves.elasticInOut,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: REYColors.error,
        padding: const EdgeInsets.all(6),
      ),
      child: child,
    );
  }
}
