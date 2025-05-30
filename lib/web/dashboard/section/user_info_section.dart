import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vikram_portfollio_dark/custom_view/custom_info_widget.dart';
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
          constraints: Common.isWebSize()
              ? BoxConstraints(
                  minHeight: 500.h,
                  maxWidth: double.infinity,
                )
              : null,
          // height: Common.isWebSize() ? 450.h : null,
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 300.w,
        maxWidth: 600.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _professinal(),
          SizedBox(height: 20.h),
          _userExperience(),
          SizedBox(height: 20.h),
          if (downloadCvButton != null) downloadCvButton!,
          SizedBox(height: 40.h),
        ],
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(StringFile.introPart1),
        _buildParagraph(StringFile.introPart2),
        const SizedBox(height: 24),
        CustomTextView(
          StringFile.strengthsHeader,
          style: AppTextStyles.regularBlack16.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        CustomInfoWidget(
          items: StringFile.strengthsBulletPoints,
          textStyle: AppTextStyles.regularBlack16,
          bulletColor: ColorFile.webThemeColor,
        ),
        const SizedBox(height: 24),

        // Closing
        _buildParagraph(StringFile.closingPart1),
        _buildParagraph(StringFile.closingPart2),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return CustomInfoWidget(
      items: [text], // Single item list
      isBulletList: false, // No bullets for paragraphs
      textStyle: AppTextStyles.regularBlack16,
      spacing: 12,
    );
  }

  Widget _commonHeight({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }
}
