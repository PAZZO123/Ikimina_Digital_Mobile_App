import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class BiometricService {
  static final _auth = LocalAuthentication();

  /// Check if device supports biometrics
  static Future<bool> isAvailable() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck && isSupported;
    } on PlatformException {
      return false;
    }
  }

  /// Get available biometric types
  static Future<List<BiometricType>> getAvailableTypes() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  /// Authenticate with biometrics
  static Future<bool> authenticate({
    String reason = 'Authenticate to access Ikimina Digital',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN fallback
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      // Handle specific errors
      if (e.code == 'NotAvailable' || e.code == 'NotEnrolled') {
        return false;
      }
      return false;
    }
  }

  /// Check if user has enabled biometric login in preferences
  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefBiometric) ?? false;
  }

  /// Enable or disable biometric login
  static Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefBiometric, enabled);
  }

  /// Convenience: check if biometric login should be offered at login screen
  static Future<bool> shouldOfferBiometric() async {
    final available = await isAvailable();
    final enabled = await isBiometricEnabled();
    return available && enabled;
  }
}
