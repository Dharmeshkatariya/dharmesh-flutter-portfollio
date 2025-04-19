import 'dart:math';
import 'package:flutter/material.dart';

class CircularSpinner extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final double radius;
  final int totalLines;
  final Duration duration;

  const CircularSpinner({
    super.key,
    this.color = Colors.cyanAccent,
    this.strokeWidth = 4.0,
    this.radius = 40.0,
    this.totalLines = 60,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<CircularSpinner> createState() => _CircularSpinnerState();
}

class _CircularSpinnerState extends State<CircularSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: CircularSpinnerPainter(
              progress: _controller.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              radius: widget.radius,
              totalLines: widget.totalLines,
            ),
            size: const Size(100, 100),
          );
        },
      ),
    );
  }
}

class CircularSpinnerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final double radius;
  final int totalLines;

  CircularSpinnerPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.totalLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < totalLines; i++) {
      final double angle = (i / totalLines) * 2 * pi;
      final double alpha = (i / totalLines) + progress;

      final double startX = size.width / 2 + radius * cos(angle);
      final double startY = size.height / 2 + radius * sin(angle);

      final double endX = size.width / 2 + (radius + 10) * cos(angle);
      final double endY = size.height / 2 + (radius + 10) * sin(angle);

      paint.color = color.withOpacity((alpha % 1.0).clamp(0.3, 1));

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
