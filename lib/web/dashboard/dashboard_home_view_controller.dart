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
          link: "https://linkedin.com/in/dharmesh-katariya-63268b20b",
          isSelected: true.obs),
    );
    // socialMediaList.add(
    //   SocialMediaModel(
    //       displayText: StringFile.facebook,
    //       svgPath: AssetsIcons.icFB,
    //       link: "https://github.com/Dharmeshkatariya",
    //       isSelected: true.obs),
    // );
    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.github,
          svgPath: AssetsIcons.icGithub,
          link: "https://github.com/Dharmeshkatariya",
          isSelected: true.obs),
    );

    socialMediaList.add(
      SocialMediaModel(
          displayText: StringFile.instagram,
          svgPath: AssetsIcons.icInstagram,
          link: "https://www.instagram.com/dharmesh_ahir_2002/",
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
      title: "Helix Care - Comprehensive Healthcare Platform",
      description: """
A full-stack Flutter web application serving as a complete healthcare ecosystem. This platform seamlessly integrates patient management, clinical operations, telemedicine, and billing into a single, responsive experience. It supports the entire workflow from patient registration and appointment scheduling to secure video consultations and complex billing management.

MODULES DEVELOPED:

User Management
Implemented secure, token-based password reset functionality via email.
Built a comprehensive admin panel for user activity monitoring and management.
Developed user profile management with photo upload and personal information editing.
Designed a robust role-based access control (RBAC) system with configurable permissions.
Created detailed user forms supporting name, gender, policy selection, and group assignment.
Implemented a full user list with admin capabilities for role changes, password resets, and status management.
Added user status management for locked accounts, pending invitations, and activations.

Health Center & Customer Management
Developed comprehensive customer profiles with full health history tracking.
Built a customer registration and editing system with full validation.
Implemented advanced search by customer name, health center, and location.
Created a system for allocating customers and practices across different health centers.
Implemented financial detail management with complete transaction history.
Built a working hours configuration system with time slot management.
Developed location-based filtering, reporting, and holiday management.
Designed a dynamic UI for adding and editing health center details, financials, and operational info.
Built a location hierarchy managing relationships between main centers and branches.

Role & Permission System
Created a dynamic sidebar navigation that updates based on user roles and permissions.
Built a comprehensive permission system to control module access across the entire application.
Implemented an admin interface for creating roles and assigning specific permissions.
Designed role categories and groups with tab-based list views, pagination, and search.
Developed four-level permission types (View, Create, Update, Delete) for all modules.
Ensured role permissions directly control UI element visibility and user accessibility.

Appointment Management
Developed real-time appointment booking with live doctor availability checks.
Built calendar synchronization across web and mobile platforms.
Implemented insurance verification and selection during the booking process.
Created a time slot selection system based on configurable doctor availability.
Built a comprehensive appointment list with advanced filtering and sorting by date, doctor, and status.
Implemented full status tracking (scheduled, confirmed, completed, cancelled, no-show).
Developed rescheduling and cancellation features with approval workflows.
Added calendar views and list views for complete appointment management.

Billing & Payments
Built support for multiple payment methods including bank transfer, cards, and digital wallets.
Developed payment gateway integration for secure transaction processing.
Implemented a split payment functionality allowing multiple payment methods per bill.
Created a wallet system with balance tracking, top-ups, and transaction history for patients and providers.
Built a secure bank account registration and credit card storage system with encryption.
Developed a comprehensive billing history with advanced search, filtering, and multi-status tracking.
Implemented a responsive billing dashboard with detailed bill views and bookmarkable UI states.

Patient Chart Management
Built a comprehensive patient chart system for complete medical records management.
Created a patient list view with advanced pagination, search, and multi-user selection.
Implemented detailed patient profile views with full medical history.
Developed multi-format export functionality (PDF, XML, HTML) and print support.

Policy Management
Built a comprehensive policy creation system with version control and change tracking.
Developed a rich text editor for terms and conditions with full formatting options.
Created policy templates for different services and consent requirements.
Designed a policy list view with advanced filtering by status, date, and type.
Implemented status management and an automated effective dating system for policy versions.

Face Meet Module (Telemedicine)
Built complete meeting lifecycle management (create, join, complete, cancel).
Developed meeting creation with participant management and invitation system.
Implemented meeting status tracking (scheduled, ongoing, completed, cancelled).
Designed an intuitive meeting list view with filters and advanced search.

Video Conference Features
Integrated video meeting functionality using WebRTC technology.
Developed a multi-participant grid layout with active speaker focus and screen sharing.
Implemented host controls for participant management and an interactive whiteboard.
Added in-meeting chat, note-taking, and file sharing capabilities.
Created a responsive meeting interface for web and mobile with recording indicators.
""",
      buttonText: "View Live Site",
      siteUrl: "https://qa.helixdoc.com",
      tags: [
        "Flutter Web",
        "Dart",
        "Responsive Design",
        "Healthcare",
        "Telemedicine",
        "REST API",
        "UI/UX Design",
        "Video Calling",
        "Payment Gateway",
        "Stripe Integration",
        "Real-time Updates",
        "Cloud Firestore",
        "Multi-tenant Architecture",
        "Role-Based Access Control (RBAC)",
        "State Management",
        "Admin Panel",
        "Cross-Platform",
      ],
      isFeatured: true,
    ));
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "Resido - Property Management Platform",
      description: """
Resido is a comprehensive property management application designed to streamline operations for landlords and property managers. It provides a centralized system to manage properties, tenants, locations, and user roles, all through an intuitive and responsive web interface.

PROPERTY MANAGEMENT MODULE

Property Management
Developed a complete property listing system with advanced search and pagination.
Created dynamic add and edit property forms with auto-population and robust validation.
Built an action-oriented interface for each property (view, edit, delete).
Implemented customer-specific property assignment and management.

Location & Building Management
Designed a system to add and manage locations under properties with full detail tracking.
Created filtered and sorted list views for all locations.
Developed a building management system to add structures under specific locations.
Built hierarchical navigation: Property → Location → Building → Floor → Unit.

Floor & Unit Management
Built a detailed floor management system organized under buildings.
Developed unit creation, listing, and management within specific floors.
Implemented auto-population of data across forms for efficient data entry and updates.

DATA & USER MANAGEMENT

Centralized Data Management
Developed a centralized lookup system for all application data types.
Managed appointment statuses (Scheduled, Completed, Cancelled, No-Show).
Implemented reason status management for cancellations and changes.
Created a version control and dependency management system for critical lookup data.

User Management
Implemented a secure, token-based password reset system via email.
Built a comprehensive admin panel for user activity monitoring and management.
Created user profile management with photo upload and personal data editing.
Designed a detailed role-based user creation system with configurable permissions.
Managed user statuses: active, inactive, locked, and pending invitations.

Role & Permission System
Created a dynamic sidebar that updates automatically based on user roles and permissions.
Built a comprehensive permission system to control module access across the entire application.
Implemented an admin interface for creating roles and assigning granular permissions.
Designed four-level permission types (View, Create, Update, Delete) for all modules.
Ensured role permissions directly control UI element visibility and user accessibility.

TECHNICAL IMPLEMENTATION & FEATURES

App Structure
Utilized clean, feature-specific Dart screens for the UI.
Managed business logic with GetX controllers for state management and dependencies.
Built a library of reusable custom widgets for a consistent and efficient design.

Key Features
Fully responsive design for mobile and web.
Secure authentication with login and password recovery.
Comprehensive dashboard with a quick overview of properties and metrics.
Strict role-based access control (RBAC) for security.
Intuitive and easy navigation between complex features.

This project demonstrates my ability to architect and build complete, scalable business applications with a clean architecture, robust security, and a user-centric design for the real estate industry.
""",
      buttonText: "View Live Site",
      siteUrl: "https://resido-dev.helixbeat.com", // Note: You might want to update this URL to the actual Resido site.
      tags: [
        "Flutter Web",
        "Dart",
        "State Management",
        "Responsive Design",
        "Property Management",
        "Real Estate",
        "REST API",
        "UI/UX Design",
        "Role-Based Access Control (RBAC)",
        "Admin Panel",
        "Dashboard",
        "Form Validation",
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

    // Khata App
    portfolioItems.add(PortfolioModel(
        imagePath: AssetsIcons.portfolio,
        category: StringFile.mobile,
        title: "Khata App",
        description: """
Dual Platform Application: A single codebase for both Android and iOS.
Multi-Language Support: Full localization for English, Hindi, and Punjabi.
Role-Based Access Control: Secure login with distinct permissions for Admin and Employee users.
Mobile-First Authentication: User registration and login using a mobile number.
Multi-User Management: Admins can add, edit, and manage multiple employees under one account.
Comprehensive Product Catalog: Features to add, edit, and view a list of all products.
Digital Ledger Management: Core functionality to record and track all Udhar/Jama (debit/credit) transactions.
Advanced Data Filtering:
Auto-Population of Data: Streamlined editing where forms are automatically filled with existing data for quick updates.
User-Friendly UI/UX: A clean, intuitive, and responsive design for easy navigation and use.Help & Support System: Integrated Help, Contact Us, and Employee Details pages.
""",
        buttonText: "Play Store",
        siteUrl:
            "https://play.google.com/store/apps/details?id=com.shree.khata",
        tags: [
          "Flutter",
          "Android",
          "iOS",
          "Dart",
          "Localization",
          "Role-Based Access",
          "Multi-User",
          "State Management",
          "REST API",
        ]));

    // Dhasa - Patel Samaj App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Dhasa Patel Samaj - Community App",
      description: """
Developed a dedicated community application for the members of Dhasa Village to connect, share information, and access important resources. The app serves as a digital hub for community engagement and information sharing.
Cross-Platform Development: Built a fully functional application for both Android and iOS using a single Flutter codebase.
Member Directory:
Personalized News Feed: Developed a secure system where only verified members can receive and view important community news and announcements (both good and bad news).
Business Directory: Built a feature allowing members to add and showcase their businesses, creating a community-wide business directory.
User Profiles & Management:
Categorization System: Implemented user categorization (e.g., Business, Student, Family) for better organization and searchability.
Dashboard & Banner Management: Created an admin dashboard for managing content, including updating promotional banners and featured information.
Technologies Used: Flutter, Dart, Firebase (Authentication, Firestore, Storage)
""",
      buttonText: "Download App",
      siteUrl:
          "https://play.google.com/store/apps/details?id=com.dhasagam.patelsamaj&pli=1",
      tags: [
        "Flutter",
        "Dart",
        "Firebase",
        "Firebase Auth",
        "Cloud Firestore",
        "Firebase Storage",
        "Rest API"
            "Community App",
        "Social Network",
        "Member Directory",
        "Business Directory",
        "Mobile App",
        "iOS",
        "Android",
      ],
      isFeatured: true,
    ));

    // Chinese News App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Vision Magazine - News Platform",
      description: """
Key Features & Responsibilities:

Cross-Platform Development: Built a high-performance news application using Flutter and Dart.
REST API Integration: Seamlessly integrated with a RESTful API to fetch and display real-time news data from various international sources (e.g., New York Times, Fortune, Bloomberg).
Dual View Modes: Implemented multiple viewing experiences for users:
Page View: For a magazine-like reading experience.
List View: For quickly scanning headlines.
Advanced Pagination: Efficiently managed large datasets with pagination for smooth scrolling and optimized performance.
Robust Search Functionality: Developed a comprehensive search feature allowing users to find specific news articles across the entire catalog.
Content Rendering: Engineered a system to fetch, parse, and cleanly display HTML content within the app's mobile UI, ensuring articles render correctly.
Social Sharing & Localization: Enabled easy sharing of articles and implemented localization features to cater to a wider audience.
News Feed Management: Created a personalized and curated news feed to showcase top stories and latest updates.
Technologies Used: Flutter, Dart, REST API, HTML Rendering, Pagination, Localization
""",
      buttonText: "View App",
      isFeatured: true,
      siteUrl:
          "https://play.google.com/store/apps/details?id=tw.com.gvm.dailynews",
      tags: [
        "Flutter",
        "Dart",
        "REST API",
        "API Integration",
        "Pagination",
        "State Management",
        "Localization",
        "i18n",
        "HTML Rendering",
        "WebView",
        "Responsive UI",
        "News App",
        "Search Functionality",
        "Social Sharing",
        "Dual Layout",
        "ListView",
        "PageView",
        "Curated Feed",
        "Mobile App",
        "Cross-Platform",
      ],
    ));

    // Roommatik App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.web,
      title: "Roommatik - Roommate Finder",
      description: """
Designed and developed a comprehensive Flutter-based application and website for Roommatik, facilitating modern room management, selection, and booking. The platform provides a seamless user experience across mobile and web with advanced authentication and filtering capabilities.

Key Features & Responsibilities:

Cross-Platform Development: Built a single codebase application compatible with Android, iOS, and Web using Flutter and Dart.
Backend Integration & Hosting:
QR Code Integration: Incorporated QR code functionality for features like quick room access or information sharing.
Adaptive UI/UX: Applied flexible design principles and adaptive layout techniques to guarantee a consistent and user-friendly experience across all platforms and screen sizes.
Technologies Used:
Flutter, Dart, REST API, Firebase Hosting, QR Code Integration, Biometric Authentication

""",
      buttonText: "Visit Website",
      siteUrl: "https://roommatik-eae91.web.app",
      tags: [
        "Flutter",
        "Dart",
        "Cross-Platform",
        "Firebase Hosting",
        "REST API",
        "Biometric Auth",
        "Firebase Auth",
        "QR Code",
        "Responsive UI",
        "State Management",
        "Web App",
        "Mobile App",
        "Booking Platform",
      ],
    ));

    // Viosa Learning App
    portfolioItems.add(PortfolioModel(
      imagePath: AssetsIcons.portfolio,
      category: StringFile.mobile,
      title: "Viosa - AI Learning Platform",
      description: """
•Developed a comprehensive Flutter-based application designed to revolutionize career development by leveraging Artificial Intelligence for resume building, personalized learning, and interview preparation.
•AI Mock Interviews: Built an interactive module that uses AI to conduct practice interviews, providing users with feedback and insights.
•User Profile Management: Created a complete user profile system where users can view and edit their personal information and preferences.
•Career Guidance: Integrated AI-driven tools to offer personalized career insights and guidance based on user profiles and goals.
Technologies Used:

•Flutter & Dart: For building a high-performance, cross-platform mobile application.
•REST API: For all communication with the backend server, AI models, and cloud services.
•WebView Plugin: To integrate and display external web-based content (like the resume builder) seamlessly within the app.
•PDF Downloading: Implemented functionality to save and download files locally to the user's device.
""",
      buttonText: "Learn More",
      siteUrl: "https://play.google.com/store/apps/details?id=com.viosa.app",
      tags: [
        "Flutter",
        "Dart",
        "Mobile App",
        "Cross-Platform",
        "AI Integration",
        "REST API",
        "State Management",
        "UX/UI",
        "Career Development",
        "Firebase",
        "PDF Generation",
        "WebView",
        "Personalization",
        "Mock Interview",
      ],
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
