import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';

import '../../../utils/color_file.dart';

class CursorController extends GetxController {
  Rx<Offset> position = Offset.zero.obs;
  RxBool isHovering = false.obs;

  void updatePosition(Offset newPosition) {
    position.value = newPosition;
    isHovering.value = true;
  }

  void stopHover() {
    isHovering.value = false;
  }
}

class CustomCursor extends StatelessWidget {
  final Widget child;

  const CustomCursor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cursorController = Get.put(CursorController());

    return Stack(
      children: [
        MouseRegion(
          onHover: (event) => cursorController.updatePosition(event.position),
          onExit: (_) => cursorController.stopHover(),
          child: child,
        ),
        Obx(() {
          if (!cursorController.isHovering.value) {
            return const SizedBox.shrink();
          }
          return Positioned(
            left: cursorController.position.value.dx - 15,
            top: cursorController.position.value.dy - 15,
            child: Pulse(
              duration: const Duration(milliseconds: 500),
              child: CustomPaint(
                painter: CursorPainter(),
                size: const Size(30, 30),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class CursorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorFile.webThemeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset.zero), size.width / 1, paint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Watch\nVideo',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    textPainter.paint(
      canvas,
      size.center(Offset.zero) - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

