import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart'; // For HapticFeedback

// Replace these with your actual classes/paths
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_icons.dart';
import '../../../utils/color_file.dart';
import '../../../utils/string_file.dart';
import '../dashboard_home_view_controller.dart';

class ThemeChooseWidget extends GetView<DashboardHomeViewController> {
  const ThemeChooseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          final controller = Get.find<DashboardHomeViewController>();
          return Positioned(
            top: 100.w,
            right: 20.h,
            child: GestureDetector(
              onTap: controller.toggleMenu,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animated Settings Button
                  _buildSettingsButton(),

                  // Theme Selection Menu
                  if (controller.isMenuVisible.value)
                    _buildThemeMenu(controller),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  Widget _buildSettingsButton() {
    final lottieWidget = Lottie.asset(
      AssetsIcons.settingAnimation,
      height: 45.h,
      width: 45.w,
      repeat: true,
    ) ?? const SizedBox(); // Fallback if Lottie fails

    final animatedLottie = lottieWidget.animate().rotate(
      duration: 5000.ms,
      begin: -0.1,
      end: 0.1,
      curve: Curves.easeInOutSine,
    );

    return ElasticIn(
      duration: 800.ms,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: ColorFile.whiteColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: animatedLottie,
      ).animate(
        onPlay: (controller) => controller.repeat(reverse: true),
      ).scale(
        duration: 1500.ms,
        begin: const Offset(1.0, 1.0),
        end: const Offset(1.05, 1.05),
        curve: Curves.easeInOutSine,
      ),
    );
  }
  Widget _buildThemeMenu(DashboardHomeViewController controller) {
    return FadeInRight(
      delay: 100.ms,
      duration: 500.ms,
      child: BounceInDown(
        duration: 600.ms,
        child: Container(
          width: 250.w,
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: _showThemeDialog(controller),
        ),
      ),
    );
  }

  Widget _showThemeDialog(DashboardHomeViewController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with Typing Effect
        _buildTitle(),
        SizedBox(height: 10.h),

        _buildColorGrid(controller),
      ],
    );
  }

  Widget _buildTitle() {
    return CustomTextView(
      StringFile.chooseColor,
      style: AppTextStyles.boldBlack14, // Make sure this style exists
    ).animate().fadeIn(duration: 300.ms).slideX(
      begin: 0.2,
      end: 0,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildColorGrid(DashboardHomeViewController controller) {
    return Obx(() {
      final themeColors = controller.themeColorsList;
      final selectedColor = controller.selectedColor;

      return Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          for (int i = 0; i < themeColors.length; i++)
            _buildColorCircle(themeColors[i], selectedColor.value, i, controller),
        ],
      );
    });
  }

  Widget _buildColorCircle(Color color, Color selectedColor, int index,
      DashboardHomeViewController controller) {
    final isSelected = selectedColor == color;

    return ElasticIn(
      delay: (100 + (index * 50)).ms,
      duration: 500.ms,
      child: GestureDetector(
        onTap: () {
          controller.changeColor(color);
          HapticFeedback.lightImpact();
        },
        child: AnimatedContainer(
          duration: 300.ms,
          width: 28.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: isSelected ? 3 : 0,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: color.withOpacity(0.8),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ]
                : null,
          ),
        ).animate(
          onPlay: (controller) {
            if (isSelected) {
              controller.repeat(reverse: true);
            } else {
              controller.stop();
            }
          },
        ).scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.2, 1.2),
          duration: 1000.ms,
        ),
      ),
    );
  }
}