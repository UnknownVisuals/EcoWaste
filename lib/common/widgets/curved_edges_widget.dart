import 'package:eco_waste/common/widgets/curved_edges.dart';
import 'package:flutter/material.dart';

class REYCurvedEdgesWidget extends StatelessWidget {
  const REYCurvedEdgesWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: REYCustomCurvedEdges(), child: child);
  }
}
