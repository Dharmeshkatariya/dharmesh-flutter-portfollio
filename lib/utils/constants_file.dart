import 'dart:ui';

import 'package:get/get.dart';
import '../enum/bill_pay_currency.dart';

class ConstantsFile {
  static var themeColor = const Color(0xFFD9001D).obs;
  static var themeColor50 = const Color(0x80D9001D).obs;
  static var themeColor15 = const Color(0x26D9001D).obs;
  static var drawerColor = const Color(0xFFF0403E).obs;
  static var darkThemeColor = const Color(0xFF6D0E1B).obs;

  static const String appName = 'HelixDoc';
  static const String boldFont = 'BoldFontMontserrat';
  static const String regularFont = 'RegularFontMontserrat';
  static const String semiBoldFont = 'SemiBoldFontMontserrat';
  static const String mediumFont = 'MediumFontMontserrat';
  static const String italicFont = 'italicFontMontserrat';

  static const String fcmVapidKey = "BFFP9Z0YE3mg-wo0uLdEw7_LJ07udZZhfnZdUdmACMERO8JDyddvzfdmt-U3m5yypfvqwEzxcI0g3XGcXCS8SH0";

  static const String checkBoxTag = 'checkbox';
  static const String messageViewTag = 'message-view';
  static const String bookViewTag = 'book-view';
  static const String detailViewTag = 'detail-view';
  static const String locationTag = 'location';
  static const String permissionTag = 'permissions';
  static const String editTag = 'edit';
  static const String selectionTag = 'select';
  static const String editLocationTag = 'edit-location';
  static const String deleteTag = 'delete';
  static const String switchTag = 'switch';
  static const String smsTag = 'sms';
  static const String callTag = 'call';
  static const String chatTag = 'chat';
  static const String isActive = 'is-active';
  static const String providerTag = 'provider-tag';
  static const String organizationTag = 'organization-tag';
  static const String moreTag = 'more-tag';
  static const String favoriteTag = 'favorite-tag';
  static const String activeTag = 'active-tag';
  static const String isLocation = 'is-location';

  static const String contentType = 'Content-Type';
  static const String applicationJSON = 'application/json';
  static const String authorization = 'Authorization';

  static String webHomePageController = 'web-home-page-controller';
  static String primarySideBarIndex = 'primarySideBarIndex';
  static String openLogin = 'openLogin';
  static String urlToGo = 'url to go';
  static String subPage = 'sub_page';
  static String previousPage = 'previous-page';

  static String address1 = 'address1';
  static String address2 = 'address2';
  static String city = 'city';
  static String zip = 'zip';
  static String state = 'state';
  static String country = 'country';

  static String helixPatient = 'HelixPatient';
  static String helixStaff = 'HelixStaff';
  static String helixUser = 'HelixUser';

  static String provider = 'provider';
  static String nurse = 'nurse';
  static String patient = 'patient';
  static String resend = 'resend';

  static String uid = 'uid';
  static String approveTag = 'approve';
  static String priorityChangeTag = 'priority-change-Tag';
  static String cancelTag = 'cancel';

  // static const String defaultVisitType = 'NP_PHY';
  static const String participant = 'participant';
  static const String female = 'female';
  static const String other = 'OTHER';
  static const int successStatusCode = 200;
  static const int otpExpireTime = 300;
  static const String minute = 'minute';
  static const String minutes = 'minutes';
  static const String second = 'second';
  static const String seconds = 'seconds';

  // const Input mask
  static const String phoneMask = '(###)-###-####';
  static const String zipMask = '#####-####';

  static const String mainTab = 'main-tab';
  static const String subTab = 'sub-tab';
  static const double horizontalPaddingRatio = 5.5;
  static const double horizontalPaddingRatioMobile = 3.8;

  static const String dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'";

  static const String mmDDYyyy = "MMM dd yyyy";  //
  static const String MDY = "dd-MM-yyyy";  //
  //  Oct 25 2024
  static const String mDY = "MM/dd/yyyy"; //  10/25/2024
  static const String hhMMA = "hh:mm a";
  static const String hhMMAz = "hh:mm a z";
  static const String eeeMMMddYYYY = "EEE MMM dd, yyyy";
  static const String mDYhhMMA = "MM/dd/yyyy, hh:mm a";  //  10/25/2024, 02:45 PM
  static const String yyyyMMDDHHmmSS = "yyyy-MM-dd HH:mm:ss";  //  10/25/2024, 02:45 PM


  static const String mmmDDYyyyHHMMA = "MMM dd, yyyy, hh:mm a"; //  Oct 25, 2024, 02:45 PM
  static const String yyyyMMDD = "yyyy-MM-dd";    //  2024-10-25
  static const String eeeMmmDDHhMma = "EEE, MMM dd, hh:mm a";      //  Fri, Oct 25, 02:45 PM
  static const String mmmDDYyyyHhMMA = "MMM dd, yyyy, hh:mm a";    //  Oct 25, 2024, 02:45 PM
  static const String eEE = "EEE";      //  Fri (for Mon, Tue, Wed)
  static const String eEEE = "EEEE";     //  Friday (for Monday, Tuesday, Wednesday)
  static const String mMM = "MMM";         //  Oct (for Jan, Feb, Oct)
  static const String mMMM = "MMMM";        // October (for January, February, October)
  static const String eD = "E d";
  static const String mMMddYYY = "MMM dd, yyyy";       //  Oct 25, 2024
  static const String eeeMMD = "EEE, MMM d";      //  Fri, Oct 25
  static const String mmmmYYYY = "MMMM, yyyy";     //  October, 2024
  static const String HHmm = "HH:mm";     //  October, 2024
  static const String hhmm = "hh:mm";     //  October, 2024
  static const String dd = "dd";     //  19
  static const String E = "E";     //  Sun

  static String isTrue = 'true';
  static String isFalse = 'false';

  static BillPayCurrencyType billPayCurrencyType = BillPayCurrencyType.uSD;

  static const String eid = "eid";
  static bool isLoginDialogOpen = false;
  static const String isFromTakeVitals = "isFromTakeVitals";
  static const String aid = "aid";
  static List<String> vitalList = [
    "TEMP",
    "BP",
    "PULSE",
    "RRATE",
    "SPO2",
  ];
  static const String isLocked = "isLocked";
  static const String status = "status";
}

