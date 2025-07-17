import 'package:flutter/material.dart';

class REYCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double curveWidth = 30;
    const double curveHeight = 20;

    var path = Path();

    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - curveHeight);
    final lastCurve = Offset(curveWidth, size.height - curveHeight);

    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    final secondFirstCurve = Offset(0, size.height - curveHeight);
    final secondLastCurve = Offset(
      size.width - curveWidth,
      size.height - curveHeight,
    );

    path.quadraticBezierTo(
      secondFirstCurve.dx,
      secondFirstCurve.dy,
      secondLastCurve.dx,
      secondLastCurve.dy,
    );

    final thirdFirstCurve = Offset(size.width, size.height - curveHeight);
    final thirdLastCurve = Offset(size.width, size.height);

    path.quadraticBezierTo(
      thirdFirstCurve.dx,
      thirdFirstCurve.dy,
      thirdLastCurve.dx,
      thirdLastCurve.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
