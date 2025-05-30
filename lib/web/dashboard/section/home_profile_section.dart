import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_icons.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/string_file.dart';
import '../clipper/bottom_curve_clipper.dart';
import '../widget/animated_text_widget.dart';
import '../widget/triangle_animation_widget.dart';

class HomeProfileSection extends StatelessWidget {
  const HomeProfileSection(
      {super.key,
      required this.padding,
      required this.spaceBetweenItem,
      this.downloadCvButton,
      this.socialMedia});

  final EdgeInsetsGeometry padding;
  final double spaceBetweenItem;
  final Widget? downloadCvButton;
  final Widget? socialMedia;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return _profileInfo();
  }

  Widget _profileInfo() {
    return ClipPath(
        clipper: BottomCurveClipper(),
        child: Container(
          color: ColorFile.whiteColor,
          height: Common.isWebSize() ? 800.h : null,
          child: TriangleAnimationWidget(
            triangleColor: ColorFile.greenColor,
            circleBorderColor: ColorFile.greenColor,
            triangleSize: 50.h,
            circleSize: 60.h,
            animationRange: 130,
            animationDuration: const Duration(seconds: 5),
            child: Container(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _commonHeight(height: 50.h),
                  Common.isWebSize() ? _web() : _mobile(),
                  _commonHeight(height: 50.h),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _web() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _animatedText(),
              _commonHeight(),
              _commonHeight(),
              _descText(),
              _commonHeight(),
              _commonHeight(),
              if (downloadCvButton != null) ...[
                downloadCvButton ?? Container()
              ],
              if (socialMedia != null) ...[socialMedia ?? Container()],
            ],
          ),
        ),
        _commonWidth(width: spaceBetweenItem),
        _profileImg()
      ],
    );
  }

  Widget _mobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _animatedText(),
            _commonHeight(),
            _commonHeight(),
            _descText(),
            _commonHeight(),
            _commonHeight(),
            if (downloadCvButton != null) ...[downloadCvButton ?? Container()],
            if (socialMedia != null) ...[socialMedia ?? Container()],
          ],
        ),
        _profileImg()
      ],
    );
  }

  Widget _profileImg() {
    return Align(
      alignment: Common.isWebSize() ? Alignment.centerRight : Alignment.center,
      child: Container(
        width: 400.w,
        height: 400.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            AssetsIcons.homeBannerImage,
            fit: BoxFit.cover,
            width: 400.w,
            height: 400.h,
          ),
        ),
      ),
    );
  }

  Widget _animatedText() {
    return AnimatedTextWidget(
      texts: [
        StringFile.helloImDharmeshAhir,
        StringFile.iamFlutterDeveloper,
        StringFile.iLoveBuildingBeautifulUI,
        StringFile.animationMakeAppsMoreFun,
        StringFile.letCreateSomethingAwesome,
      ],
      duration: const Duration(seconds: 3),
    );
  }

  Widget _descText() {
    return CustomTextView(
      StringFile.userDesc,
      style: AppTextStyles.regularBlack16.copyWith(
          overflow: TextOverflow.visible, color: ColorFile.blackColor),
    );
  }

  Widget _commonHeight({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }

  Widget _commonWidth({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }
}
