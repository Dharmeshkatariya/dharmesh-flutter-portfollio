import 'package:flutter/material.dart';

enum SlideDirection { left, right, up, down }

class SlideTransitionWrapper extends StatelessWidget {
  final Widget child;
  final SlideDirection direction;
  final AnimationController controller;
  final Curve curve;
  final double offsetMultiplier;

  const SlideTransitionWrapper({
    super.key,
    required this.child,
    required this.direction,
    required this.controller,
    this.curve = Curves.easeInOut,
    this.offsetMultiplier = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: _getSlideOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    return SlideTransition(
      position: slideAnimation,
      child: child,
    );
  }

  Offset _getSlideOffset() {
    switch (direction) {
      case SlideDirection.left:
        return Offset(-offsetMultiplier, 0);
      case SlideDirection.right:
        return Offset(offsetMultiplier, 0);
      case SlideDirection.up:
        return Offset(0, offsetMultiplier);
      case SlideDirection.down:
        return Offset(0, -offsetMultiplier);
    }
  }
}

//   class SlideTransitionWrapper extends StatelessWidget {
//   final Widget child;
//   final SlideDirection direction;
//   final AnimationController controller;
//   final Curve curve;
//   final double offsetMultiplier;
//
//   const SlideTransitionWrapper({
//     super.key,
//     required this.child,
//     required this.direction,
//     required this.controller,
//     this.curve = Curves.easeInOut,
//     this.offsetMultiplier = 1.5,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Animation<Offset> slideAnimation = Tween<Offset>(
//       begin: direction == SlideDirection.left
//           ? Offset(-offsetMultiplier, 0)
//           : Offset(offsetMultiplier, 0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: controller, curve: curve));
//
//     return SlideTransition(
//       position: slideAnimation,
//       child: child,
//     );
//   }
// }

// enum SlideDirection { left, right }
//
// class SlideTransitionWrapper extends StatelessWidget {
//   final Widget child;
//   final SlideDirection direction;
//   final AnimationController controller;
//   final Curve curve;
//   final double offsetMultiplier;
//
//   const SlideTransitionWrapper({
//     super.key,
//     required this.child,
//     required this.direction,
//     required this.controller,
//     this.curve = Curves.easeInOut,
//     this.offsetMultiplier = 1.5,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Animation<Offset> slideAnimation = Tween<Offset>(
//       begin: direction == SlideDirection.left
//           ? Offset(-offsetMultiplier, 0)
//           : Offset(offsetMultiplier, 0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: controller, curve: curve));
//
//     return SlideTransition(
//       position: slideAnimation,
//       child: child,
//     );
//   }
// }
