import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import 'package:flutter/material.dart';

class AnimatedCustomButton extends StatelessWidget {
  const AnimatedCustomButton({
    super.key,
    this.assetIcons,
    required this.text,
    this.width = 130,
    this.height = 40, required this.onTap,
  });

  final String? assetIcons;
  final String text;
  final double width;
  final double height;
  final Function onTap ;

  @override
  Widget build(BuildContext context) {
    final RxBool isHovered = false.obs;
    final RxBool isPressed = false.obs;

    return Obx(() {
      return GestureDetector(
        onTap: (){
          onTap();
        },
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) => isPressed.value = false,
        onTapCancel: () => isPressed.value = false,
        child: MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: isPressed.value
                ? Matrix4.translationValues(5, 5, 0)
                : Matrix4.identity(),
            width: width.w,
            height: height.h,
            decoration: BoxDecoration(
              color: ColorFile.webThemeColor,
              borderRadius: BorderRadius.circular(7.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: isHovered.value ? width : -width,
                  top: isHovered.value ? -20 : 0,
                  child: Container(
                    width: width,
                    height: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (assetIcons != null && assetIcons!.isNotEmpty) ...[
                        SvgPicture.asset(
                          assetIcons!,
                          width: 16.w,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      CustomTextView(
                        text,
                        style: AppTextStyles.regularBlack16.copyWith(
                          overflow: TextOverflow.visible,
                          color: ColorFile.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}





class GradientAnimatedButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final List<Color> gradientColors;

  const GradientAnimatedButton({
    super.key,
    required this.text,
    this.width = 150,
    this.height = 50,
    this.textColor = Colors.black,
    this.gradientColors = const [Color(0xFF0FD850), Color(0xFFF9F047)],
  });

  @override
  State<GradientAnimatedButton> createState() => _GradientAnimatedButtonState();
}

class _GradientAnimatedButtonState extends State<GradientAnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.transparent,

        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: _isHovered ? 0 : -widget.width,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
