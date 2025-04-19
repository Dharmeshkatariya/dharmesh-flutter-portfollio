import 'package:flutter/material.dart';

class DeepWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);

    path.quadraticBezierTo(
        size.width * 0.2, size.height, size.width * 0.4, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.6, size.height - 80, size.width * 0.8, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.9, size.height, size.width, size.height - 50);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
