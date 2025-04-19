import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../custom_view/custom_gesture_detector.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/color_file.dart';
import '../../../utils/constants_file.dart';

class PrimarySideBarListView extends StatelessWidget {
  const PrimarySideBarListView({
    super.key,
    required this.mList,
    required this.selectedPagerModel,
    required this.selectedModelCallBack,
  });

  final RxList<PagerModel> mList;
  final Rx<PagerModel> selectedPagerModel;
  final ValueChanged<PagerModel> selectedModelCallBack;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var item = mList[index];
          return Obx(() => PrimarySidebarItem(
                onTap: () {
                  selectedModelCallBack(item);
                },
                isSelected: item == selectedPagerModel.value,
                text: mList[index].displayText ?? "",
                isVisible: true,
              ));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 0.h);
        },
        itemCount: mList.length);
  }
}

class PrimarySidebarItem extends StatelessWidget {
  const PrimarySidebarItem(
      {super.key,
      required this.onTap,
      required this.isSelected,
      required this.isVisible,
      required this.text});

  final Function()? onTap;
  final bool isSelected;
  final String text;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      semanticsLabel: text,
      onTap: onTap,
      child: Visibility(
        visible: isVisible,
        child: SizedBox(
          height: 40.h,
          child: Container(
            padding: EdgeInsets.only(left: 15.w),
            margin: EdgeInsets.only(right: 20.w),
            decoration: BoxDecoration(
              color:
                  isSelected ? ColorFile.webThemeColor : ColorFile.whiteColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(48.0),
                  bottomRight: Radius.circular(48.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                          child: CustomText(
                        text,
                        14.sp,
                        (isSelected)
                            ? ColorFile.whiteColor
                            : ColorFile.blackColor,
                        ConstantsFile.mediumFont,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
