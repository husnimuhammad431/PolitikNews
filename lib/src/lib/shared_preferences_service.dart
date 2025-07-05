import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setHasSeenIntroduction(bool value) async {
    await _preferences?.setBool('has_seen_introduction', value);
  }

  static bool getHasSeenIntroduction() {
    return _preferences?.getBool('has_seen_introduction') ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    await _preferences?.setBool('is_logged_in', value);
  }

  static bool getIsLoggedIn() {
    return _preferences?.getBool('is_logged_in') ?? false;
  }

  static Future<void> setToken(String token) async {
    await _preferences?.setString('auth_token', token);
  }

  static String? getToken() {
    return _preferences?.getString('auth_token');
  }

  static Future<void> setUserData({
    required String name,
    required String email,
    String? userId,
    String? bio,
    String? avatarUrl,
  }) async {
    await _preferences?.setString('user_name', name);
    await _preferences?.setString('user_email', email);
    if (userId != null) await _preferences?.setString('user_id', userId);
    if (bio != null) await _preferences?.setString('user_bio', bio);
    if (avatarUrl != null) {
      await _preferences?.setString('user_avatar', avatarUrl);
    }
  }

  static Map<String, String?> getUserData() {
    return {
      'name': _preferences?.getString('user_name'),
      'email': _preferences?.getString('user_email'),
      'id': _preferences?.getString('user_id'),
      'bio': _preferences?.getString('user_bio'),
      'avatar': _preferences?.getString('user_avatar'),
    };
  }

  static Future<void> clearAll() async {
    await _preferences?.clear();
  }

  static Future<void> logout() async {
    await _preferences?.setBool('is_logged_in', false);
    await _preferences?.remove('auth_token');
    await _preferences?.remove('user_name');
    await _preferences?.remove('user_email');
    await _preferences?.remove('user_id');
    await _preferences?.remove('user_bio');
    await _preferences?.remove('user_avatar');
  }
}
