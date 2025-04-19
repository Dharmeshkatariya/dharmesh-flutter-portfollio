

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedBackgroundShapes extends StatefulWidget {
  final Widget child; // Accept a child widget
  final Duration animationDuration;
  final double animationRange;

  const AnimatedBackgroundShapes({
    super.key,
    required this.child,
    this.animationRange = 150.0,
    this.animationDuration = const Duration(seconds: 4),
  });

  @override
  _AnimatedBackgroundShapesState createState() =>
      _AnimatedBackgroundShapesState();
}

class _AnimatedBackgroundShapesState extends State<AnimatedBackgroundShapes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _rotationAnimation;
  late List<AnimatedShape> shapes;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);
    _moveAnimation =
        Tween<double>(begin: -50, end: widget.animationRange).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: pi / 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Generate random shapes
    shapes = List.generate(8, (index) {
      return AnimatedShape(
        leftStart: Random().nextDouble() * 800.w,
        topStart: Random().nextDouble() * 600.w,
        size: Random().nextDouble() * 50 + 30,
        type: index % 2 == 0 ? ShapeType.circle : ShapeType.triangle,
        animation: Tween<double>(begin: -1, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated Shapes in the Background
        ...shapes.map((shape) => Positioned(
              left: shape.leftStart + (sin(shape.animation.value * pi) * 50),
              top: shape.topStart + (cos(shape.animation.value * pi) * 30),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_moveAnimation.value, 0),
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: SizedBox(
                        width: shape.size,
                        height: shape.size,
                        child: CustomPaint(
                          painter: ShapePainter(shape.type),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),

        // Overlay Child Widget
        Center(child: widget.child),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Enum for Shape Type
enum ShapeType { circle, triangle }

// Shape Painter
class ShapePainter extends CustomPainter {
  final ShapeType type;

  ShapePainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue.withOpacity(0.3);

    if (type == ShapeType.circle) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), size.width / 2, paint);
    } else {
      Path path = Path()
        ..moveTo(size.width / 2, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Shape Data Class
class AnimatedShape {
  final double leftStart;
  final double topStart;
  final double size;
  final ShapeType type;
  final Animation<double> animation;

  AnimatedShape({
    required this.leftStart,
    required this.topStart,
    required this.size,
    required this.type,
    required this.animation,
  });
}
