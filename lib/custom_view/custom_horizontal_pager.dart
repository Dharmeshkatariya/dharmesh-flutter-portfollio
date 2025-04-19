import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_text_styles.dart';
import '../utils/color_file.dart';
import '../utils/constants_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_text.dart';

class CustomHorizontalPager extends StatelessWidget {
  CustomHorizontalPager(
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
      padding:padding?? EdgeInsets.only(top: 24.h),
      width:  double.infinity,
      child: Align(
        alignment:alignment??Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: List.generate(
              mList.length,
              (index) {
                var item = mList[index];
                return Row(
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
                                      ? AppTextStyles.semiBoldBlack14.copyWith(
                                          color: ColorFile.webThemeColor)
                                      : AppTextStyles.regularBlack14.copyWith(
                                          color: ColorFile.lightBlack1Color,
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

class PagerModel {
  String? displayText = '';
  Rx<bool>? isSelected = false.obs;
  RxInt? count = 0.obs;
  String? text = '';
  GlobalKey? globalKey;
  Color pagerTabColor = Colors.transparent;


  PagerModel(
      {this.displayText,
      this.text,
      this.count,
      this.isSelected,
        this.pagerTabColor = Colors.transparent, // Assign
      this.globalKey});
}
