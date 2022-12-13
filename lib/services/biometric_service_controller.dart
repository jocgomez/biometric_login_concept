import 'package:biometric_login_concept/services/local_auth_service.dart';
import 'package:biometric_login_concept/services/local_storage_service.dart';
import 'package:biometric_login_concept/services/secure_storage_service.dart';
import 'package:get/get.dart';

class BiometricServiceController extends GetxController {
  final LocalStorageService _localStorageService =
      Get.find<LocalStorageService>();
  final SecureStorageService _secureStorageService =
      Get.find<SecureStorageService>();
  final LocalAuthService _localAuthService = Get.find<LocalAuthService>();

  Future<bool> isBiometricEnabled() async {
    final availableBiometrics =
        await _localAuthService.getAvailableBiometrics();

    return await _localAuthService.supportBiometric() &&
        await _localAuthService.canCheckBiometrics() &&
        availableBiometrics.isNotEmpty;
  }

  Future<bool?> hasEnableBiometricAuth() async {
    return await getBoolFromLocalStorage('enableBiometricAuth');
  }

  Future<bool> biometricAuthenticate() async {
    if (await isBiometricEnabled()) {
      final isAuth = await _localAuthService.authenticate();
      return isAuth;
    } else {
      return false;
    }
  }

  Future<void> disableBiometricAuth() async {
    await setBoolInLocalStorage('enableBiometricAuth', false);
    await removeValueInSecureStorage('username');
    await removeValueInSecureStorage('password');
  }

  Future<void> enableBiometricAuth(String username, String pwd) async {
    await setBoolInLocalStorage('enableBiometricAuth', true);
    await setValueInSecureStorage('username', username);
    await setValueInSecureStorage('password', pwd);
  }

  Future<String?> getValueFromSecureStorage(String key) async {
    return await _secureStorageService.getString(key);
  }

  Future<void> setValueInSecureStorage(String key, String value) async {
    await _secureStorageService.setString(key, value);
  }

  Future<void> removeValueInSecureStorage(String key) async {
    await _secureStorageService.deleteString(key);
  }

  Future<String?> getStringFromLocalStorage(String key) async {
    return _localStorageService.getString(key);
  }

  Future<void> setStringInLocalStorage(String key, String value) async {
    await _localStorageService.setString(key, value);
  }

  Future<bool?> getBoolFromLocalStorage(String key) async {
    return await _localStorageService.getBool(key);
  }

  Future<bool> setBoolInLocalStorage(String key, bool value) async {
    return await _localStorageService.setBool(key, value) ?? false;
  }
}
