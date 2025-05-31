import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_icons.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/string_file.dart';
import '../animation/shape_animation.dart';
import '../clipper/step_painter.dart';
import '../hover_effect/lift_shadow_effect.dart';
import '../widget/triangle_animation_widget.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key, required this.padding});

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return ShapeAnimationWidget(
      primaryColor: ColorFile.webThemeColor,
      secondaryColor: ColorFile.webSecondThemeColor,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextView(StringFile.howItWorks,
                style: AppTextStyles.boldBlack28),
            SizedBox(height: 10.h),
            CustomTextView(
              StringFile.threeSimpleStepsToStartYourWorkingProcess,
              textAlign: TextAlign.center,
              style: AppTextStyles.regularBlack14,
            ),
            SizedBox(height: 20.h),
            Container(
                padding: padding,
                child: _buildStepsLayout(isWeb: Common.isWebSize())),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsLayout({required bool isWeb}) {
    List<Widget> steps = [
      _buildStep(
        "01",
        AssetsIcons.marketingAnimation,
        StringFile.planningTitle,
        StringFile.planningDescription,
      ),
      _buildStep(
        "02",
        AssetsIcons.webDesignAnimation,
        StringFile.developmentTitle,
        StringFile.developmentDescription,
      ),
      _buildStep(
        "03",
        AssetsIcons.launchingAnimation,
        StringFile.launchingTitle,
        StringFile.launchingDescription,
      ),
    ];

    return isWeb
        ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        steps.length * 2 - 1,
            (index) => index.isEven
            ? Expanded(child: steps[index ~/ 2])
            : SizedBox(width: 20.w),
      ),
    )
        : Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        steps.length * 2 - 1,
            (index) => index.isEven
            ? steps[index ~/ 2]
            : SizedBox(height: 20.h),
      ),
    );
  }

  Widget _buildStep(
      String number, String animationPath, String title, String description) {
    return LiftShadowEffect(
      child: BorderContainer(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Lottie.asset(
                      animationPath,
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextView(title, style: AppTextStyles.semiBoldBlack18),
            const SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: CustomTextView(
                description,
                textAlign: TextAlign.center,
                style: AppTextStyles.regularBlack14
                    .copyWith(color: ColorFile.grayColor),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}