import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dharmesh_portfollio/utils/shared_pref.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';

import '../custom_view/custom_text.dart';
import '../enum/bill_pay_currency.dart';
import '../enum/display_date_type.dart';
import '../enum/enum_web_size_type.dart';
import '../enum/environment_enums.dart';
import '../enum/misc_enums.dart';
import '../model/system_model.dart';
import 'assets_icons.dart';
import 'color_file.dart';
import 'constants_file.dart';

class Common {
  String buildVersion = "v1.1(030222)"; // for Apk Build Version
  OverlayEntry? overlayEntry;
  static String tempToken = ''; //temp token for create password for new user

  toastShow(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }

  printLog(String title, String log) {
    print("--------$title-------------$log");
  }

  isNetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void showSnackBar(
    String msg, {
    SnackBarType snackBarType = SnackBarType.error,
    int duration = 3,
  }) {
    var assetName = '';
    var backgroundColor = ColorFile.errorColor;
    var primaryColor = ColorFile.whiteColor;
    switch (snackBarType) {
      case SnackBarType.error:
        assetName = AssetsIcons.icError;
        backgroundColor = ColorFile.errorColor;
        primaryColor = ColorFile.whiteColor;
        break;
      case SnackBarType.warning:
        assetName = AssetsIcons.icWarning;
        backgroundColor = ColorFile.warningColor;
        primaryColor = ColorFile.whiteColor;
        break;
      case SnackBarType.info:
        assetName = AssetsIcons.icInfo;
        backgroundColor = ColorFile.infoColor;
        primaryColor = ColorFile.whiteColor;
        break;
      case SnackBarType.success:
        assetName = AssetsIcons.icSuccess;
        backgroundColor = ColorFile.successColor;
        primaryColor = ColorFile.whiteColor;
        break;
    }
    if (!Get.isSnackbarOpen && msg.isNotEmpty) {
      Get.snackbar(
        StringFile.appName,
        msg,
        titleText: Container(),
        messageText:
            CustomText(msg, 14.sp, primaryColor, ConstantsFile.mediumFont),
        backgroundColor: backgroundColor,
        colorText: primaryColor,
        borderWidth: 1.0,
        borderRadius: 8.r,
        borderColor: primaryColor,
        mainButton: TextButton(
            onPressed: null,
            child: IconButton(
                onPressed: () {
                  if (Get.isSnackbarOpen) {
                    Get.back();
                  }
                },
                icon: const Icon(
                  Icons.close,
                  color: ColorFile.whiteColor,
                ))),
        duration: Duration(seconds: duration),
        icon: SvgPicture.asset(
          assetName,
          width: 24.w,
          height: 24.h,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        margin: EdgeInsets.only(top: 6.w, left: 6.w, right: 6.w),
      );
    }
  }

  void dismissDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static var webSizeType =
      1; // 1 for mobile, 2 for tablet, 3 for small web, 4 for medium web and 5 for large web
  static var screenWidth = 1.0;
  static var screenHeight = 1.0;
  static var unitWidth = 1.0;
  static var unitHeight = 1.0;

  static isWebSize() {
    return Common.webSizeType > EnumWebSizeType.tablet.webSizeType;
  }

  setScreenUtilDesignSize(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(Get.width, Get.height));
    var screenWidthValue = Get.width;
    var screenHeightValue = Get.height;
    screenWidth = screenWidthValue;
    screenHeight = screenHeightValue;
    unitWidth = screenWidth / 100;
    unitHeight = screenHeight / 100;

    if (screenWidthValue > 1596) {
      // Large Size Web
      webSizeType = EnumWebSizeType.largeSizeWeb.webSizeType;
    } else if (screenWidthValue > 1366 && screenWidthValue <= 1596) {
      // Medium Size Web
      webSizeType = EnumWebSizeType.mediumSizeWeb.webSizeType;
    } else if (screenWidthValue > 1024 && screenWidthValue <= 1366) {
      // Small Size Web
      webSizeType = EnumWebSizeType.smallSizeWeb.webSizeType;
    } else if (screenWidthValue > 720 && screenWidthValue <= 1024) {
      // Tablet/iPad
      webSizeType = EnumWebSizeType.tablet.webSizeType;
    } else {
      // Mobile
      webSizeType = EnumWebSizeType.mobile.webSizeType;
    }
  }

