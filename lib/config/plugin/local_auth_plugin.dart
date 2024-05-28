import 'package:local_auth/error_codes.dart' as auth_error;

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {
  static final auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autenicate para usar la app.',
        options: const AuthenticationOptions(
            biometricOnly: false // En false permite usar el PIN
            ),
      );

      return (didAuthenticate, didAuthenticate ? 'Autenicado' : 'No autenticado');
    } on PlatformException catch (e) {
      print(e);
      if (e.code == auth_error.notEnrolled) {
        return (false, 'No hay biometricos enrollados.');
      }
      if (e.code == auth_error.lockedOut) {
        return (false, 'Muchos intentos fallidos.');
      }
      if (e.code == auth_error.notAvailable) {
        return (false, 'No hay biometricos disponibles.');
      }
      if (e.code == auth_error.passcodeNotSet) {
        return (false, 'No hay un PIN configurado.');
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, 'Se require desbloquear el telefono.');
      }
      return (false, e.toString());
    }
  }
}
