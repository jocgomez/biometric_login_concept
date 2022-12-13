import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance = LocalStorageService();
  static SharedPreferences? _preferences;

  Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = _preferences ?? await SharedPreferences.getInstance();
    return _instance;
  }

  Future<SharedPreferences?> _getPreferences() async {
    await getInstance();
    return _preferences;
  }

  Future<String?> getString(String key) async {
    return (await _getPreferences())?.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return (await _getPreferences())?.setString(key, value) ??
        Future(() => false);
  }

  Future<bool?> getBool(String key) async {
    return (await _getPreferences())?.getBool(key);
  }

  Future<bool?> setBool(String key, bool value) async {
    return await (await _getPreferences())?.setBool(key, value);
  }
}
