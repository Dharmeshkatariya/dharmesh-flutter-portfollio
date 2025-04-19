import 'package:flutter/material.dart';

class BlobPainter extends CustomPainter {
  final Color color;
  BlobPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();

    // A simple blob-like shape using quadratics
    // You can tweak control points to match your desired shape.
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
        size.width, 0, size.width, size.height * 0.4); // top-right curve
    path.quadraticBezierTo(
        size.width, size.height, size.width * 0.5, size.height); // bottom
    path.quadraticBezierTo(0, size.height, 0, size.height * 0.4); // bottom-left
    path.quadraticBezierTo(0, 0, size.width * 0.5, 0); // top-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
