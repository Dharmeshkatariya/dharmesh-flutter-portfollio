import 'package:flutter/cupertino.dart';

class DoubleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height - 40);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 80, size.width, size.height - 40);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
