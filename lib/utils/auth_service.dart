

import 'package:dharmesh_portfollio/utils/shared_pref.dart';

class AuthService {
  // Private constructor
  AuthService._internal();

  // Static instance
  static final AuthService _instance = AuthService._internal();

  // Static getter for the instance
  static AuthService get instance => _instance;

  // Cached user ID
  String? _cachedUserId;
  bool hasPatientAcquisitionPermission = false;
  bool hasProviderAcquisitionPermission = false;

  Future<String> getCurrentUserId() async {
    // Return cached value if available
    if (_cachedUserId != null) return _cachedUserId!;

    final isPatientPortal = await SharedPref().isPatientLoggedIn();
    String userId = '';



    // Cache the result
    _cachedUserId = userId;
    return userId;
  }

  void clearUserIdCache() {
    _cachedUserId = null;
  }

  void getPatientAcquisitionPermission(){
    hasPatientAcquisitionPermission = true;
  }

  void getProviderAcquisitionPermission(){
    hasProviderAcquisitionPermission = true;
  }

}