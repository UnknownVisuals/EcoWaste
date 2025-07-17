import 'package:eco_waste/common/widgets/circular_container.dart';
import 'package:eco_waste/common/widgets/curved_edges_widget.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class REYPrimaryHeaderContainer extends StatelessWidget {
  const REYPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return REYCurvedEdgesWidget(
      child: Container(
        color: REYColors.primary,
        // if size.isFinite: is not true in Stack
        child: Stack(
          children: [
            // Background Shapes
            Positioned(
              top: -100,
              right: -250,
              child: REYCircularContainer(
                backgroundColor: REYColors.white.withValues(alpha: 0.2),
              ),
            ),
            Positioned(
              top: 100,
              right: -200,
              child: REYCircularContainer(
                backgroundColor: REYColors.white.withValues(alpha: 0.2),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
