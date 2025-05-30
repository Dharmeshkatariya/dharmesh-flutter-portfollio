import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/footer_widget.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/home_profile_section.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/portfolio_section.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/service_section.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/technical_skill_section.dart';
import 'package:vikram_portfollio_dark/web/dashboard/section/user_info_section.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/animated_custom_button.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/elegant_card_widget.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/header_widget.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/primary_sidebar.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/theme_choose_widget.dart';
import 'package:vikram_portfollio_dark/web/dashboard/widget/user_profile_card.dart';
import '../../custom_view/custom_gesture_detector.dart';
import '../../custom_view/custom_horizontal_pager.dart';
import '../../custom_view/custom_scafold_widget.dart';
import '../../custom_view/custom_social_media_list.dart';
import '../../custom_view/custom_text.dart';
import '../../custom_view/page_scroller_circular_progress.dart';
import '../../model/social_media_model.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/assets_icons.dart';
import '../../utils/color_file.dart';
import '../../utils/common.dart';
import '../../utils/string_file.dart';
import 'animation/slide_animation.dart';
import 'dashboard_home_view_controller.dart';

class DashboardHomeView extends GetView<DashboardHomeViewController> {
  const DashboardHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Common().setScreenUtilDesignSize(context);
    return CustomScaffold(
      scaffoldKey: controller.drawerKey,
      backgroundColor: ColorFile.whiteColor,
      // drawer: Common.isWebSize()
      //     ? null
      //     : PrimarySideBar(
      //         mList: controller.headerPagerList,
      //         selectedPagerModel: controller.selectedPagerData,
      //         selectedModelCallBack: (pagerModel) {
      //           controller.clickOnTab(pagerModel);
      //         },
      //       ),
      body: Obx(() {
        return Container(
          child: controller.isLoading.value
              ? const CircularProgressIndicator()
              : Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Common.isWebSize() ? _webView() : _mobileView(),
                    ),
                    Obx(() => _animatedDrawer()),
                  ],
                ),
        );
      }),
      // body: SizedBox(
      //   width: Get.width,
      //   child: Common.isWebSize() ? _webView() : _mobileView(),
      // ),
    );
  }

  Widget _mobileView() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [_header(), Expanded(child: _webBody())],
      ),
    );
  }

  Widget _header() {
    return Obx(() {
      return FadeInDown(
        duration: const Duration(milliseconds: 500),
        child: HeaderWidget(
            themeColor: controller.selectedColor.value,
            paddingHorizontal: _commonPadding(),
            mobileMenuWidget: CustomGestureDetector(
              onTap: controller.toggleDrawer, // T
              child: SvgPicture.asset(
                AssetsIcons.icMenu,
                height: 24.h,
                width: 24.h,
                colorFilter:
                    ColorFilter.mode(ColorFile.webThemeColor, BlendMode.srcIn),
              ),
            ),
            mList: controller.headerPagerList.value,
            selectedItem: controller.selectedPagerData.value,
            onTap: (pagerModel) {
              controller.clickOnTab(pagerModel);
            }),
      );
    });
  }

  Widget _animatedDrawer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      right: controller.isDrawerOpen.value ? 0 : -340.w,
      top: 0,
      bottom: 0,
      child: Stack(
        children: [
          Container(
            width: 340.w,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, size: 24.h, color: Colors.black),
                    onPressed: controller.toggleDrawer,
                  ),
                ),
                Expanded(
                  child: PrimarySideBar(
                    mList: controller.headerPagerList,
                    selectedPagerModel: controller.selectedPagerData,
                    selectedModelCallBack: (pagerModel) {
                      controller.toggleDrawer();
                      controller.clickOnTab(pagerModel);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _commonPadding() {
    return EdgeInsets.symmetric(
        horizontal: Common.isWebSize()
            ? controller.horizontalPadding
            : controller.horizontalPaddingMobile);
  }

  Widget _webView() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [_header(), Expanded(child: _webBody())],
      ),
    );
  }

  Widget _webBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller.pageScrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _commonHeight(height: 75.h),
              _profileInfo(),
              _commonHeight(height: 25.h),
              _userExpInfo(),
              _commonHeight(height: 25.h),
              _technicalSkillSection(),
              _commonHeight(height: 25.h),
              _portfolioSection(),
              _commonHeight(height: 25.h),
              _serviceSection(),
              _commonHeight(height: 25.h),
              _footer(),
              _commonHeight(height: 20.w),
            ],
          ),
        ),
        const ThemeChooseWidget(),
        PageScrollerCircularProgressBar(
            scrollController: controller.pageScrollController),
      ],
    );
  }

  Widget _footer() {
    return Obx(() {
      return BounceInUp(
        duration: const Duration(milliseconds: 600),
        child: FooterWidget(
          key: controller.headerPagerList.value[5].globalKey,
          footerAboutList: controller.headerPagerList,
          selectedFooterAboutItem: controller.selectedPagerData.value,
          onTapAbout: (PagerModel pageModel) {
            controller.clickOnTab(pageModel);
          },
          footerFollowUsList: controller.socialMediaList,
          selectedFooterFollowUsItem: controller.selectedSocialMedia.value,
          onTapFollowUS: (SocialMediaModel model) {
            controller.clickOnFollowUs(model);
          },
          contactUsList: controller.contactUsList,
          selectedFooterContactUsItem: controller.selectedContactUS.value,
          onTapContactUS: (SocialMediaModel model) {
            controller.clickOnFollowUs(model);
          },
          padding: EdgeInsets.symmetric(horizontal: 25.w),
        ),
      );
    });
  }

  Widget _profileInfo() {
    return FadeInLeft(
      duration: controller.animationDuration(),
      delay: controller.animationDelay(),
      animate: true,
      child: HomeProfileSection(
        key: controller.headerPagerList.value[0].globalKey,
        padding: _commonPadding(),
        spaceBetweenItem: controller.spaceBetweenItem,
        downloadCvButton: _downloadCv(),
        socialMedia: _socialMediaList(),
      ),
    );
  }

  Widget _socialMediaList() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0.w),
        child: Container(
          width: 240.w,
          height: 60.h,
          padding: EdgeInsets.zero,
          color: ColorFile.transparentColor,
          child: CustomSocialMediaList(
            mList: controller.socialMediaList,
            onTap: (socialMediaModel) {
              controller.clickSocialOnTab(socialMediaModel);
            },
            selectedItem: controller.selectedSocialMedia.value,
          ),
        ),
      );
    });
  }

  Widget _userExpInfo() {
    return UserInfoSection(
      scrollController: controller.pageScrollController,
      key: controller.headerPagerList.value[1].globalKey,
      padding: _commonPadding(),
      spaceBetweenItem: controller.spaceBetweenItem,
      downloadCvButton: _downloadCv(),
      profileCard: _profileCard(isSocialMediaVisible: true, isBorderLess: true),
    );
  }

  Widget _workProgressInfo() {
    return Container(
      key: controller.headerPagerList.value[2].globalKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileCard(isSocialMediaVisible: true, isBorderLess: true),
          _commonWidth(width: controller.spaceBetweenItem),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextView(
                  StringFile.imProfessionalUserExperienceDesigner,
                  style: AppTextStyles.semiBoldBlack40
                      .copyWith(color: ColorFile.webThemeColor),
                ),
                _commonHeight(),
                _commonHeight(),

                _commonHeight(),
                _commonHeight(),
                _downloadCv(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _technicalSkillSection() {
    return TechnicalSkillSection(
      padding: _commonPadding(),
      scrollController: controller.pageScrollController,
      technicalSkillList: controller.technicalSkillList,
      key: controller.headerPagerList.value[2].globalKey,
    );
  }

  Widget _portfolioSection() {
    return PortfolioSection(
      horizontalPadding: _commonPadding(),
      key: controller.headerPagerList.value[3].globalKey,
      portfolioList: controller.portfolioList,
    );
  }

  Widget _serviceSection() {
    return ServiceSection(
      key: controller.headerPagerList.value[4].globalKey,
      padding: _commonPadding(),
    );
  }

  Widget _downloadCv() {
    return AnimatedCustomButton(
      text: StringFile.downloadCV,
      width: 140.w,
      height: 40,
      onTap: () {
        controller.clickOnDownload();
      },
    );
    // return ColorGlowEffect(
    //   child: WebCustomButtonWithBG(width: 140.w, StringFile.downloadCV, 40, () {
    //     controller.clickOnDownload();
    //   }),
    // );
  }

  Widget _profileCard(
      {required bool isSocialMediaVisible, required bool isBorderLess}) {
    return Obx(() {
      return ProfileCard(
        imageUrl: AssetsIcons.dharmeshImage,
        isBorderLess: isBorderLess,
        isSocialMediaVisible: isSocialMediaVisible,
        mList: controller.socialMediaList.value,
        selectedItem: controller.selectedSocialMedia.value,
        onTap: (SocialMediaModel socialMediaModel) {
          controller.clickSocialOnTab(socialMediaModel);
        },
      );
    });
  }

  Widget _commonHeight({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }

  Widget _commonWidth({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }
}
