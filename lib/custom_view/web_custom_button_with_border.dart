import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../custom_view/custom_text.dart';
import '../../utils/color_file.dart';
import '../../utils/common.dart';
import '../enum/enum_web_size_type.dart';
import '../utils/constants_file.dart';

class WebCustomButtonWithBorder extends StatelessWidget {

  final String text;
  final VoidCallback onTaped;
  int? height = 36;
  String? assetName;
  MainAxisSize mainAxisSize;
  final bool isDisableButton ;
  WebCustomButtonWithBorder(this.text, this.onTaped, {this.mainAxisSize = MainAxisSize.max,this.height = 36, this.isDisableButton = false, this.assetName,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisableButton
          ? null
          : () {
        onTaped();
      },
      child: Container(
          height: height!.sp,
          padding: EdgeInsets.only(left: assetName != null ? 12.w : 16.w, right: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: isDisableButton ?  ColorFile.greyColorOpaque20 :  ColorFile.webThemeColor), borderRadius: BorderRadius.all(Radius.circular(7.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              if (assetName != null) Container(margin: EdgeInsets.only(right: 6.w), child: SvgPicture.asset(assetName!, width: 21.w, height: 21.w, colorFilter: ColorFilter.mode( isDisableButton ? ColorFile.greyColorOpaque20 : ColorFile.webThemeColor, BlendMode.srcIn),)),
              CustomText(text, Common.webSizeType > EnumWebSizeType.mediumSizeWeb.webSizeType ? 14.sp : 13.sp, isDisableButton ? ColorFile.greyColorOpaque20 :   ColorFile.webThemeColor,
                  ConstantsFile.semiBoldFont),
            ],
          )),
    );
  }

}
