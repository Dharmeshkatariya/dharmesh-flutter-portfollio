import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../custom_view/border_container.dart';
import '../../../custom_view/custom_social_media_list.dart';
import '../../../model/social_media_model.dart';
import '../../../utils/assets_icons.dart';
import '../../../utils/color_file.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final List<SocialMediaModel> mList;
  final SocialMediaModel? selectedItem;
  final Function(SocialMediaModel) onTap;
  final bool isSocialMediaVisible;
  final bool isBorderLess;

  const ProfileCard({
    super.key,
    required this.imageUrl,
    this.isSocialMediaVisible = false,
    this.isBorderLess = false,
    required this.mList,
    this.selectedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      width: 350.w,
      border:
          isBorderLess ? Border.all(color: ColorFile.transparentColor) : Border.all(color: ColorFile.webBorderGrayColor),
      color: isSocialMediaVisible
          ? ColorFile.transparentColor
          : ColorFile.whiteColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
              width: 350.w,
              height: 350.h,
              AssetsIcons.vikramProfileImg,
              fit: BoxFit.contain),
          if (isSocialMediaVisible) ...[
            // Positioned(
            //   bottom: 10.h,
            //   child: Container(
            //     width: 220.w,
            //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(25.r),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.1),
            //           blurRadius: 10,
            //           spreadRadius: 2,
            //         ),
            //       ],
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [Icons.facebook,Icons.facebook]
            //           .map(
            //             (icon) => Icon(icon, color: Colors.purple, size: 24.sp),
            //       )
            //           .toList(),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 10, // Align at the bottom
            //   // left: 0,
            //   // right: 0, // Stretch to full width
            //   child: BorderContainer(
            //     width: 250.w,
            //     padding: EdgeInsets.zero,
            //     child: CustomSocialMediaList(
            //       mList: mList,
            //       onTap: onTap,
            //       selectedItem: selectedItem,
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 10.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                child: BorderContainer(
                  width: 220.w,
                  height: 50.h,
                  borderRadius: BorderRadius.circular(25.r),
                  padding: EdgeInsets.zero,
                  child: CustomSocialMediaList(
                    mList: mList,
                    onTap: onTap,
                    selectedItem: selectedItem,
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
