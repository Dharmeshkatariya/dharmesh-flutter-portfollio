import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../model/skill_progress_model.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import 'dart:ui';
import '../../../utils/common.dart';
import '../../../utils/string_file.dart';
import '../clipper/wave_clipper.dart';
import '../widget/skill_progress.dart';
import '../widget/triangle_animation_widget.dart';

class ModernWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double height = size.height;
    double width = size.width;

    path.lineTo(0, height * 0.8); // Start from bottom-left
    path.quadraticBezierTo(width * 0.25, height, width * 0.5, height * 0.85);
    path.quadraticBezierTo(width * 0.75, height * 0.7, width, height * 0.8);
    path.lineTo(width, 0); // Top-right
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}

class AdvancedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height * 0.7);
    path.quadraticBezierTo(
        width * 0.25,
        height * 0.9, // Control point
        width * 0.5,
        height * 0.75 // End point
        );

    path.quadraticBezierTo(width * 0.75, height * 0.6, width, height * 0.7);

    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}

class TechnicalSkillSection extends StatelessWidget {
  const TechnicalSkillSection(
      {super.key,
      required this.padding,
      required this.technicalSkillList,
      required this.scrollController});

  final RxList<SkillProgressModel> technicalSkillList;
  final EdgeInsetsGeometry padding;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return _skillsSection(context);
  }


  Widget _skillsSection(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 100.h,
            color: ColorFile.whiteColor,
          ),
        ),
        TriangleAnimationWidget(
          child: BorderContainer(
            width: double.infinity,
            color: ColorFile.transparentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                CustomTextView(StringFile.whatCanIDo,
                    style: AppTextStyles.boldBlack28),
                SizedBox(height: 10.h),
                CustomTextView(
                  StringFile.technicalSkills,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regularBlack18,
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 20.w,
                  runSpacing: 15.h,
                  children: technicalSkillList
                      .map((SkillProgressModel skill) => SizedBox(
                            width: Common.isWebSize()
                                ? MediaQuery.of(context).size.width * 0.45
                                : MediaQuery.of(context).size.width *
                                    0.95, // Adjust width dynamically
                            child: SkillProgressBar(
                              skillName: skill.skillName ?? "",
                              percentage: skill.percentage ?? 0.0,
                                progressColor : skill.progressColor ?? ColorFile.webThemeColor
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
