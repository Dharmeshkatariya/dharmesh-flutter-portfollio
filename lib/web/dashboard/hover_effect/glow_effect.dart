
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ColorGlowEffect extends StatelessWidget {
  final Widget child;

  ColorGlowEffect({super.key, required this.child});

  final RxBool _isHovered = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: Obx(
            () => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _isHovered.value ? Colors.blue.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: _isHovered.value
                ? [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 20.0,
                spreadRadius: 5.0,
                offset: Offset(0, 4),
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
