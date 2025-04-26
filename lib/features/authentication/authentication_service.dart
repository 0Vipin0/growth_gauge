import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> canAuthenticateWithBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('Biometric authentication error: $e');
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      debugPrint('Biometric authentication error: $e');
      return false;
    }
  }

  Future<void> savePin(String pin) async {
    await _storage.write(key: 'user_pin', value: pin);
  }

  Future<String?> getSavedPin() async {
    return await _storage.read(key: 'user_pin');
  }

  Future<bool> authenticateWithPin(String pin) async {
    final String? storedPin = await getSavedPin();
    return storedPin != null && pin == storedPin;
  }
}
