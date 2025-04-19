import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vikram_portfollio_dark/web/dashboard/animation/slide_animation.dart';

class VisibilityAnimationWrapper extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration animationDuration;

  const VisibilityAnimationWrapper({
    super.key,
    required this.child,
    required this.direction,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  _VisibilityAnimationWrapperState createState() => _VisibilityAnimationWrapperState();
}

class _VisibilityAnimationWrapperState extends State<VisibilityAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Initial check after first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenHeight = MediaQuery.of(context).size.height;

      // Check if the vertical center of this widget is within the visible screen.
      final widgetCenter = position.dy + size.height / 2;
      if (widgetCenter >= 0 && widgetCenter <= screenHeight) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
    return Container(
      key: _key,
      child: SlideTransitionWrapper(
        direction: widget.direction,
        controller: _controller,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}