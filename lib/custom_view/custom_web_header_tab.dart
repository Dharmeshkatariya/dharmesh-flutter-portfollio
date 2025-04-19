import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_text_styles.dart';
import '../utils/color_file.dart';
import '../utils/constants_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_horizontal_pager.dart';
import 'custom_text.dart';

class CustomWebHeaderTab extends StatelessWidget {
  CustomWebHeaderTab(
      {required this.mList,
      required this.onTap,
      this.margin,
      this.selectedItem,
      this.padding,
      this.alignment,
      this.isShowCount = false,
      super.key});

  List<PagerModel> mList;
  PagerModel? selectedItem;
  Function(PagerModel) onTap;
  final bool isShowCount;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              mList.length,
              (index) {
                var item = mList[index];
                Color pagerTabColor = item.pagerTabColor;
                bool isTransparent = pagerTabColor == Colors.transparent;
                return isTransparent
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomGestureDetector(
                            onTap: () {
                              onTap(item);
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              decoration: (item == selectedItem)
                                  ? BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: ColorFile.webThemeColor,
                                              width: 3.h)),
                                    )
                                  : null,
                              child: Row(
                                children: [
                                  CustomText(
                                      item.displayText!,
                                      14.sp,
                                      (item == selectedItem)
                                          ? ColorFile.webThemeColor
                                          : ColorFile.lightBlack1Color,
                                      (item == selectedItem)
                                          ? ConstantsFile.semiBoldFont
                                          : ConstantsFile.regularFont),
                                  Visibility(
                                    visible: isShowCount,
                                    child: Obx(() {
                                      return CustomTextView(
                                        '(${item.count!.value})',
                                        style: (item == selectedItem)
                                            ? AppTextStyles.semiBoldBlack14
                                                .copyWith(
                                                    color:
                                                        ColorFile.webThemeColor)
                                            : AppTextStyles.regularBlack14
                                                .copyWith(
                                                color:
                                                    ColorFile.lightBlack1Color,
                                              ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (index < mList.length - 1)
                            SizedBox(
                              width: 40.w,
                            )
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomGestureDetector(
                            onTap: () {
                              onTap(item);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                              decoration: (item == selectedItem)
                                  ? BoxDecoration(
                                      // border: Border(
                                      //     bottom: BorderSide(
                                      //         color: ColorFile.webThemeColor,
                                      //         width: 3.h)),
                                color: ColorFile.webThemeColor,
                                    )
                                  : BoxDecoration(
                                      color: ColorFile.webThemeColor,
                                    ),
                              child: Row(
                                children: [
                                  CustomText(
                                      item.displayText!,
                                      14.sp,
                                      (item == selectedItem)
                                          ? ColorFile.whiteColor
                                          : ColorFile.whiteColor,
                                      (item == selectedItem)
                                          ? ConstantsFile.semiBoldFont
                                          : ConstantsFile.regularFont),
                                  Visibility(
                                    visible: isShowCount,
                                    child: Obx(() {
                                      return CustomTextView(
                                        '(${item.count!.value})',
                                        style: (item == selectedItem)
                                            ? AppTextStyles.semiBoldBlack14
                                                .copyWith(
                                                    color:
                                                        ColorFile.webThemeColor)
                                            : AppTextStyles.regularBlack14
                                                .copyWith(
                                                color:
                                                    ColorFile.lightBlack1Color,
                                              ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (index < mList.length - 1)
                            SizedBox(
                              width: 40.w,
                            )
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
