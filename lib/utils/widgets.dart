import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../custom_view/custom_text.dart';
import 'color_file.dart';
import 'constants_file.dart';

class Widgets {
  dropDownStringItems(
      List<String> items, RxString selectedValue, String hintText,
      {double? width, bool? heightCheck, double? iconSize}) {
    return Obx(() => Container(
          width: width,
          height: heightCheck == true ? 35 : 40.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 12.w, right: 4.w),
          decoration: BoxDecoration(
            border: Border.all(color: ColorFile.webBorderGrayColor),
            color: ColorFile.whiteColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            onTap: () {
              FocusScope.of(Get.context!).unfocus();
            },
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: ColorFile.blackColor,
              size: iconSize,
            ),
            dropdownColor: ColorFile.whiteColor,
            style: TextStyle(
                color: ColorFile.blackColor,
                fontSize: 14.sp,
                fontFamily: ConstantsFile.mediumFont),
            hint: CustomText(hintText, 14.sp, ColorFile.blackColorOpaque60,
                ConstantsFile.regularFont),
            items: items.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorFile.blackColor,
                      fontFamily: ConstantsFile.mediumFont),
                ),
              );
            }).toList(),
            onChanged: (String? newValueSelected) {
              selectedValue.value = newValueSelected!;
            },
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
          )),
        ));
  }
}
