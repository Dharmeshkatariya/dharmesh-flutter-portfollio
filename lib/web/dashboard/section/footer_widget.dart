import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../custom_view/custom_horizontal_pager.dart';
import '../../../custom_view/custom_text.dart';
import '../../../model/social_media_model.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/color_file.dart';
import '../../../utils/common.dart';
import '../../../utils/constants_file.dart';
import '../../../utils/string_file.dart';
import '../clipper/deep_wave_clipper.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget(
      {super.key,
      required this.footerAboutList,
      this.selectedFooterAboutItem,
      required this.onTapAbout,
      required this.footerFollowUsList,
      this.selectedFooterFollowUsItem,
      required this.onTapFollowUS,
      required this.padding,
      required this.contactUsList,
      this.selectedFooterContactUsItem,
      required this.onTapContactUS});

  final List<PagerModel> footerAboutList;
  final PagerModel? selectedFooterAboutItem;
  final Function(PagerModel) onTapAbout;
  final List<SocialMediaModel> footerFollowUsList;
  final SocialMediaModel? selectedFooterFollowUsItem;
  final Function(SocialMediaModel) onTapFollowUS;

  final List<SocialMediaModel> contactUsList;
  final SocialMediaModel? selectedFooterContactUsItem;
  final Function(SocialMediaModel) onTapContactUS;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return Column(
      children: [
        ClipPath(
          clipper: DeepWaveClipper(),
          child: Container(
            height: 100.h,
            color: ColorFile.webThemeColorOpaque30,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Common.isWebSize() ? _web() : _mobile(),
              SizedBox(height: 20.h),
              const Divider(),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: CustomTextView(
                    StringFile.designedBy,
                    style: AppTextStyles.regularBlack14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _web() {
    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _titleSection()),
          SizedBox(width: 25.w),
          Expanded(child: _aboutSection()),
          SizedBox(width: 25.w),
          Expanded(child: _followUsSection()),
          SizedBox(width: 25.w),
          Expanded(child: _contactUsSection()),
          SizedBox(width: 25.w),
          Expanded(child: _getInTouchSection()),
        ],
      ),
    );
  }

  Widget _mobile() {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleSection(),
          SizedBox(height: 20.h),
          _aboutSection(),
          SizedBox(height: 20.h),
          _followUsSection(),
          SizedBox(height: 20.h),
          _contactUsSection(),
          SizedBox(height: 20.h),
          _getInTouchSection(),
        ],
      ),
    );
  }

  Widget _titleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          StringFile.footerTitle,
          style: AppTextStyles.boldBlack22
              .copyWith(color: ColorFile.webThemeColor),
        ),
        SizedBox(height: 8.h),
        CustomTextView(StringFile.footerDescription,
            style: AppTextStyles.regularBlack14),
      ],
    );
  }

  Widget _aboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          StringFile.aboutUS,
          style: AppTextStyles.boldBlack16,
        ),
        SizedBox(height: 8.h),
        ...footerAboutList
            .map(
              (PagerModel item) => GestureDetector(
                onTap: () {
                  onTapAbout(item);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: CustomText(
                      item.displayText!,
                      14.sp,
                      (item == selectedFooterAboutItem)
                          ? ColorFile.webThemeColor
                          : ColorFile.lightBlack1Color,
                      (item == selectedFooterAboutItem)
                          ? ConstantsFile.semiBoldFont
                          : ConstantsFile.regularFont),
                ),
              ),
            )
            ,
      ],
    );
  }

  Widget _followUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          StringFile.followUs,
          style: AppTextStyles.boldBlack16,
        ),
        SizedBox(height: 8.h),
        ...footerFollowUsList
            .map(
              (SocialMediaModel item) => GestureDetector(
                onTap: () {
                  onTapFollowUS(item);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        item.svgPath ?? "",
                        height: 15.h,
                        width: 15.w,
                        colorFilter: ColorFilter.mode(
                            ColorFile.webThemeColor, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8.w),
                      CustomTextView(
                        item.displayText!,
                        style: AppTextStyles.regularBlack14.copyWith(
                          color: ColorFile.lightBlack1Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            ,
      ],
    );
  }

  Widget _contactUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          StringFile.contactUs,
          style: AppTextStyles.boldBlack16,
        ),
        SizedBox(height: 8.h),
        ...contactUsList
            .map(
              (SocialMediaModel item) => GestureDetector(
                onTap: () {
                  onTapFollowUS(item);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        item.svgPath ?? "",
                        height: 15.h,
                        width: 15.w,
                        colorFilter: ColorFilter.mode(
                            ColorFile.webThemeColor, BlendMode.srcIn),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomTextView(
                          item.displayText!,
                          style: AppTextStyles.regularBlack14.copyWith(
                            color: ColorFile.lightBlack1Color,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            ,
      ],
    );
  }

  Widget _getInTouchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          StringFile.getInTouchWithUs,
          style: AppTextStyles.boldBlack14,
        ),
        SizedBox(height: 8.h),
        SizedBox(height: 8.h),
        CustomTextView(
          StringFile.needAnswersHelpJustEmail,
          style: AppTextStyles.regularBlack14,
        ),
        SizedBox(height: 8.h),
        TextField(
          decoration: InputDecoration(
            hintText: StringFile.yourEmail,
            suffixIcon: Icon(Icons.send, color: ColorFile.webThemeColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }
}
