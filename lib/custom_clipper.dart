import 'package:flutter/material.dart';

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    final circlePath = Path();

    circlePath.addOval(Rect.fromCircle(center: Offset(w / 2, h / 2), radius: w / 2));

    path.lineTo(0, h / 2);
    path.lineTo(w, h / 2);
    path.lineTo(w, 0);
    path.close();

    path.addPath(circlePath, const Offset(0, 0));
    path.addPath(circlePath, const Offset(0, 0));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
