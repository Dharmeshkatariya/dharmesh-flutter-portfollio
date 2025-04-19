import 'package:flutter/material.dart';

class StepPainter extends CustomPainter {
  final Color circleColor;
  final Color borderColor;
  final String number;
  final IconData icon;

  StepPainter({
    required this.circleColor,
    required this.borderColor,
    required this.number,
    required this.icon,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = circleColor;
    Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    double radius = size.width / 2;

    // Draw Main Circle
    canvas.drawCircle(Offset(radius, radius), radius, paint);

    // Draw Circle Border
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);

    // Draw Number Circle
    Paint numberCirclePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.15), 15, numberCirclePaint);

    // Draw Number Text
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: number,
        style: TextStyle(color: borderColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width * 0.85 - textPainter.width / 2, size.height * 0.15 - textPainter.height / 2),
    );

    // Draw Icon
    TextPainter iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 40,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: borderColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();
    iconPainter.paint(
      canvas,
      Offset(radius - iconPainter.width / 2, radius - iconPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
