import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../model/social_media_model.dart';
import '../utils/color_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_tooltip.dart';

class CustomSocialMediaList extends StatelessWidget {
  CustomSocialMediaList(
      {required this.mList,
      required this.onTap,
      this.margin,
      this.selectedItem,
      this.padding,
      this.alignment,
      super.key});

  List<SocialMediaModel> mList;
  SocialMediaModel? selectedItem;
  Function(SocialMediaModel) onTap;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Align(
        alignment: alignment ?? Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              mList.length,
              (index) {
                var item = mList[index];
                bool selected = item == selectedItem;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    CustomTooltipWithArrow(
                      message: item.displayText ?? "", // Show the name of the social media
                      child: CustomGestureDetector(
                        onTap: () {
                          onTap(item);
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: selected
                                ? ColorFile.webThemeColor
                                : ColorFile.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            item.svgPath ?? "",
                            height: 15.h,
                            width: 15.w,
                            colorFilter: ColorFilter.mode(
                                selected
                                    ? ColorFile.whiteColor
                                    : ColorFile.webThemeColor,
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),



                    // CustomGestureDetector(
                    //     onTap: () {
                    //       onTap(item);
                    //     },
                    //     child: Container(
                    //       height: 50.h,
                    //       width: 50.w,
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: 12.h, horizontal: 16.w),
                    //       decoration: BoxDecoration(
                    //         color: selected
                    //             ? ColorFile.webThemeColor
                    //             : ColorFile.whiteColor,
                    //         shape: BoxShape.circle,
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: SvgPicture.asset(
                    //         item.svgPath ?? "",
                    //         height: 15.h,
                    //         width: 15.w,
                    //         colorFilter: ColorFilter.mode(
                    //             selected
                    //                 ? ColorFile.whiteColor
                    //                 : ColorFile.webThemeColor,
                    //             BlendMode.srcIn),
                    //       ),
                    //     )),
                    if (index < mList.length - 1)
                      SizedBox(
                        width: 4.w,
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
