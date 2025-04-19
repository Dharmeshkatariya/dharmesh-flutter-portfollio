// Custom Clipper for Bottom Curve
import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);

    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 60, size.width, size.height - 20);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



class MyPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Define your custom clipping path
    path.lineTo(size.width * 0.52, size.height * 0.03);
    path.cubicTo(size.width * 0.52, size.height * 0.31, size.width * 0.3, size.height * 0.53, size.width * 0.02, size.height * 0.53);
    path.cubicTo(-0.25, size.height * 0.53, -0.48, size.height * 0.31, -0.48, size.height * 0.03);
    path.cubicTo(-0.48, -0.24, -0.25, -0.47, size.width * 0.02, -0.47);
    path.cubicTo(size.width * 0.3, -0.47, size.width * 0.52, -0.24, size.width * 0.52, size.height * 0.03);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // Return true if the path needs to be updated when UI changes
  }
}

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     Path path = Path();
//
//
//     // Path number 1
//
//
//     paint.color = Color(0xff7DE0EA);
//     path = Path();
//     path.lineTo(size.width * 0.52, size.height * 0.03);
//     path.cubicTo(size.width * 0.52, size.height * 0.31, size.width * 0.3, size.height * 0.53, size.width * 0.02, size.height * 0.53);
//     path.cubicTo(-0.25, size.height * 0.53, -0.48, size.height * 0.31, -0.48, size.height * 0.03);
//     path.cubicTo(-0.48, -0.24, -0.25, -0.47, size.width * 0.02, -0.47);
//     path.cubicTo(size.width * 0.3, -0.47, size.width * 0.52, -0.24, size.width * 0.52, size.height * 0.03);
//     canvas.drawPath(path, paint);
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }