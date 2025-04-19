
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../custom_view/custom_text.dart';
import '../../utils/color_file.dart';
import '../../utils/common.dart';
import '../enum/enum_web_size_type.dart';
import '../utils/constants_file.dart';
import 'custom_gesture_detector.dart';

class WebCustomButtonWithBG extends StatelessWidget {
  final String text;
  final int height;
  double? width;
  final Color? bgColor;
  final VoidCallback onTaped;
  final EdgeInsetsGeometry? padding;
  final bool isDisableButton ;


  WebCustomButtonWithBG(this.text, this.height, this.onTaped,
      {this.width, this.padding, this.bgColor, this.isDisableButton=false ,Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      semanticsLabel: text,
      onTap: () {
        onTaped();
      },
      child: Container(
        height: height.h,
        width: width,
        padding: padding ?? EdgeInsets.only(left: 16.w, right: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isDisableButton ? ColorFile.greyColorOpaque20 :bgColor?? ColorFile.webThemeColor,
            borderRadius: BorderRadius.all(Radius.circular(7.r))),
        child: CustomText(
          text,
          Common.webSizeType > EnumWebSizeType.mediumSizeWeb.webSizeType
              ? 14.sp
              : 13.sp,
          ColorFile.whiteColor,
          // ConstantsFile.semiBoldFont,
          ConstantsFile.regularFont,
        ),
      ),
    );
  }
}

class WebCustomButtonLoading extends StatelessWidget {
  final int height;
  final double? width;
  const WebCustomButtonLoading(this.height, {Key? key, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorFile.webThemeColor,
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      child: SizedBox(
          height: 24.h,
          width: 24.h,
          child: CircularProgressIndicator(
            color: ColorFile.whiteColor,
          )),
    );
  }
}

// ignore: must_be_immutable
class WebCustomButtonWithIcon extends StatelessWidget {
  final String text;
  final int height;
  double? width;
  String assetIcon;
  Function()? onTap;
  double? iconSize;
  Color? bgColor;
  Color? iconColor;
  Color? textColor;
  AlignmentGeometry?  alignment;
  Border? border;
  WebCustomButtonWithIcon(this.text, this.height, this.onTap, this.assetIcon,
      {this.width,this.iconSize,this.textColor,this.iconColor,this.bgColor,this.alignment,this.border, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CustomGestureDetector(
        onTap: onTap,
        child: Container(
            height: height.w,
            width: width,
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:bgColor?? ColorFile.webThemeColor,
                border: border,
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            child: Align(
              alignment: alignment??Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    assetIcon,
                    height: iconSize?? 24.h,
                    width:iconSize?? 24.h,
                    colorFilter:
                    ColorFilter.mode(iconColor??ColorFile.whiteColor, BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  CustomText(
                      text,
                      Common.webSizeType >
                          EnumWebSizeType.mediumSizeWeb.webSizeType
                          ? 14.sp
                          : 13.sp,
                      textColor??ColorFile.whiteColor,
                      ConstantsFile.semiBoldFont),
                ],
              ),
            )),
      ),
    );
  }
}

class WebCustomButtonWithSuffixIcon extends StatelessWidget {
  final String text;
  final int height;
  final double? width;
  final String assetIcon;
  final Function()? onTap;

  const WebCustomButtonWithSuffixIcon(
      {super.key,
        required this.text,
        required this.height,
        this.width,
        required this.assetIcon,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height.w,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorFile.webThemeColor,
            borderRadius: BorderRadius.all(Radius.circular(7.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text,
                  Common.isWebSize() ? 14.sp : 13.sp,
                  ColorFile.whiteColor,
                  ConstantsFile.semiBoldFont,
                ),
              ),
              SizedBox(width: 12.sp),
              SvgPicture.asset(
                assetIcon,
                height: 20.h,
                width: 20.h,
                colorFilter: ColorFilter.mode(
                  ColorFile.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
