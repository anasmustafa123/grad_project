import 'package:flutter/cupertino.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height-20),
        lastCurve = Offset(20, size.height-20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);
    final firstStraightLine = Offset(20, size.height-20),
        lastStraightLine = Offset(size.width-20, size.height-20);
    path.quadraticBezierTo(
        firstStraightLine.dx, firstStraightLine.dy, lastStraightLine.dx, lastStraightLine.dy);
    final firstSecondCurve = Offset(size.width, size.height-20),
        lastSecondCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
        firstSecondCurve.dx, firstSecondCurve.dy, lastSecondCurve.dx, lastSecondCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
