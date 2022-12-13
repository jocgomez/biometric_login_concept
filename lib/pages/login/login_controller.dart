import 'package:biometric_login_concept/pages/home/home_page.dart';
import 'package:biometric_login_concept/services/biometric_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final BiometricServiceController _biometricServiceController =
      Get.find<BiometricServiceController>();

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool hidePwd = true;
  bool hasEnableBiometricAuth = false;

  @override
  void onReady() {
    _checkEnableBiometric();
    super.onReady();
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();

    super.onClose();
  }

  void _checkEnableBiometric() async {
    hasEnableBiometricAuth =
        await _biometricServiceController.hasEnableBiometricAuth() ?? false;
    update();
  }

  void handleHidePwd() {
    hidePwd = !hidePwd;
    update();
  }

  void logIn(BuildContext context) {
    /// Simula el servicio login
    if (usernameCtrl.text == 'admin' && passwordCtrl.text == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Homepage(),
        ),
      );
    }
  }

  void logInWithBiometric() async {
    if (await _biometricServiceController.isBiometricEnabled()) {
      if (await _biometricServiceController.biometricAuthenticate()) {
        final String username = await _biometricServiceController
                .getValueFromSecureStorage('username') ??
            '';
        final String password = await _biometricServiceController
                .getValueFromSecureStorage('password') ??
            '';

        if (username.isNotEmpty && password.isNotEmpty) {
          usernameCtrl.text = username;
          passwordCtrl.text = password;

          logIn(Get.context!);
        }
      } else {
        /// Navegar a la página de login
      }
    }
  }
}
