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
      SkillProgressModel(skillName: StringFile.firebase, percentage: 84),
    );

    technicalSkillList.add(
      SkillProgressModel(skillName: StringFile.jira, percentage: 89),
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
          displayText: StringFile.github,
          svgPath: AssetsIcons.icFB,
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
      category: StringFile.web,
      title: "Helix Care - Healthcare Management System",
      description: """
A comprehensive healthcare management platform providing end-to-end solutions for medical practices, patients, and healthcare providers. Built with modern Flutter framework for exceptional cross-platform performance.

**Key Features & Modules:**

🏥 **Practice Management**
• Multi-location practice support with centralized administration
• Role-based access control with granular permissions
• Complete user management system for staff and providers

👥 **Patient Portal**
• Secure patient registration and profile management
• Digital medical records and chart management
• Appointment scheduling with real-time availability

🩺 **Doctor Management**
• Complete provider profiles with specialties and availability
• Referral system for specialist consultations
• Telemedicine integration with face-to-face virtual meetings

💊 **Clinical Operations**
• Electronic health records (EHR) system
• Digital prescription management
• Lab results integration and tracking

💰 **Billing & Insurance**
• RCM (Revenue Cycle Management) integration
• Insurance verification and eligibility checking
• Automated billing with multiple payment options
• Detailed billing history and transaction tracking

💳 **Payment System**
• Secure payment processing integration
• Wallet balance management for patients
• Bank account integration and payment methods
• Comprehensive financial reporting

📱 **Responsive Design**
• Fully responsive web application
• Cross-platform compatibility (Web, Tablet, Mobile)
• Adaptive UI for optimal experience on all devices
• Professional healthcare-focused design

**Technical Stack:**
• Flutter Web for frontend development
• Responsive design principles
• REST API integration
• Secure authentication system
• Real-time data synchronization
• Cloud-based infrastructure

The platform serves healthcare providers, patients, and administrative staff with a seamless, secure, and efficient healthcare management experience.
""",
      buttonText: "View Live Site",
      siteUrl: "https://qa.helixdoc.com",
      tags: [
        "Flutter",
        "Web",
        "Responsive",
        "Healthcare",
        "EHR",
        "Telemedicine",
        "RCM",
        "Firebase",
        "REST API",
        "UI/UX"
      ],
      isFeatured: true,
    ));

    // MTZ Infotech Website
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "MTZ Infotech - Corporate Website",
      description: """
Designed and developed a modern, responsive portfolio website for MTZ Infotech showcasing company services and projects.

• Fully responsive design optimized for all devices
• Built with Flutter for cross-platform consistency
• Adaptive layout techniques and flexible design principles
• Professional UI/UX with smooth animations and transitions
""",
      buttonText: "View Live Site",
      siteUrl: "https://mtzinfotech.com/#/",
      tags: ["Flutter", "Web", "Responsive", "UI/UX"],
      isFeatured: true,
    ));

    // DrinksView App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "DrinksView - Beverage Discovery",
      description: """
A mobile application for discovering and exploring various beverages with detailed information and user reviews.

• Modern Material Design interface
• Real-time product information and ratings
• Social features for sharing drink experiences
• Personalized recommendations engine
""",
      buttonText: "Play Store",
      siteUrl:
          "https://play.google.com/store/apps/details?id=in.com.trendonrent.trendonrent",
      tags: ["Flutter", "Android", "iOS", "Firebase"],
    ));

    // Dhasa - Patel Samaj App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Dhasa Patel Samaj - Community App",
      description: """
Community application for Patel Samaj members with comprehensive features for connectivity and information sharing.

• User-friendly interface with intuitive navigation
• Cross-platform compatibility (Android & iOS)
• Member directory with search functionality
• Event management and notifications
• Community news and updates
""",
      buttonText: "Download App",
      siteUrl:
          "https://play.google.com/store/apps/details?id=com.dhasagam.patelsamaj&pli=1",
      tags: ["Flutter", "Community", "Social", "Cross-platform"],
      isFeatured: true,
    ));

    // Chinese News App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Vision Magazine - News Platform",
      description: """
Daily news application providing international coverage with expert commentary and analysis.

• Daily current affairs and international news
• Expert columns and opinion pieces
• Multi-language support
• Offline reading capability
• Push notifications for breaking news
""",
      buttonText: "View App",
      isFeatured: true,
      siteUrl:
          "https://play.google.com/store/apps/details?id=tw.com.gvm.dailynews",
      tags: ["News", "Content", "Media", "Flutter"],
    ));

    // Roommatik App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "Roommatik - Roommate Finder",
      description: """
Modern web application for finding compatible roommates with advanced matching algorithms.

• Responsive Flutter web application
• REST API integration for real-time data
• Firebase hosting for optimal performance
• Biometric authentication system
• Advanced search and filtering options
""",
      buttonText: "Visit Website",
      siteUrl: "https://roommatik-eae91.web.app",
      tags: ["Flutter Web", "Firebase", "REST API", "Authentication"],
    ));

    // Viosa Learning App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Viosa - AI Learning Platform",
      description: """
Comprehensive learning application with AI-powered features for career development and skill enhancement.

• AI-powered resume generation and optimization
• Personalized career guidance and insights
• Mock interviews with AI evaluation
• Course search and recommendation system
• Webview integration for content delivery
""",
      buttonText: "Learn More",
      siteUrl: "",
      tags: ["AI", "Education", "Career", "Flutter"],
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
        ..setAttribute('download', 'Dharmesh_CV.pdf')
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
