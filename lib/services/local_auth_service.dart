import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> supportBiometric() async {
    return await auth.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await auth.getAvailableBiometrics();
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
  }

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason:
            'Vuelvelo a intentar o usa tus credenciales para iniciar sesión',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }
}
