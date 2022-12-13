import 'package:biometric_login_concept/pages/login/login_page.dart';
import 'package:biometric_login_concept/services/biometric_service_controller.dart';
import 'package:biometric_login_concept/services/local_auth_service.dart';
import 'package:biometric_login_concept/services/local_storage_service.dart';
import 'package:biometric_login_concept/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());

  Get.lazyPut(() => LocalAuthService());
  Get.lazyPut(() => SecureStorageService());
  Get.lazyPut(() => LocalStorageService());
  Get.put(BiometricServiceController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
