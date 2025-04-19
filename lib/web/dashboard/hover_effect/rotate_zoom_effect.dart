import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RotateZoomEffect extends StatelessWidget {
  final Widget child;

  RotateZoomEffect({super.key, required this.child});

  final RxBool _isHovered = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: Obx(
            () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: _isHovered.value
              ? (Matrix4.identity()
            ..scale(1.05)
            ..rotateZ(0.05))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: _isHovered.value
                ? [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 15.0,
                spreadRadius: 3.0,
                offset: Offset(0, 6),
              )
            ]
                : [],
          ),
          child: child,
        ),
      ),
    );
  }
}
