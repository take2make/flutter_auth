import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKey {
  firstName,
  secondName,
  accessToken,
  refreshToken,
  subscription,
  isLoggedIn,
}

///
/// Хранение общедоступной информации
///

class LocalStorageService {
  static late final SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setValue(PreferenceKey key, String value) async {
    return _setString(key.toString(), value);
  }

  static String getValue(PreferenceKey key, [String defValue = ""]) {
    return _getString(key.toString());
  }

  static Future<bool> _setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  static String _getString(String key, [String defValue = ""]) {
    return _prefs.getString(key) ?? defValue;
  }

  static bool getBool(PreferenceKey key, [bool defValue = false]) {
    return _prefs.getBool(key.toString()) ?? defValue;
  }

  static Future<bool> setBool(PreferenceKey key, bool value) {
    return _prefs.setBool(key.toString(), value);
  }

  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
