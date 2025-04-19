import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
          return Positioned(
            top: 100.w,
            right: 20.h,
            child: GestureDetector(
              onTap: controller.toggleMenu,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: const BoxDecoration(
                      color: ColorFile.whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Lottie.asset(
                      AssetsIcons.settingAnimation,
                      height: 45.h,
                      width: 45.w,
                      repeat: true,
                    ),
                  ),
                  if (controller.isMenuVisible.value) ...[
                    SizedBox(width: 20.w),
                    AnimatedOpacity(
                      opacity: controller.isMenuVisible.value ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 250.w,
                          padding: EdgeInsets.all(16.w),
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
                    )
                  ]
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  Widget _showThemeDialog(DashboardHomeViewController controller) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextView(StringFile.chooseColor,
              style: AppTextStyles.boldBlack14),
          SizedBox(height: 10.h),
          Obx(() => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (Color color in controller.themeColorsList.value)
                    GestureDetector(
                      onTap: () => controller.changeColor(color),
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.selectedColor.value == color
                                ? Colors.white
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    )
                ],
              )),
        ],
      ),
    );
  }
}
