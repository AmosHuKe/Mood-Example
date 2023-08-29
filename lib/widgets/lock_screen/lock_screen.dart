import 'package:flutter/material.dart';

import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'package:moodexample/common/local_auth_utils.dart';
import 'package:moodexample/generated/l10n.dart';

import 'package:moodexample/providers/application/application_provider.dart';
import 'package:remixicon/remixicon.dart';

/// 锁屏
Future<void> lockScreen(BuildContext context) async {
  final s = S.of(context);
  final ApplicationProvider applicationProvider =
      context.read<ApplicationProvider>();
  applicationProvider.loadKeyPassword();
  applicationProvider.loadKeyBiometric();

  final String password = applicationProvider.keyPassword;
  final localAuthUtils = await LocalAuthUtils();

  /// 支持生物特征识别处理
  Widget? customizedButtonChild;
  final bool canAppKeyBiometric = applicationProvider.keyBiometric;
  final bool canLocalAuthBiometrics =
      await localAuthUtils.canLocalAuthBiometrics();
  if (canAppKeyBiometric && canLocalAuthBiometrics) {
    final localAuthList = await localAuthUtils.localAuthList();
    customizedButtonChild = Icon(
      await localAuthUtils.localAuthIcon(localAuthList),
      size: 28.sp,
      semanticLabel: s.app_setting_security_biometric_weak,
    );
  }

  if (password != '' && !applicationProvider.keyPasswordScreenOpen) {
    if (context.mounted) {
      screenLock(
        context: context,
        correctString: password,
        title: Text(s.app_setting_security_lock_screen_title),
        canCancel: false,
        deleteButton: const Icon(
          Remix.delete_back_2_fill,
          semanticLabel: '删除',
        ),
        customizedButtonChild: customizedButtonChild,
        customizedButtonTap: () async {
          final bool localAuthBiometric =
              await localAuthUtils.localAuthBiometric(context);
          if (localAuthBiometric) {
            applicationProvider.keyPasswordScreenOpen = false;
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        onOpened: () async {
          applicationProvider.keyPasswordScreenOpen = true;
          if (canAppKeyBiometric) {
            final bool localAuthBiometric =
                await localAuthUtils.localAuthBiometric(context);
            if (localAuthBiometric) {
              applicationProvider.keyPasswordScreenOpen = false;
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          }
        },
        onUnlocked: () {
          applicationProvider.keyPasswordScreenOpen = false;
          Navigator.pop(context);
        },
      );
    }
  }
}

/// 锁屏创建
///
/// [onConfirmed] 密码确认后的操作
Future<void> createlockScreen(
  BuildContext context,
  Function(String password) onConfirmed,
) async {
  final controller = InputController();
  screenLockCreate(
    context: context,
    inputController: controller,
    title: Text(S.of(context).app_setting_security_lock_title_1),
    confirmTitle: Text(S.of(context).app_setting_security_lock_title_2),
    onConfirmed: (password) {
      onConfirmed(password);
      Navigator.of(context).pop();
    },
    cancelButton: Text(S.of(context).app_setting_security_lock_cancel),
    deleteButton: const Icon(
      Remix.delete_back_2_fill,
      semanticLabel: '删除',
    ),
    footer: TextButton(
      onPressed: () {
        // 重新输入
        controller.unsetConfirmed();
      },
      child: Text(S.of(context).app_setting_security_lock_resetinput),
    ),
    onError: (value) {
      SmartDialog.showToast(S.of(context).app_setting_security_lock_error_1);
    },
  );
}
