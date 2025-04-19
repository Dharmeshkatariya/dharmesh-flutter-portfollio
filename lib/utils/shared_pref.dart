import 'dart:convert';
import 'dart:html' as html;

import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  late SharedPreferences preferences;

  String keyAuthToken = "authToken";
  String keyPatientToken = "patientAuthToken";
  String keyRefreshToken = "refreshToken";
  String keyUserId = "userId";
  String keySiteAccessId = "site-access-id";
  String keyUserType = "user-type";
  String customerId = "customer-id";
  String keyIsLoggedInWeb = "isLoggedInWeb";
  String keyIsPatientLoggedIn = "isPatientLoggedIn";
  String keyIsProviderLoggedIn = "isProviderLoggedIn";
  String keyIsGuestPatientLoggedIn = "isGuestPatientLoggedIn";
  String isRemembered = "remember-me";
  String keyFromPatient = "fromPatient";
  String keyAppLanguageLanguage = "AppLanguage";
  String keyFromDetail = "fromDetail";
  String keySymptom = "Symptom";
  String keyLat = "Lat";
  String keyLong = "Long";
  String keyInsurance = "insurance";
  String keyAppointmentData = "AppointmentData";
  String patientLoginData = "PatientLoginData";
  String patientDetail = "keyPatientDetail";
  String timerOfResetPassword = "TimerOfResetPassword";
  String currentLocation = "current-location";
  String onBoardingComplete = "onboarding_complete";
  String keySelectedAge = "selected_age";
  String keySelectedGroup = "selected_group";
  String keySpecialtiesListTopRated = "specialtiesListTopRated";
  String keyDoctorList = "doctor_list";
  String KeyTestimonialsList = "testimonialsList";
  String keyDiseasesList = "diseasesList";
  String patientLoginEmail = "email";
  String providerLoginEmail = "email";
  String patientLoginPhoneNo = "phone_number";
  String patientMyAccount = "refreshToken";
  String keyUserRoll = "user-roll";
  String keyUserRollName = "user-roll-name";
  String keySystemSettingData = "system-setting-data";
  String keyLoginUserId = "loginUserId";
  String isUserManagement = "isUserManagement";

  setStringPref(String key, String value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  Future<String> getStringPref(String key) async {
    preferences = await SharedPreferences.getInstance();
    String value = preferences.getString(key) ?? "";
    return value;
  }

  remove(String key) async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  setBooleanPref(String key, bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  Future<bool> getBooleanPref(String key) async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(key) ?? false;
    return value;
  }

  setIntPref(String key, int value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  Future<int> getIntPref(String key) async {
    preferences = await SharedPreferences.getInstance();
    int value = preferences.getInt(key) ?? 0;
    return value;
  }

  Future<void> clearSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  setIsLoggedInWeb(bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(keyIsLoggedInWeb, value);
  }

  Future<bool> isLoggedInWeb() async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(keyIsLoggedInWeb) ?? false;
    return value;
  }

  setIsPatientLoggedIn(bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(keyIsPatientLoggedIn, value);
  }

  Future<bool> isPatientLoggedIn() async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(keyIsPatientLoggedIn) ?? false;
    return value;
  }

  setIsProviderLoggedIn(bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(keyIsProviderLoggedIn, value);
  }

  Future<bool> isProviderLoggedIn() async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(keyIsProviderLoggedIn) ?? false;
    return value;
  }

  setIsGuestPatientLoggedIn(bool value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setBool(keyIsGuestPatientLoggedIn, value);
  }

  Future<bool> isGuestPatientLoggedIn() async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(keyIsGuestPatientLoggedIn) ?? false;
    return value;
  }

  Future setLanguage(String languageCode) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString(keyAppLanguageLanguage, languageCode);
  }



  Future fromDetail(bool value) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setBool(keyFromDetail, value);
  }

  Future<bool> getFromDetail() async {
    preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(keyFromDetail) ?? false;
    return value;
  }

  Future setSymptom(String languageCode) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString(keySymptom, languageCode);
  }

  Future<String> getSymptom() async {
    preferences = await SharedPreferences.getInstance();
    String languageCode = preferences.getString(keySymptom) ?? "";
    return languageCode;
  }

  Future setLat(double value) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(keyLat, value);
  }

  Future<double> getLat() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(keyLat) ?? 0;
  }

  Future setInsurance(int value) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setInt(keyInsurance, value);
  }

  Future<int> getInsurance() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt(keyInsurance) ?? 0;
  }

  Future setLong(double value) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(keyLong, value);
  }

  Future<double> getLong() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(keyLong) ?? 0;
  }





  Future<Map<String, dynamic>?> getPatientDetail() async {
    preferences = await SharedPreferences.getInstance();
    final String? mPatientData = preferences.getString(patientDetail);
    if (mPatientData != null && mPatientData.isNotEmpty) {
      return jsonDecode(mPatientData);
    }
    return null;
  }



  setTimerOfResetPassword(String value) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(timerOfResetPassword, value);
  }

  Future<String> getTimerOfResetPassword() async {
    preferences = await SharedPreferences.getInstance();
    String value = preferences.getString(timerOfResetPassword) ?? '';
    return value;
  }

  void saveSessionData(String key, String value) {
    html.window.sessionStorage[key] = value;
  }

  String? loadSessionData(String key) {
    return html.window.sessionStorage[key];
  }

  void clearSessionData() {
    html.window.sessionStorage.clear();
  }

  Future<String> getPatientLoginEmail() async {
    preferences = await SharedPreferences.getInstance();
    String patientEmail = preferences.getString(patientLoginEmail) ?? "";
    return patientEmail;
  }

  Future<String> getPatientLoginPhoneNo() async {
    preferences = await SharedPreferences.getInstance();
    String patientPhoneNo = preferences.getString(patientLoginPhoneNo) ?? "";
    return patientPhoneNo;
  }
}
