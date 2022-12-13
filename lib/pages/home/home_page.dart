import 'package:biometric_login_concept/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: Container(
            constraints: BoxConstraints(minHeight: size.height),
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.logOut(context),
                    child: const Text('Cerrar sesión'),
                  ),
                  if (controller.deviceAllowBiometricAuth)
                    ElevatedButton(
                      onPressed: controller.hasEnableBiometricAuth
                          ? controller.disableBiometricLogin
                          : controller.enableBiometricLogin,
                      child: Text(controller.hasEnableBiometricAuth
                          ? 'Deshabilitar inicio biométrico'
                          : 'Habilitar inicio biométrico'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
