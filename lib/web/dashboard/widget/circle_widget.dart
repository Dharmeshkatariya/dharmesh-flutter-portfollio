import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../custom_view/custom_image.dart';
import '../../../../custom_view/custom_text.dart';
import '../../../../utils/color_file.dart';
import '../../../../utils/common.dart';
import '../../../../utils/constants_file.dart';

class CircularNameWidget extends StatelessWidget {
  const CircularNameWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    this.profileImg,
  });

  final String? firstName;
  final String? lastName;
  final String? profileImg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCircle(),
      ],
    );
  }

  Widget _buildCircle() {
    return Container(
        width: 48.w,
        height: 48.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorFile.webThemeColorOpaque10,
          shape: BoxShape.circle,
        ),
        child: profileImg != null && profileImg!.isNotEmpty
            ? CustomImage(profileImg!, 40.w, 40.w)
            : _userName());
  }

  Widget _userName() {
    String userName = Common.userProfileFromFirstLastName(
        firstName: firstName ?? '', lastName: lastName ?? '');
    return CustomText(userName, Common.isWebSize() ? 17.sp : 16.sp,
        ColorFile.webThemeColor, ConstantsFile.semiBoldFont);
  }


}
