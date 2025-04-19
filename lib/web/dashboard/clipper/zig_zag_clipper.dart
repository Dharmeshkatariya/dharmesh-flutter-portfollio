import 'package:flutter/material.dart';

class ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);

    for (double i = 0; i < size.width; i += size.width / 6) {
      path.lineTo(i + size.width / 12, size.height);
      path.lineTo(i + size.width / 6, size.height - 20);
    }

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
