import 'package:bookease/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs?.setString(ApiConstants.accessTokenKey, accessToken);
    await _prefs?.setString(ApiConstants.refreshTokenKey, refreshToken);
  }

  String? getAccessToken() {
    return _prefs?.getString(ApiConstants.accessTokenKey);
  }

  String? getRefreshToken() {
    return _prefs?.getString(ApiConstants.refreshTokenKey);
  }

  Future<void> saveRole(String role) async {
    await _prefs?.setString(ApiConstants.userRoleKey, role);
  }

  String? getRole() {
    return _prefs?.getString(ApiConstants.userRoleKey);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
