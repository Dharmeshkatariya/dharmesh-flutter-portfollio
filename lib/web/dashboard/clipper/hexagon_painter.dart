import 'dart:math' as math;
import 'package:flutter/material.dart';

class HexagonPainter extends CustomPainter {
  final Color strokeColor;
  final double strokeWidth;

  HexagonPainter({
    this.strokeColor = Colors.blue,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Center & radius for a regular hex
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;

    final path = Path();

    // Generate 6 points of the hexagon
    for (int i = 0; i < 6; i++) {
      // Each side is 60 degrees apart
      double angle = (math.pi / 3) * i;
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    // Draw the hex outline
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
