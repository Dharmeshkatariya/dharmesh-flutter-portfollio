import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/color_file.dart';
import '../utils/constants_file.dart';
import 'custom_text.dart';

class CommonAttachmentWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final RxString selectedFile;

  const CommonAttachmentWidget(this.title, this.hintText, this.selectedFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          13.sp,
          ColorFile.blackColor,
          ConstantsFile.mediumFont,
        ),
        SizedBox(height: 6.w),
        Container(
          padding: EdgeInsets.only(left: 14.w, right: 6.w),
          height: 40.w,
          decoration: BoxDecoration(
            border: Border.all(color: ColorFile.grayDDColor),
            color: ColorFile.whiteColor,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => CustomText(
                    selectedFile.value.isEmpty ? hintText : selectedFile.value,
                    13.sp,
                    selectedFile.value.isEmpty ? ColorFile.hintTextColor : ColorFile.blackColor,
                    ConstantsFile.regularFont,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.attachment_outlined,
                    size: 18.w,
                  )),
              SizedBox(
                width: 8.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
