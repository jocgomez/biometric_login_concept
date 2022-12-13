import 'package:biometric_login_concept/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Container(
            constraints: BoxConstraints(minHeight: size.height),
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.usernameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: controller.passwordCtrl,
                    obscureText: controller.hidePwd,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        onPressed: controller.handleHidePwd,
                        icon: Icon(
                          controller.hidePwd
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () => controller.logIn(context),
                    child: const Text('Iniciar sesión'),
                  ),
                  const SizedBox(height: 30),
                  if (controller.hasEnableBiometricAuth)
                    ElevatedButton(
                      onPressed: () => controller.logInWithBiometric(),
                      child: const Text('Inicio biométrico'),
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
