import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  LocaleManager._init();

  static final LocaleManager _instance = LocaleManager._init();
  static LocaleManager get instance => _instance;

  SharedPreferences? _preferences;

  static Future<void> preferencesInit() async {
    _instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getStringValue(String key) {
    return _preferences?.getString(key);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  bool? getBoolValue(String key) {
    return _preferences?.getBool(key);
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }
}
