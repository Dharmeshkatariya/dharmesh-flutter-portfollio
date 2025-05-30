import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../custom_view/custom_horizontal_pager.dart';
import '../../enum/misc_enums.dart';
import '../../model/portfolio_model.dart';
import '../../model/skill_progress_model.dart';
import '../../model/social_media_model.dart';
import '../../utils/assets_icons.dart';
import '../../utils/color_file.dart';
import '../../utils/common.dart';
import '../../utils/string_file.dart';
import '../../utils/vertical_page_scrolling.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class DashboardHomeViewController extends GetxController
    with GetTickerProviderStateMixin {
  final horizontalPadding = 200.w;
  final horizontalPaddingMobile = 20.w;
  final spaceBetweenItem = 35.w;

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  @override
  onInit() async {
    _initThemeColor();
    _initAnimation();
    _initPager();
    _initSocialMedia();
    _initTechnicalSkill();
    _initPortfolio();
    _initContactUsList();
    _pageScrollListener();
    super.onInit();
  }

  RxList<PagerModel> headerPagerList = <PagerModel>[].obs;
  Rx<PagerModel> selectedPagerData = PagerModel().obs;

  RxList<SocialMediaModel> socialMediaList = <SocialMediaModel>[].obs;
  Rx<SocialMediaModel> selectedSocialMedia = SocialMediaModel().obs;

  RxList<SocialMediaModel> contactUsList = <SocialMediaModel>[].obs;
  Rx<SocialMediaModel> selectedContactUS = SocialMediaModel().obs;

  clickOnTab(PagerModel pagerModel) {
    selectedPagerData.value = pagerModel;
    scrollToSection(
        globalKey: selectedPagerData.value.globalKey ?? GlobalKey());
  }

  clickSocialOnTab(SocialMediaModel socialMediaModel) {
    selectedSocialMedia.value = socialMediaModel;
  }

  _initPager() {
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.home,
          count: 0.obs,
          text: StringFile.home,
          globalKey: GlobalKey(),
          isSelected: true.obs),
    );
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.about,
          count: 0.obs,
          text: StringFile.about,
          globalKey: GlobalKey(),
          isSelected: false.obs),
    );
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.skill,
          count: 0.obs,
          text: StringFile.skill,
          globalKey: GlobalKey(),
          isSelected: true.obs),
    );
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.portfolio,
          count: 0.obs,
          text: StringFile.portfolio,
          globalKey: GlobalKey(),
          isSelected: true.obs),
    );
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.services,
          globalKey: GlobalKey(),
          count: 0.obs,
          text: StringFile.services,
          isSelected: true.obs),
    );
    headerPagerList.add(
      PagerModel(
          displayText: StringFile.contact,
          count: 0.obs,
          globalKey: GlobalKey(),
          text: StringFile.contact,
          pagerTabColor: ColorFile.webThemeColor,
          isSelected: true.obs),
    );
    selectedPagerData.value = headerPagerList[0];
  }

  RxList<SkillProgressModel> technicalSkillList = <SkillProgressModel>[].obs;

  _initTechnicalSkill() {
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.java, percentage: 80),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.flutter, percentage: 99),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.dart, percentage: 90),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.getX, percentage: 95),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.android, percentage: 85),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.git, percentage: 85),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.graphQl, percentage: 80),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.firebase, percentage: 84),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.retroFit, percentage: 81),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.jira, percentage: 89),
    );
    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.webSocket, percentage: 85),
    );
  }

  _initSocialMedia() {
    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.linkedin,
          svgPath: AssetsIcons.icLinkedin,
          link: "https://www.mtzinfotech.com/",
          isSelected: true.obs),
    );
    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.facebook,
          svgPath: AssetsIcons.icFB,
          link: "https://www.mtzinfotech.com/",
          isSelected: true.obs),
    );
    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.dribbble,
          svgPath: AssetsIcons.icDribble,
          link: "https://www.mtzinfotech.com/",
          isSelected: true.obs),
    );
    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.instagram,
          svgPath: AssetsIcons.icInstagram,
          link: "https://www.mtzinfotech.com/",
          isSelected: true.obs),
    );
    selectedSocialMedia.value = socialMediaList[0];
  }

  _initContactUsList() {
    contactUsList.add(
      SocialMediaModel(
          displayText: StringFile.address,
          svgPath: AssetsIcons.icLocationFill,
          link: StringFile.address,
          isSelected: true.obs),
    );
    contactUsList.add(
      SocialMediaModel(
          displayText: StringFile.mobileNumber,
          svgPath: AssetsIcons.icCall,
          link: StringFile.mobileNumber,
          isSelected: true.obs),
    );
    contactUsList.add(
      SocialMediaModel(
          displayText: StringFile.emailAddress,
          svgPath: AssetsIcons.icEmailView,
          link: StringFile.emailAddress,
          isSelected: true.obs),
    );
    selectedContactUS.value = contactUsList[0];
  }

  RxList<PortfolioModel> portfolioList = <PortfolioModel>[].obs;
  Rx<PortfolioModel> selectedPortfolio = PortfolioModel().obs;

  clickOnFollowUs(SocialMediaModel model) {
    if (model.link != null && model.link!.isNotEmpty) {
      _launchUrls(model.link ?? "");
    }
  }

  void _launchUrls(String doc) async {
    final url = Uri.parse(doc);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '${StringFile.couldNotLaunch}$url';
    }
  }

  void _initPortfolio() {
    List<PortfolioModel> portfolioItems = [];

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Novo Cinemas",
      description:
          "Create user-friendly design and smooth working on any device platform.",
      buttonText: "Case Study",
      siteUrl:
          "https://play.google.com/store/apps/details?id=com.grandcinema.gcapp.screens",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "DrinksView",
      description:
          "Create user-friendly design and smooth working on any device platform.",
      buttonText: "Case Study",
      siteUrl:
          "https://play.google.com/store/apps/details?id=in.com.trendonrent.trendonrent",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Dhasa - Patel Samaj",
      description:
          "Create user-friendly design and smooth working on any device platform.",
      buttonText: "Case Study",
      siteUrl:
          "https://play.google.com/store/apps/details?id=com.dhasagam.patelsamaj&pli=1",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "GloriFi",
      description:
          """GloriFi is a financial technology company, not a bank.   Banking services provided by Trans Pecos Banks, SSB, Member FDIC. The Debit Mastercard® and the World Debit Mastercard® are issued  by Trans Pecos Banks, SSB pursuant to license by Mastercard®  International Incorporated and can be used everywhere Mastercard® is accepted. Mastercard, World Debit Card, and the circle's designs are registered trademarks of  Mastercard International Incorporated. ©2022 Mastercard. All rights reserved.""",
      buttonText: "Case Study",
      siteUrl: "https://glorifi.com/",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "GGATE",
      description:
          """GGATE is an interactive society management app that enables efficientmanagement of society's security, maintenance, staffing, bookkeeping, operations, andmore.""",
      buttonText: "Case Study",
      siteUrl: "https://play.google.com/store/apps/details?id=com.ripl.ggate",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.design,
      title: "HOME AUTOMATION",
      description:
          """The name itself depicts the app which manages you home. It connectseverything in your home, and you can control all of your favourite connected homedevices, wearable from single highly customized interface.""",
      buttonText: "Case Study",
      siteUrl: "",
    ));
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "HA AUTOMATIONS",
      description:
          """HA Automation is provided fully automated handicap chair.We can control chairs using mobile applications. Control like we can move, up or downchair according to over requirements.""",
      buttonText: "Case Study",
      siteUrl: "",
    ));

    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "POOL LAB",
      description:
          """Pool Lab is giving all the information about the swimming pool. Like waterlevel, PH level, Chlorin level ext. Also, we can change, and maintain all the parametersrelated to the swimming pool using the mobile application.""",
      buttonText: "Case Study",
      siteUrl: "",
    ));
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "QR NAMASTE",
      description:
          """Qrnamste allows the Visitors to check in digitally eliminating the hecticpaperwork. Our Web-based Dashboard helps track health-related information to safelyminimize the spread of COVID-19 and also leaves a professional first impression on yourVisitors.""",
      buttonText: "Case Study",
      siteUrl: "",
    ));
    portfolioList.assignAll(portfolioItems);
  }

  /// scrolling
  final pageScrollController = ScrollController();
  bool _isUserSourceScroll = false;

  scrollToSection({required GlobalKey globalKey}) {
    _isUserSourceScroll = true;
    final context = globalKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        globalKey.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        _isUserSourceScroll = false;
      });
    }
  }

  void _pageScrollListener() {
    pageScrollController.addListener(() {
      if (!_isUserSourceScroll) {
        addUserScrollingHandel();
      }
    });
  }

  void addUserScrollingHandel() {
    List<GlobalKey> sectionKeys = [];
    for (PagerModel item in headerPagerList.value) {
      sectionKeys.add(item.globalKey ?? GlobalKey());
    }
    if (pageScrollController.hasClients) {
      VerticalPagerScrolling.verticalPageScrolling(
          globalKeyList: sectionKeys,
          scrollController: pageScrollController,
          gapHeightBetweenWidget: 10.h,
          pagerDataList: headerPagerList,
          selectedPagerData: selectedPagerData);
    }
  }

  Future<Uint8List> _loadTheAsset() async {
    ByteData data = await rootBundle.load(AssetsIcons.cv);
    Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }

  Future<void> clickOnDownload() async {
    try {
      Uint8List response = await _loadTheAsset();
      final blob = html.Blob([response]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'Vikram_CV.pdf')
        ..click();

      html.Url.revokeObjectUrl(url);
      Common().showSnackBar(
        StringFile.fileSuccessfullyDownload,
        snackBarType: SnackBarType.success,
      );
    } catch (e) {
      e.printError();
      Common().showSnackBar(StringFile.somethingWentWrong,
          snackBarType: SnackBarType.error);
    }
  }

  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    String fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    if (fileName.contains('?')) {
      fileName = fileName.split('?').first;
    }
    return fileName;
  }

  // for theme
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  RxBool isMenuVisible = false.obs;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  void toggleMenu() {
    if (isMenuVisible.value) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isMenuVisible.toggle();
  }

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> changeColor(Color color) async {
    isLoading.value = true;
    await Common().setThemeColor(themeColor: color);
    selectedColor.value = color;
    isMenuVisible.value = false;
    isLoading.value = false;
  }

  RxList<Color> themeColorsList = <Color>[].obs;
  Rx<Color> selectedColor = ColorFile.webThemeColor.obs;
  RxBool isLoading = false.obs;

  _initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
  }

  _initThemeColor() {
    themeColorsList.add(ColorFile.webThemeColor);
    themeColorsList.add(const Color(0xFF004b23));
    themeColorsList.add(const Color(0xFF219ebc));
    themeColorsList.add(const Color(0xFF001845));
    themeColorsList.add(const Color(0xFF8d0801));
    themeColorsList.add(const Color(0xFF390099));
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  Duration animationDuration() {
    return const Duration(seconds: 2);
  }

  Duration animationDelay() {
    return const Duration(seconds: 2);
  }
}
