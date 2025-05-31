import 'package:flutter/material.dart';
import 'dart:math';

class ShapeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final double animationRange;
  final Duration animationDuration;

  const ShapeAnimationWidget({
    Key? key,
    required this.child,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.purple,
    this.animationRange = 150.0,
    this.animationDuration = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  _ShapeAnimationWidgetState createState() => _ShapeAnimationWidgetState();
}

class _ShapeAnimationWidgetState extends State<ShapeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);

    _moveAnimation =
        Tween<double>(begin: -widget.animationRange, end: widget.animationRange)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Floating shapes
        // _buildAnimatedShape(
        //   shape: ShapeType.triangle,
        //   top: 100,
        //   left: 20,
        //   color: widget.primaryColor,
        //   size: 40,
        // ),
        _buildAnimatedShape(
          shape: ShapeType.circleRing,
          top: 100,
          left: 20,
          color: widget.primaryColor,
          size: 40,
        ),
        // _buildAnimatedShape(
        //   shape: ShapeType.hexagon,
        //   top: 50,
        //   right: 30,
        //   color: widget.primaryColor.withOpacity(0.5),
        //   size: 35,
        // ),
        _buildAnimatedShape(
          shape: ShapeType.square,
          top: 50,
          right: 30,
          color: widget.primaryColor.withOpacity(0.5),
          size: 35,
        ),


        // Main content
        Center(child: widget.child),
      ],
    );
  }

  Widget _buildAnimatedShape({
    required ShapeType shape,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Color color,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              _moveAnimation.value * (left != null || right != null ? 1 : 0),
              _moveAnimation.value * (top != null || bottom != null ? 1 : 0),
            ),
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: _buildShape(shape, color, size),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShape(ShapeType type, Color color, double size) {
    switch (type) {
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(size, size),
          painter: TrianglePainter(color: color),
        );
      case ShapeType.circleRing:
        return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 3),
            ));
      case ShapeType.hexagon:
        return CustomPaint(
          size: Size(size, size),
          painter: HexagonPainter(color: color),
        );
      case ShapeType.square:
        return CustomPaint(
          size: Size(size, size),
          painter: SquarePainter(color: color),
        );
      case ShapeType.wave:
        return CustomPaint(
          size: Size(size * 2, size),
          painter: WavePainter(color: color),
        );
    }
  }
}

enum ShapeType { triangle, circleRing, hexagon, square, wave }

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();

    double width = size.width;
    double height = size.height;

    path.moveTo(width * 0.5, 0);
    path.lineTo(width, height * 0.25);
    path.lineTo(width, height * 0.75);
    path.lineTo(width * 0.5, height);
    path.lineTo(0, height * 0.75);
    path.lineTo(0, height * 0.25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SquarePainter extends CustomPainter {
  final Color color;

  SquarePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Add rotated square inside
    Paint innerPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi / 4);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: size.width * 0.7,
        height: size.height * 0.7,
      ),
      innerPaint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    Path path = Path();
    path.moveTo(0, size.height / 2);

    for (double i = 0; i < size.width; i += 10) {
      path.quadraticBezierTo(
        i + 5,
        size.height / 2 + 15 * sin(i * 0.1),
        i + 10,
        size.height / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
