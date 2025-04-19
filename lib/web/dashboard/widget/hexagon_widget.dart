import 'package:flutter/material.dart';

import '../clipper/hexagon_painter.dart';

class HexagonIconWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color borderColor;
  final double size;

  const HexagonIconWidget({
    super.key,
    required this.icon,
    required this.label,
    this.borderColor = Colors.blue,
    this.size = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter: HexagonPainter(
            strokeColor: borderColor,
            strokeWidth: 2.0,
          ),
          size: Size(size, size),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Icon(icon, size: size * 0.4, color: borderColor),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
