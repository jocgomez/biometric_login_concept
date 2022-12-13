import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static SecureStorageService _instance = SecureStorageService();
  static FlutterSecureStorage? _storage;

  SecureStorageService getInstance() {
    _instance = SecureStorageService();
    _storage = _storage ?? const FlutterSecureStorage();
    return _instance;
  }

  FlutterSecureStorage? _getSecureStorage() {
    getInstance();
    return _storage;
  }

  Future<String?> getString(String key) async {
    return await _getSecureStorage()?.read(key: key);
  }

  Future<void> setString(String key, String value) async {
    return _getSecureStorage()?.write(key: key, value: value);
  }

  Future<void> deleteString(String key) async {
    return _getSecureStorage()?.delete(key: key);
  }
}
