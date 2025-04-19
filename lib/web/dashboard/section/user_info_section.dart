import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/string_file.dart';
import '../animation/left_right_slide_animation.dart';
import '../clipper/bottom_curve_clipper.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection(
      {super.key,
      required this.padding,
      this.downloadCvButton,
      this.profileCard,
      required this.spaceBetweenItem,
      required this.scrollController});

  final EdgeInsetsGeometry padding;
  final Widget? downloadCvButton;
  final Widget? profileCard;
  final double spaceBetweenItem;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return _userExpInfo();
  }

  Widget _userExpInfo() {
    return ClipPath(
        clipper: BottomCurveClipper(),
        child: Container(
          height: Common.isWebSize() ? 450.h : null,
          child: BorderContainer(
            width: double.infinity,
            padding: padding,
            color: ColorFile.transparentColor,
            child: Column(
              children: [Common.isWebSize() ? _web() : _web()],
            ),
          ),
        ));
  }

  Widget _web() {
    return LeftRightSlideAnimation(
        scrollController: scrollController,
        leftChild: profileCard ?? Container(),
        rightChild: _commonView(),
        spaceBetweenItem: spaceBetweenItem);
  }

  Widget _commonView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _professinal(),
        _commonHeight(height: 20.h),
        _userExperience(),
        _commonHeight(height: 20.h),
        if (downloadCvButton != null) ...[downloadCvButton ?? Container()],
        _commonHeight(height: 40.h),
      ],
    );
  }

  Widget _professinal() {
    return CustomTextView(
      StringFile.imProfessionalUserExperienceDesigner,
      style: AppTextStyles.semiBoldBlack40
          .copyWith(color: ColorFile.webThemeColor),
    );
  }

  Widget _userExperience() {
    return CustomTextView(
      StringFile.userExperience,
      style: AppTextStyles.regularBlack16.copyWith(
        overflow: TextOverflow.visible,
      ),
    );
  }

  Widget _commonHeight({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }
}
