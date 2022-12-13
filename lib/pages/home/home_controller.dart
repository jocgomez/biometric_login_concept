import 'package:biometric_login_concept/pages/login/login_page.dart';
import 'package:biometric_login_concept/services/biometric_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final BiometricServiceController _biometricServiceController =
      Get.find<BiometricServiceController>();
  bool deviceAllowBiometricAuth = false;
  bool hasEnableBiometricAuth = false;

  @override
  void onInit() async {
    deviceAllowBiometricAuth =
        await _biometricServiceController.isBiometricEnabled();

    hasEnableBiometricAuth =
        await _biometricServiceController.hasEnableBiometricAuth() ?? false;
    update();
    super.onInit();
  }

  void logOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  void enableBiometricLogin() async {
    final bool saved = await _biometricServiceController.setBoolInLocalStorage(
      'enableBiometricAuth',
      true,
    );

    if (saved) {
      _biometricServiceController.setValueInSecureStorage('username', 'admin');
      _biometricServiceController.setValueInSecureStorage('password', 'admin');

      hasEnableBiometricAuth = true;
      update();
    }
  }

  void disableBiometricLogin() async {
    final bool saved = await _biometricServiceController.setBoolInLocalStorage(
      'enableBiometricAuth',
      false,
    );

    if (saved) {
      _biometricServiceController.removeValueInSecureStorage('username');
      _biometricServiceController.removeValueInSecureStorage('password');

      hasEnableBiometricAuth = false;
      update();
    }
  }
}