  void showProgressDialog({bool dismissible = true}) {
    Get.dialog(
        Center(
            child: CircularProgressIndicator(
          color: ColorFile.webThemeColor,
        )),
        barrierDismissible: dismissible);
  }

  void openRightSideSheet(Widget child) {
    Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: true,
      barrierColor: ColorFile.blackColor.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topRight,
          child: child,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  bottomSheet(BuildContext context, Widget child) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(child: Container(child: child));
      },
    );
  }

  dateConvert(String value, String inputDateFormat, String outputDateFormat) {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(value);

    var outputFormat = DateFormat(outputDateFormat);
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  dateConvertWithTimezone(
      String value, String inputDateFormat, String outputDateFormat,
      {bool addTimeZone = false}) {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(value);
    var outputFormat = DateFormat(outputDateFormat);
    var outputDate = outputFormat.format(inputDate);

    return "${outputDate}${addTimeZone ? ' UTC' : ''}";
  }

  dateConvertWithUTCToLocale(
      String value, String inputDateFormat, String outputDateFormat) {
    var inputFormat = DateFormat(inputDateFormat);
    DateTime inputDate = inputFormat.parse(value, true).toUtc();
    DateTime localDateTime = inputDate.toLocal();
    var outputFormat = DateFormat(outputDateFormat);
    var outputDate = outputFormat.format(localDateTime);
    return outputDate;
  }

  datePickerTheme(context, child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: ColorFile.webThemeColor,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorFile.webThemeColor, // button text color
          ),
        ),
        useMaterial3: false,
        dialogTheme: DialogThemeData(
            backgroundColor: ColorFile.whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)))),
      ),
      child: child!,
    );
  }

  void openLeftSideSheet(Widget child) {
    Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: true,
      barrierColor: ColorFile.blackColor.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topLeft,
          child: child,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 0), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  void openDialogFromTop(Widget child, {bool dismissible = true}) {
    Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: dismissible,
      barrierColor: ColorFile.blackColorOpaque80,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(alignment: AlignmentDirectional.topCenter, child: child);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 0), end: const Offset(0, 0.05))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  String getInitials(String name) {
    String initials = '';
    if (name.isEmpty || name.length < 3) return initials;
    try {
      initials = name.substring(0, 1);
      initials += name.substring(name.indexOf(' ') + 1, name.indexOf(' ') + 2);
      return initials.toUpperCase();
    } catch (e) {
      print(e);
      return name.substring(0, 2);
    }
  }

  void showSideSnackBar(RxString view, String message, {int seconds = 5}) {
    view.value = message;
    Future.delayed(
      Duration(seconds: seconds),
      () => view.value = '',
    );
  }

  showEmojiMenu(GlobalKey globalKey, BuildContext context,
      TextEditingController messageTE) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox popupButton =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    final width = 400.w;
    final Offset offset =
        popupButton.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
        context: context,
        surfaceTintColor: ColorFile.whiteColor,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + popupButton.size.height,
          offset.dx + 0,
          offset.dy +
              popupButton.size.height, // Set a fixed height for the menu
        ),
        constraints: BoxConstraints(
          minWidth: width,
          maxWidth: width,
          maxHeight: 300.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        items: [
          PopupMenuItem(
            enabled: true,
            child: EmojiPicker(
              textEditingController: messageTE,
              scrollController: ScrollController(),
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  emojiSizeMax: 28 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.2
                          : 1.0),
                ),
                swapCategoryAndBottomBar: false,
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          )
        ]);
  }

  int calculateAgeBasedOnDateOfBirth(String userDateOfBirth) {
    DateTime dateOfBirth = DateTime.parse(userDateOfBirth);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dateOfBirth.year;
    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  String mGetFullName(String? firstName, String? lastName, String? middleName) {
    if (isFieldNotEmpty(firstName) && isFieldNotEmpty(lastName)) {
      return '${firstName!} ${lastName!}';
    } else if (isFieldNotEmpty(middleName) && isFieldNotEmpty(lastName)) {
      return '${middleName!} ${lastName!}';
    } else if (isFieldNotEmpty(firstName)) {
      return firstName!;
    } else if (isFieldNotEmpty(lastName)) {
      return lastName!;
    } else if (isFieldNotEmpty(middleName)) {
      return middleName!;
    } else {
      return '';
    }
  }

  bool isFieldNotEmpty(String? fieldName) {
    return fieldName != null && fieldName.isNotEmpty;
  }

  String mGetSuffixDate(DateTime dateTime) {
    String formattedDate = DateFormat('dd').format(dateTime);
    String ordinalSuffix = getOrdinalSuffix(dateTime.day);
    String monthYear = DateFormat('MMM, yyyy').format(dateTime);
    return '$formattedDate$ordinalSuffix $monthYear';
  }

  String getCurrentYear() {
    DateTime currentDate = DateTime.now();
    String year = DateFormat('yyyy').format(currentDate);
    return year;
  }

  String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String toDomesticPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D+'), '');

    // Get the last 10 digits of the phone number
    if (digitsOnly.length < 10) {
      digitsOnly = digitsOnly.padLeft(10, '0');
    }
    String lastTenDigits = digitsOnly.substring(digitsOnly.length - 10);

    // Format the last ten digits into (###) ###-####
    return '(${lastTenDigits.substring(0, 3)})-${lastTenDigits.substring(3, 6)}-${lastTenDigits.substring(6)}';
  }

  String toInternationalPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D+'), '');

    // If the phone number has less than 10 digits, pad it with zeros
    if (digitsOnly.length < 10) {
      digitsOnly = digitsOnly.padLeft(10, '0');
    }

    // Get the country code (first one or two digits)
    String countryCode = digitsOnly.substring(0, digitsOnly.length - 10);

    // Get the last 10 digits of the phone number
    String lastTenDigits = digitsOnly.substring(digitsOnly.length - 10);

    // Format the phone number as (<countrycode>)-###-###-####
    return '($countryCode)-${lastTenDigits.substring(0, 3)}-${lastTenDigits.substring(3, 6)}-${lastTenDigits.substring(6)}';
  }

  String formatDuration(DateTime expiryTime, DateTime currentTime) {
    Duration duration = expiryTime.difference(currentTime);
    int seconds = duration.inSeconds;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  List<TextInputFormatter>? mGetInputFormat(TextInputType textInputType,
      {String? hintText}) {
    List<TextInputFormatter>? inputFormatter = [];
    if (textInputType == TextInputType.text) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z,' ]"))
      ];
    } else if (textInputType == TextInputType.name) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z,' ]"))
      ];
    } else if (textInputType == TextInputType.emailAddress) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@_.-]")),
      ];
    } else if (textInputType == TextInputType.number) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ];
    } else if (textInputType == TextInputType.phone) {
      MaskTextInputFormatter maskFormatter;
      if (hintText != null && hintText == StringFile.colorCodeHint) {
        maskFormatter = MaskTextInputFormatter(
            mask: '#####-####',
            filter: {"#": RegExp(r'\d')},
            type: MaskAutoCompletionType.lazy);
      } else {
        maskFormatter = MaskTextInputFormatter(
            mask: '###-###-####',
            filter: {"#": RegExp(r'\d')},
            type: MaskAutoCompletionType.lazy);
      }

      inputFormatter = [maskFormatter];
    } else if (textInputType == TextInputType.streetAddress) {
      // using this for Zip codes
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9 -]")),
      ];
    } else if (textInputType == TextInputType.datetime) {
      var maskFormatter = MaskTextInputFormatter(
          mask: '##/##/####',
          filter: {"#": RegExp(r'\d')},
          type: MaskAutoCompletionType.lazy);
      inputFormatter = [maskFormatter];
    }
    return inputFormatter;
  }

  Future<bool> checkAuth() async {
    String id = await SharedPref().getStringPref(SharedPref().keySiteAccessId);
    return id.isNotEmpty;
  }

  mFormatPhoneNumber(String phoneNumber) {
    try {
      bool isFormatted = isUSPhoneNumberFormatted(phoneNumber);
      if (isFormatted) {
        return phoneNumber;
      } else {
        phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
        return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
      }
    } catch (e) {
      printLog('PhoneFormatException', e.toString());
      return phoneNumber;
    }
  }

  bool isUSPhoneNumberFormatted(String phoneNumber) {
    // Regular expression to match the format (###) ###-####
    RegExp regExp = RegExp(r'^\d{3}-\d{3}-\d{4}$');
    return regExp.hasMatch(phoneNumber);
  }

  void showCustomMenu(
    BuildContext context,
    Widget child,
    GlobalKey globalKey, {
    double? width,
    double? height,
    bool? isDynamicHeight = false,
  }) {
    final RenderBox overlay = Get.context!.findRenderObject() as RenderBox;
    final RenderBox popupButton =
        globalKey.currentContext!.findRenderObject() as RenderBox;

    width ??= globalKey.currentContext!.size!.width;
    height ??= Get.height;
    final Offset offset =
        popupButton.localToGlobal(Offset.zero, ancestor: overlay);
    var _buttonPositionY = offset.dy;
    var _maxOverlayHeight = MediaQuery.of(context).size.height -
        _buttonPositionY -
        popupButton.size.height -
        8; // adjust margin as needed

    overlayEntry = OverlayEntry(
      builder: (context) => Container(
        width: Get.width,
        height: (isDynamicHeight!) ? null : Get.height,
        constraints:
            (isDynamicHeight) ? null : BoxConstraints(maxHeight: 350.w),
        child: Stack(
          children: [
            ModalBarrier(onDismiss: () {
              dismissOverlay();
            }),
            Positioned(
              height: (isDynamicHeight)
                  ? null
                  : (_maxOverlayHeight < 550.h)
                      ? _maxOverlayHeight
                      : 450.h,
              width: width,
              left: offset.dx,
              top: offset.dy + popupButton.size.height,
              // right: offset.dx + 0,
              // bottom: offset.dy + popupButton.size.height,

              child: Material(
                type: MaterialType.card,
                color: ColorFile.whiteColor,
                borderRadius: BorderRadius.circular(8.r),
                elevation: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                      constraints: (isDynamicHeight)
                          ? null
                          : BoxConstraints(maxHeight: 350.w),
                      child: child),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Insert overlay entry into the overlay
    Overlay.of(Get.overlayContext!).insert(overlayEntry!);
  }

  void dismissOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  bool isEmail(String text) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(text);
  }

  Size getWidgetSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }

  static String extractNumber(String formattedNumber) {
    String digits = formattedNumber.replaceAll(RegExp(r'\D'), '');
    return digits;
  }

  isContainPage(Pattern route) {
    bool returnValue = false;
    String url = window.location.href;
    if (url.contains(route)) {
      returnValue = true;
    }
    return returnValue;
  }

  static List<String> countyCodeList = [
    '+1',
    '+7',
    '+20',
    '+27',
    '+30',
    '+31',
    '+32',
    '+33',
    '+34',
    '+36',
    '+39',
    '+40',
    '+41',
    '+43',
    '+44',
    '+45',
    '+46',
    '+47',
    '+48',
    '+49',
    '+51',
    '+52',
    '+53',
    '+54',
    '+55',
    '+56',
    '+57',
    '+58',
    '+60',
    '+61',
    '+62',
    '+63',
    '+64',
    '+65',
    '+66',
    '+81',
    '+82',
    '+84',
    '+86',
    '+90',
    '+91',
    '+92',
    '+93',
    '+94',
    '+95',
    '+98',
    '+211',
    '+212',
    '+213',
    '+216',
    '+218',
    '+220',
    '+221',
    '+222',
    '+223',
    '+224',
    '+225',
    '+226',
    '+227',
    '+228',
    '+229',
    '+230',
    '+231',
    '+232',
    '+233',
    '+234',
    '+235',
    '+236',
    '+237',
    '+238',
    '+239',
    '+240',
    '+241',
    '+242',
    '+243',
    '+244',
    '+245',
    '+246',
    '+248',
    '+249',
    '+250',
    '+251',
    '+252',
    '+253',
    '+254',
    '+255',
    '+256',
    '+257',
    '+258',
    '+260',
    '+261',
    '+262',
    '+263',
    '+264',
    '+265',
    '+266',
    '+267',
    '+268',
    '+269',
    '+290',
    '+291',
    '+297',
    '+298',
    '+299',
    '+350',
    '+351',
    '+352',
    '+353',
    '+354',
    '+355',
    '+356',
    '+357',
    '+358',
    '+359',
    '+370',
    '+371',
    '+372',
    '+373',
    '+374',
    '+375',
    '+376',
    '+377',
    '+378',
    '+379',
    '+380',
    '+381',
    '+382',
    '+383',
    '+385',
    '+386',
    '+387',
    '+389',
    '+420',
    '+421',
    '+423',
    '+500',
    '+501',
    '+502',
    '+503',
    '+504',
    '+505',
    '+506',
    '+507',
    '+508',
    '+509',
    '+590',
    '+591',
    '+592',
    '+593',
    '+594',
    '+595',
    '+596',
    '+597',
    '+598',
    '+599',
    '+670',
    '+672',
    '+673',
    '+674',
    '+675',
    '+676',
    '+677',
    '+678',
    '+679',
    '+680',
    '+681',
    '+682',
    '+683',
    '+685',
    '+686',
    '+687',
    '+688',
    '+689',
    '+690',
    '+691',
    '+692',
    '+850',
    '+852',
    '+853',
    '+855',
    '+856',
    '+880',
    '+886',
    '+960',
    '+961',
    '+962',
    '+963',
    '+964',
    '+965',
    '+966',
    '+967',
    '+968',
    '+970',
    '+971',
    '+972',
    '+973',
    '+974',
    '+975',
    '+976',
    '+977',
    '+992',
    '+993',
    '+994',
    '+995',
    '+996',
    '+998'
  ];

  static int getAgeFromDob({required DateTime birthDate}) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String getGender({required String gender}) {
    if (gender.contains("M")) {
      return "Male";
    } else {
      return "Female";
    }
  }

  setThemeColor({Color? themeColor}) async {
    String storedData =
        await SharedPref().getStringPref(SharedPref().keySystemSettingData);
    if (storedData.isNotEmpty) {
      SystemSettingModel decodedData =
          SystemSettingModel.fromJson(json.decode(storedData));
      Color color = ColorFile.hexToColor(decodedData.data!.brandColor!);
      ColorFile.webThemeColor = color;
      ColorFile.webThemeColorOpaque30 = color.withOpacity(0.3);
      ColorFile.webThemeColorOpaque50 = color.withOpacity(0.5);
      ColorFile.webThemeColorOpaque5 = color.withOpacity(0.05);
      ColorFile.webThemeColorOpaque15 = color.withOpacity(0.15);
      ColorFile.webThemeColorOpaque10 = color.withOpacity(0.1);
      ColorFile.webDarkThemeColor = darken(color, 0.1);
    } else {
      ColorFile.webThemeColor = themeColor!;
      ColorFile.webThemeColorOpaque30 = themeColor.withOpacity(0.3);
      ColorFile.webThemeColorOpaque50 = themeColor.withOpacity(0.5);
      ColorFile.webThemeColorOpaque5 = themeColor.withOpacity(0.05);
      ColorFile.webThemeColorOpaque15 = themeColor.withOpacity(0.15);
      ColorFile.webThemeColorOpaque10 = themeColor.withOpacity(0.1);
      ColorFile.webDarkThemeColor = darken(themeColor, 0.1);
    }
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  void setFavicon(String file) {
    final existingIcon = html.document.querySelector("link[rel*='icon']");
    if (existingIcon != null) {
      existingIcon.remove();
    }

    final link = html.LinkElement()
      ..rel = 'icon'
      ..type = 'image/png'
      ..href = file;

    Common().printLog('Link', link.toString());
    // Append the new favicon to the head
    html.document.head!.append(link);
  }

  static String getCurrentLocale() {
    return html.window.navigator.language;
  }

  static String displayLocalDate({
    required String inputDate,
    required DisplayDateType displayDateType,
    String? customFormat,
    String? locale,
  }) {
    String outputDate = "";
    try {
      DateTime parsedUtcTime = DateTime.parse(inputDate);
      DateTime localTime = parsedUtcTime.toLocal();
      String currentLocale = locale ?? Intl.getCurrentLocale();
      if (customFormat != null && customFormat.isNotEmpty) {
        outputDate = DateFormat(customFormat, currentLocale).format(localTime);
      } else if (displayDateType == DisplayDateType.date) {
        // outputDate = DateFormat.yMd(currentLocale).format(localTime);
        outputDate =
            DateFormat(ConstantsFile.mDY, currentLocale).format(localTime);
      } else if (displayDateType == DisplayDateType.time) {
        // outputDate = DateFormat.jm(currentLocale).format(localTime);
        outputDate =
            DateFormat(ConstantsFile.hhMMA, currentLocale).format(localTime);
      } else if (displayDateType == DisplayDateType.dateAndTime) {
        outputDate = DateFormat(
                '${ConstantsFile.mDY}, ${ConstantsFile.hhMMA}', currentLocale)
            .format(localTime);
      } else {
        // outputDate = DateFormat.yMd(currentLocale).format(localTime);
        outputDate =
            DateFormat(ConstantsFile.mDY, currentLocale).format(localTime);
      }
    } catch (e) {
      outputDate = "";
    }

    return outputDate;
  }

// static String displayLocalDate({
  //   required String inputDate,
  //   required DisplayDateType displayDateType,
  //   String? customFormat,
  // }) {
  //   String outputDate = "";
  //   DateTime parsedUtcTime = DateTime.parse(inputDate);
  //   DateTime localTime = parsedUtcTime.toLocal();
  //   if (displayDateType == DisplayDateType.date) {
  //     //  10/25/2024,
  //     outputDate = DateFormat(ConstantsFile.mDY).format(localTime);
  //     return outputDate;
  //   } else if (displayDateType == DisplayDateType.time) {
  //     /// 02:45 PM
  //     outputDate = DateFormat(ConstantsFile.hhMMA).format(localTime);
  //   } else if (displayDateType == DisplayDateType.dateAndTime) {
  //     // 10/25/2024, 02:45 PM
  //     outputDate = DateFormat(ConstantsFile.mDYhhMMA).format(localTime);
  //   } else {
  //     // 10/25/2024,
  //     outputDate = DateFormat(ConstantsFile.mDY).format(localTime);
  //     return outputDate;
  //   }
  //   return outputDate;
  // }
  static String userProfileFromFirstLastName({
    required String firstName,
    required String lastName,
  }) {
    String userProfile = "";
    if (firstName.isNotEmpty) {
      userProfile += firstName[0].toUpperCase();
    }
    if (lastName.isNotEmpty) {
      userProfile += lastName[0].toUpperCase();
    }
    return userProfile;
  }

  static String userProfileFromFirsLetter({
    required String firstName,
  }) {
    String userProfile = "";
    if (firstName.isNotEmpty) {
      userProfile += firstName[0].toUpperCase();
    }

    return userProfile;
  }

  static String displayCurrencySymbol() {
    BillPayCurrencyType billPayCurrencyType = ConstantsFile.billPayCurrencyType;
    if (billPayCurrencyType == BillPayCurrencyType.uSD) {
      return '\$';
    } else if (billPayCurrencyType == BillPayCurrencyType.iNR) {
      return '₹';
    } else {
      return '\$';
    }
  }

  static String dateConvertApiFormat({required String selectedDate}) {
    String date = selectedDate.trim().isNotEmpty
        ? Common().dateConvert(
            selectedDate.trim(), ConstantsFile.mDY, ConstantsFile.yyyyMMDD)
        : '';
    return date;
  }

  //for (###)-###-####
  static String displayFormatMobileNumber(String mobileNumber) {
    // Ensure the number has 10 digits
    if (mobileNumber.length != 10) {
      return mobileNumber;
    }
    // Extract parts of the number
    final areaCode = mobileNumber.substring(0, 3);
    final middlePart = mobileNumber.substring(3, 6);
    final lastPart = mobileNumber.substring(6, 10);
    return '($areaCode)-$middlePart-$lastPart';
  }

  static String formatDouble(dynamic value) {
    try {
      if (value == null) {
        return "0.00";
      }
      if (value is double) {
        return value.toStringAsFixed(2);
      }
      if (value is int) {
        return value.toDouble().toStringAsFixed(2);
      }
      if (value is String) {
        double? parsedValue = double.tryParse(value);
        if (parsedValue != null) {
          return parsedValue.toStringAsFixed(2);
        }
      }
      return "0.00";
    } catch (e) {
      return "0.00";
    }
  }

  String displayDurationFormat(double durationInSeconds) {
    int hours = durationInSeconds ~/ 3600;
    int minutes = (durationInSeconds % 3600) ~/ 60;
    int seconds = (durationInSeconds % 60).round();
    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  String removeDashes({required String cardNumber}) {
    return cardNumber.replaceAll('-', '');
  }

  String displayFormatCardNumber(String rawCardNumber) {
    // Remove non-digit characters
    String nonDigitFormat = rawCardNumber.replaceAll(RegExp(r'\D'), '');
    // Add formatting for every 4 digits
    final dashStringFormating = StringBuffer();
    for (int i = 0; i < nonDigitFormat.length; i++) {
      dashStringFormating.write(nonDigitFormat[i]);
      if ((i + 1) % 4 == 0 && i + 1 != nonDigitFormat.length) {
        dashStringFormating.write('-');
      }
    }
    return dashStringFormating.toString();
  }

  String displayFormatCardNumberLastFourDigitOnly(String rawCardNumber) {
    // Remove non-digit characters
    String nonDigitFormat = rawCardNumber.replaceAll(RegExp(r'\D'), '');

    // Ensure the card number is at least 4 digits long
    if (nonDigitFormat.length < 4) {
      return nonDigitFormat; // Return as is if less than 4 digits
    }

    // Get the last 4 digits
    String lastFourDigits = nonDigitFormat.substring(nonDigitFormat.length - 4);

    // Format the masked card number
    return '**** **** **** $lastFourDigits';
  }

  static EnvironmentEnums getEnvironment() {
    var dynamicUrl = window.location.host;
    if (dynamicUrl.contains('dev')) {
      return EnvironmentEnums.dev;
    } else if (dynamicUrl.contains('qa')) {
      return EnvironmentEnums.qa;
    } else if (dynamicUrl.contains('demo')) {
      return EnvironmentEnums.demo;
    } else if (dynamicUrl.contains('prod')) {
      return EnvironmentEnums.prod;
    } else if (dynamicUrl.contains('stag')) {
      return EnvironmentEnums.staging;
    } else {
      return EnvironmentEnums.dev;
    }
  }

  static String? getInTakeFormId(EnvironmentEnums environment) {
    switch (environment) {
      case EnvironmentEnums.dev:
        return '0a06e2af-70cd-4c7a-b263-a6835cd0d976';
      case EnvironmentEnums.qa:
        return '9656beee-832f-438c-a026-d29482865064';
      case EnvironmentEnums.prod:
        return '';
      case EnvironmentEnums.demo:
        return '';
      case EnvironmentEnums.staging:
        return '';
    }
  }

  Color getColorBasedOnStatus(String visitStatus) {
    switch (visitStatus) {
      case "CANCELLED":
        return const Color(0xffff0000);
      case "CONFIRMED":
        return const Color(0xff3b1550);
      case "ARRIVED":
        return const Color(0xff008bcc);
      case "CHECKED-IN":
        return const Color(0xffe49400);
      case "RESCHEDULED":
        return Colors.purple;
      case "PENDING":
        return Colors.blueGrey;
      case "NO_SHOW":
        return Colors.tealAccent;
      case "Not-Verified":
        return ColorFile.failStatusColor;
      default:
        return Colors.green;
    }
  }

  getStatusUntilCompleteAppointment() {
    return "PENDING,SCHEDULED,ARRIVED,BEGIN_INTAKE,COMPLETE_INTAKE,BEGIN_TRIAGE,COMPLETE_TRIAGE,BEGIN_CLN_ASSESS,RESCHEDULED";
  }

  void carousalScrollListener(ScrollController scrollController,
      Rx<bool> isAtStart, Rx<bool> isAtEnd, Rx<bool> isAtMiddle) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          isAtStart(false);
          isAtEnd(true);
          isAtMiddle(false);
        } else {
          isAtStart(true);
          isAtEnd(false);
          isAtMiddle(false);
        }
      } else {
        isAtMiddle(true);
        isAtStart(false);
        isAtEnd(false);
      }
    });
  }

  void carousalScrollToItem(ScrollController scrollController, bool isForward) {
    final double difference = Get.width / 3;
    final double currentPosition = scrollController.position.pixels;
    final double nextPosition = currentPosition + difference;
    final double previousPosition = currentPosition - difference;

    scrollController.animateTo(
      (isForward) ? nextPosition : previousPosition,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  num getSideDialogWidth() {
    return Common.isWebSize() ? 500 : Get.width;
  }

  static String displayFirstCapital({required String text}) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String displayFormatRemoveUnderScore({required String text}) {
    if (text.isEmpty) return text;
    return text
        .toLowerCase()
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static double parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  getStringWithoutBreakLine(String strValue) {
    return strValue.replaceAll("\n", " ");
  }

  static String getLastWeekFromDate() {
    DateTime today = DateTime.now();
    DateTime currentWeekMonday =
        today.subtract(Duration(days: today.weekday - 1));
    DateTime lastWeekMonday =
        currentWeekMonday.subtract(const Duration(days: 7));
    return DateFormat(ConstantsFile.mDY).format(lastWeekMonday);
  }

  static String getLastWeekToDate() {
    DateTime today = DateTime.now();
    DateTime currentWeekMonday =
        today.subtract(Duration(days: today.weekday - 1));
    DateTime lastWeekSunday =
        currentWeekMonday.subtract(const Duration(days: 1));
    return DateFormat(ConstantsFile.mDY).format(lastWeekSunday);
  }

  static Future<Uint8List> loadRootAssetBundle(
      {required String loadAssetPath}) async {
    final ByteData bytes = await rootBundle.load(loadAssetPath);
    final Uint8List pdfData = bytes.buffer.asUint8List();
    return pdfData;
  }

  static String generateDisplayId({required String billId}) {
    String lastSix = billId.substring(billId.length - 6).toUpperCase();
    String numericOnly = lastSix.replaceAll(RegExp(r'[^0-9]'), '');
    int numericValue = numericOnly.isNotEmpty ? int.parse(numericOnly) : 0;
    int lastTwoDigits = numericValue % 100;
    int sequenceNumber = 10000000 + lastTwoDigits;
    return "HEREFIN$sequenceNumber";
    // String lastSix = billId.substring(billId.length - 6).toUpperCase();
    // int numericValue = lastSix.runes.fold(0, (sum, char) => sum + char) % 100;
    // int sequenceNumber = 10000000 + numericValue;
    // return "HEREFIN$sequenceNumber";
  }

  static bool isNotEmpty(String? fieldName) {
    return fieldName != null && fieldName.isNotEmpty;
  }

  static String displayFullName(
      {String? firstName, String? lastName, String? middleName}) {
    List<String> nameParts = [];
    if (isNotEmpty(firstName)) {
      nameParts.add(firstName!.trim());
    }
    if (isNotEmpty(middleName)) {
      nameParts.add(middleName!.trim());
    }
    if (isNotEmpty(lastName)) {
      nameParts.add(lastName!.trim());
    }
    return nameParts.isNotEmpty ? nameParts.join(' ') : '';
  }

  static String displayCommaFormatAddress({
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? country,
    String? zip,
  }) {
    List<String> addressParts = [];

    if (isNotEmpty(address1)) addressParts.add(address1!.trim());
    if (isNotEmpty(address2)) addressParts.add(address2!.trim());
    if (isNotEmpty(city)) addressParts.add(city!.trim());
    if (isNotEmpty(state)) addressParts.add(state!.trim());
    if (isNotEmpty(country)) addressParts.add(country!.trim());
    if (isNotEmpty(zip)) addressParts.add(zip!.trim());

    return addressParts.isNotEmpty ? addressParts.join(', ') : '';
  }

  Future<Uint8List> createUint8ListFromString(
      {required String base64String}) async {
    final encodedStr = base64String;
    Uint8List bytes = base64.decode(encodedStr);
    return bytes;
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // File file = File(
    //     "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    // await file.writeAsBytes(bytes);
    // return file.path;
    // return '';
  }

  static String displayGetInstallment(
      {required String totalAmount, required int installment}) {
    String finalAmount = '0.0';
    try {
      double amount = double.parse(totalAmount);
      if (amount > 0) {
        double amountIns = amount / installment;
        finalAmount = amountIns.toStringAsFixed(2);
      }
      return finalAmount;
    } catch (e) {
      return finalAmount;
    }
  }

  String numberToOrdinal(int number) {
    if (number <= 0) return number.toString(); // Handle non-positive numbers

    int lastDigit = number % 10;
    int lastTwoDigits = number % 100;

    String suffix;
    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      suffix = "th"; // Special cases for 11, 12, 13
    } else {
      switch (lastDigit) {
        case 1:
          suffix = "st";
          break;
        case 2:
          suffix = "nd";
          break;
        case 3:
          suffix = "rd";
          break;
        default:
          suffix = "th";
      }
    }

    return "$number$suffix";
  }
}
