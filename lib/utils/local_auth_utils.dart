import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../l10n/gen/app_localizations.dart';

class LocalAuthUtils {
  final LocalAuthentication auth = LocalAuthentication();

  /// 设备是否支持生物特征识别
  Future<bool> localAuthSupported() async {
    final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  /// 获取支持的识别列表
  Future<List<BiometricType>> localAuthList() async => auth.getAvailableBiometrics();

  /// 是否支持生物识别
  Future<bool> canLocalAuthBiometrics() async {
    final availableBiometrics = await localAuthList();
    return availableBiometrics.isNotEmpty;
  }

  /// 生物特征识别认证
  Future<bool> localAuthBiometric(BuildContext context) async {
    final appL10n = AppL10n.of(context);
    final canAuthenticate = await localAuthSupported();
    final canAuthenticateBiometrics = await canLocalAuthBiometrics();
    if (!canAuthenticate) return false;
    if (canAuthenticateBiometrics) {
      try {
        final didAuthenticate = await auth.authenticate(
          localizedReason: appL10n.app_setting_security_localauth_localizedreason,
          options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: appL10n.app_setting_security_localauth_signIntitle,
              biometricHint: '',
              cancelButton: appL10n.app_setting_security_localauth_cancel,
            ),
            IOSAuthMessages(cancelButton: appL10n.app_setting_security_localauth_cancel),
          ],
        );
        return didAuthenticate;
      } on PlatformException catch (e) {
        print('LocalAuthUtils localAuthBiometric error: ${e.toString()}');
        if (e.code == 'LockedOut') {
          SmartDialog.showToast(appL10n.app_setting_security_localauth_error_1);
        }
        return false;
      }
    }
    return false;
  }

  /// 识别图标
  static IconData? localAuthIcon(List<BiometricType> localAuthList) {
    final authIcon = switch (localAuthList) {
      [BiometricType.weak, ...] => Remix.body_scan_line,
      [BiometricType.strong, ...] => Remix.body_scan_line,
      [BiometricType.iris, ...] => Remix.eye_line,
      [BiometricType.face, ...] => Remix.body_scan_line,
      [BiometricType.fingerprint, ...] => Remix.fingerprint_line,
      [] => null,
    };
    return authIcon;
  }

  /// 识别文字
  static String localAuthText(BuildContext context, List<BiometricType> localAuthList) {
    final appL10n = AppL10n.of(context);
    final authText = switch (localAuthList) {
      [BiometricType.weak, ...] => appL10n.app_setting_security_biometric_weak,
      [BiometricType.strong, ...] => appL10n.app_setting_security_biometric_weak,
      [BiometricType.iris, ...] => appL10n.app_setting_security_biometric_iris,
      [BiometricType.face, ...] => appL10n.app_setting_security_biometric_face,
      [BiometricType.fingerprint, ...] => appL10n.app_setting_security_biometric_fingerprint,
      [] => '',
    };
    return authText;
  }
}
