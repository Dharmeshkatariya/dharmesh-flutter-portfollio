import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class DottedArrowPainter extends CustomPainter {
  final Color lineColor;
  final bool showArrowHead;

  DottedArrowPainter({required this.lineColor, this.showArrowHead = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // 1. Define a curved path from left to right.
    //    Adjust the control points to match the shape you want.
    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.25, // control point X
          0,                // control point Y
          size.width * 0.5, // end X
          size.height * 0.5 // end Y
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height,
        size.width,
        size.height * 0.5,
      );

    // 2. Convert the path to metrics for drawing dashes.
    for (final metric in path.computeMetrics()) {
      final length = metric.length;
      const dashLength = 6;
      const dashSpace = 4;
      double start = 0;

      // 2a. Extract small path segments to create the dashed effect.
      while (start < length) {
        final end = math.min(start + dashLength, length);
        final extractPath = metric.extractPath(start, end);
        canvas.drawPath(extractPath, paint);
        start += dashLength + dashSpace;
      }

      // 2b. Optionally, draw an arrowhead at the end of the path.
      if (showArrowHead) {
        final tangent = metric.getTangentForOffset(length);
        if (tangent != null) {
          _drawArrowHead(canvas, tangent, paint);
        }
      }
    }
  }

  // Helper method to draw a small arrowhead.
  void _drawArrowHead(Canvas canvas, Tangent tangent, Paint paint) {
    final arrowSize = 10.0;
    final angle = tangent.angle;
    final position = tangent.position;

    // Define a simple 'V' shape for the arrowhead.
    final path = Path()
      ..moveTo(position.dx, position.dy)
      ..lineTo(
        position.dx - arrowSize * math.cos(angle - math.pi / 6),
        position.dy - arrowSize * math.sin(angle - math.pi / 6),
      )
      ..moveTo(position.dx, position.dy)
      ..lineTo(
        position.dx - arrowSize * math.cos(angle + math.pi / 6),
        position.dy - arrowSize * math.sin(angle + math.pi / 6),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DottedArrowPainter oldDelegate) => false;
}
