import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

class TriangleAnimationWidget extends StatefulWidget {
  final Widget child;
  final Color triangleColor;
  final Color circleBorderColor;
  final double triangleSize;
  final double circleSize;
  final double animationRange;
  final Duration animationDuration;

  const TriangleAnimationWidget({
    Key? key,
    required this.child,
    this.triangleColor = Colors.blue,
    this.circleBorderColor = Colors.blue,
    this.triangleSize = 40.0,
    this.circleSize = 50.0,
    this.animationRange = 150.0,
    this.animationDuration = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  _TriangleAnimationWidgetState createState() => _TriangleAnimationWidgetState();
}

class _TriangleAnimationWidgetState extends State<TriangleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _moveAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);

    _moveAnimation = Tween<double>(begin: -50, end: widget.animationRange).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: pi / 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
        Positioned(
          top: 100,
          left: 20,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_moveAnimation.value, 0),
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: _buildTriangle(),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 150,
          right: 40,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-_moveAnimation.value, 0),
                child: _buildCircleRing(),
              );
            },
          ),
        ),
        Center(child: widget.child),
      ],
    );
  }

  Widget _buildTriangle() {
    return CustomPaint(
      size: Size(widget.triangleSize, widget.triangleSize),
      painter: TrianglePainter(color: widget.triangleColor),
    );
  }

  Widget _buildCircleRing() {
    return Container(
      width: widget.circleSize,
      height: widget.circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: widget.circleBorderColor.withOpacity(0.4), width: 5),
      ),
    );
  }
}

// Triangle Shape Painter with Custom Color
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color.withOpacity(0.3);
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

//
// class TriangleAnimationWidget extends StatefulWidget {
//   final Widget child;
//
//   const TriangleAnimationWidget({Key? key, required this.child}) : super(key: key);
//
//   @override
//   _TriangleAnimationWidgetState createState() => _TriangleAnimationWidgetState();
// }
//
// class _TriangleAnimationWidgetState extends State<TriangleAnimationWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat(reverse: true);
//
//     _animation = Tween<double>(begin: -50, end: 150).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 100,
//           left: 20,
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Transform.translate(
//                 offset: Offset(_animation.value, 0),
//                 child: _buildTriangle(),
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 150,
//           right: 40,
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Transform.translate(
//                 offset: Offset(-_animation.value, 0),
//                 child: _buildCircleRing(),
//               );
//             },
//           ),
//         ),
//         Center(child: widget.child),
//       ],
//     );
//   }
//
//   Widget _buildTriangle() {
//     return CustomPaint(
//       size: const Size(40, 40),
//       painter: TrianglePainter(),
//     );
//   }
//
//   Widget _buildCircleRing() {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.blue.withOpacity(0.4), width: 5),
//       ),
//     );
//   }
// }
//
// // Triangle Shape Painter
// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.blue.withOpacity(0.3);
//     Path path = Path()
//       ..moveTo(size.width / 2, 0)
//       ..lineTo(0, size.height)
//       ..lineTo(size.width, size.height)
//       ..close();
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
