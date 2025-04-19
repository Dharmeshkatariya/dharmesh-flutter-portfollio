import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vikram_portfollio_dark/web/dashboard/animation/slide_animation.dart';

import '../../../utils/common.dart';

class LeftRightSlideAnimation extends StatefulWidget {
  final ScrollController scrollController;
  final Widget? leftChild;
  final Widget? rightChild;
  final double? spaceBetweenItem;

  const LeftRightSlideAnimation({
    super.key,
    required this.scrollController,
    this.leftChild,
    this.rightChild,
    this.spaceBetweenItem,
  });

  @override
  State<LeftRightSlideAnimation> createState() =>
      _LeftRightSlideAnimationState();
}

class _LeftRightSlideAnimationState extends State<LeftRightSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  void _handleScroll() {
    if (widget.scrollController.position.pixels > 50) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    _animationController.dispose();
    super.dispose();
  }

  Widget _commonWidth({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    if (widget.leftChild != null &&
        widget.rightChild != null &&
        widget.spaceBetweenItem != null) {
      return Common.isWebSize()
          ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SlideTransitionWrapper(
                  direction: SlideDirection.left,
                  controller: _animationController,
                  child: widget.leftChild!,
                ),
                _commonWidth(width: widget.spaceBetweenItem),
                SlideTransitionWrapper(
                  direction: SlideDirection.right,
                  controller: _animationController,
                  child: widget.rightChild!,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransitionWrapper(
                  direction: SlideDirection.left,
                  controller: _animationController,
                  child: widget.leftChild!,
                ),
                SizedBox(height: widget.spaceBetweenItem),
                SlideTransitionWrapper(
                  direction: SlideDirection.right,
                  controller: _animationController,
                  child: widget.rightChild!,
                ),
              ],
            );
    } else if (widget.leftChild != null) {
      return SlideTransitionWrapper(
        direction: SlideDirection.left,
        controller: _animationController,
        child: widget.leftChild!,
      );
    } else if (widget.rightChild != null) {
      return SlideTransitionWrapper(
        direction: SlideDirection.right,
        controller: _animationController,
        child: widget.rightChild!,
      );
    } else {
      return Container();
    }
  }
}

// class LeftRightSlideAnimation extends StatefulWidget {
//   final ScrollController scrollController;
//   final Widget leftChild;
//   final Widget rightChild;
//   final double spaceBetweenItem;
//
//   const LeftRightSlideAnimation({
//     super.key,
//     required this.scrollController,
//     required this.leftChild,
//     required this.rightChild, required this.spaceBetweenItem,
//   });
//
//   @override
//   State<LeftRightSlideAnimation> createState() =>
//       _LeftRightSlideAnimationState();
// }
//
// class _LeftRightSlideAnimationState extends State<LeftRightSlideAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.scrollController.addListener(_handleScroll);
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//   }
//
//   void _handleScroll() {
//     if (widget.scrollController.position.pixels > 50) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//   }
//
//   @override
//   void dispose() {
//     widget.scrollController.removeListener(_handleScroll);
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: SlideTransitionWrapper(
//             direction: SlideDirection.left,
//             controller: _animationController,
//             child: widget.leftChild,
//           ),
//         ),
//         _commonWidth(width: widget.spaceBetweenItem),
//         SlideTransitionWrapper(
//           direction: SlideDirection.right,
//           controller: _animationController,
//           child: widget.rightChild,
//         ),
//       ],
//     );
//   }
//
//   Widget _commonWidth({double? width}) {
//     return SizedBox(width: width ?? 10.w);
//   }
//
// }
