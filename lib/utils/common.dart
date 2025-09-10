import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dharmesh_portfollio/utils/shared_pref.dart';
import 'package:dharmesh_portfollio/utils/string_file.dart';

import '../custom_view/custom_text.dart';
import '../enum/enum_web_size_type.dart';
import '../enum/misc_enums.dart';
import '../model/system_model.dart';
import 'assets_icons.dart';
import 'color_file.dart';
import 'constants_file.dart';

class Common {
  String buildVersion = "v1.1(030222)"; // for Apk Build Version
  OverlayEntry? overlayEntry;
  static String tempToken = ''; //temp token for create password for new user


  printLog(String title, String log) {
    print("--------$title-------------$log");
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

  String getCurrentYear() {
    DateTime currentDate = DateTime.now();
    String year = DateFormat('yyyy').format(currentDate);
    return year;
  }



  Future<bool> checkAuth() async {
    String id = await SharedPref().getStringPref(SharedPref().keySiteAccessId);
    return id.isNotEmpty;
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

  static String userProfileFromFirsLetter({
    required String firstName,
  }) {
    String userProfile = "";
    if (firstName.isNotEmpty) {
      userProfile += firstName[0].toUpperCase();
    }

    return userProfile;
  }
}
