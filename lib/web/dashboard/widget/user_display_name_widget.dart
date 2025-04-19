import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/custom_text.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/constants_file.dart';

class UserDisplayNameWidget extends StatelessWidget {
  final String name;
  final Color themeColor;

  const UserDisplayNameWidget(
      {super.key, required this.name, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCircle(),
        SizedBox(width: 8.w),
        CustomTextView(
          name,
          style: AppTextStyles.boldBlack18,
        )
      ],
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeColor,
        shape: BoxShape.circle,
      ),
      child: _userName(),
    );
  }

  Widget _userName() {
    String userName = Common.userProfileFromFirsLetter(firstName: name);
    return CustomText(userName, Common.isWebSize() ? 17.sp : 16.sp,
        ColorFile.whiteColor, ConstantsFile.semiBoldFont);
  }
}
