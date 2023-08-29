import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:moodexample/generated/l10n.dart';

class LocalAuthUtils {
  final LocalAuthentication auth = LocalAuthentication();

  /// 设备是否支持生物特征识别
  Future<bool> localAuthSupported() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  /// 获取支持的识别列表
  Future<List<BiometricType>> localAuthList() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    return availableBiometrics;
  }

  /// 是否支持生物识别
  Future<bool> canLocalAuthBiometrics() async {
    final List<BiometricType> availableBiometrics = await localAuthList();
    if (availableBiometrics.contains(BiometricType.weak) ||
        availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.face)) {
      return true;
    } else {
      return false;
    }
  }

  /// 生物特征识别认证
  Future<bool> localAuthBiometric(BuildContext context) async {
    final s = S.of(context);
    final bool canAuthenticate = await localAuthSupported();
    final bool canAuthenticateBiometrics = await canLocalAuthBiometrics();
    if (!canAuthenticate) return false;
    if (canAuthenticateBiometrics) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: s.app_setting_security_localauth_localizedreason,
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: s.app_setting_security_localauth_signIntitle,
              biometricHint: '',
              cancelButton: s.app_setting_security_localauth_cancel,
            ),
            IOSAuthMessages(
              cancelButton: s.app_setting_security_localauth_cancel,
            ),
          ],
        );
        return didAuthenticate;
      } on PlatformException catch (e) {
        print(e.toString());
        if (e.code == 'LockedOut') {
          SmartDialog.showToast(s.app_setting_security_localauth_error_1);
        }
        return false;
      }
    }
    return false;
  }

  /// 识别图标
  IconData? localAuthIcon(List<BiometricType> localAuthList) {
    IconData? authIcon;
    if (localAuthList.contains(BiometricType.weak))
      authIcon = Remix.body_scan_line;
    if (localAuthList.contains(BiometricType.iris)) authIcon = Remix.eye_line;
    if (localAuthList.contains(BiometricType.face))
      authIcon = Remix.body_scan_line;
    if (localAuthList.contains(BiometricType.fingerprint))
      authIcon = Remix.fingerprint_line;
    return authIcon;
  }

  /// 识别文字
  String localAuthText(
    BuildContext context,
    List<BiometricType> localAuthList,
  ) {
    String authText = '';
    if (localAuthList.contains(BiometricType.weak))
      authText = S.of(context).app_setting_security_biometric_weak;
    if (localAuthList.contains(BiometricType.iris))
      authText = S.of(context).app_setting_security_biometric_iris;
    if (localAuthList.contains(BiometricType.face))
      authText = S.of(context).app_setting_security_biometric_face;
    if (localAuthList.contains(BiometricType.fingerprint))
      authText = S.of(context).app_setting_security_biometric_fingerprint;
    return authText;
  }
}
