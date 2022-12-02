import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:remixicon/remixicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              biometricHint: "",
              cancelButton: s.app_setting_security_localauth_cancel,
            ),
            IOSAuthMessages(
              cancelButton: s.app_setting_security_localauth_cancel,
            ),
          ],
        );
        return didAuthenticate;
      } on PlatformException catch (e) {
        debugPrint(e.toString());
        if (e.code == "LockedOut") {
          Fluttertoast.showToast(
            msg: s.app_setting_security_localauth_error_1,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 12.sp,
          );
        }
        return false;
      }
    }
    return false;
  }

  /// 识别图标
  Future<IconData?> localAuthIcon() async {
    List<BiometricType> localAuthList = await LocalAuthUtils().localAuthList();
    IconData? authIcon;
    localAuthList.contains(BiometricType.weak)
        ? authIcon = Remix.body_scan_line
        : null;
    localAuthList.contains(BiometricType.iris)
        ? authIcon = Remix.eye_line
        : null;
    localAuthList.contains(BiometricType.face)
        ? authIcon = Remix.body_scan_line
        : null;
    localAuthList.contains(BiometricType.fingerprint)
        ? authIcon = Remix.fingerprint_line
        : null;
    return authIcon;
  }
}
