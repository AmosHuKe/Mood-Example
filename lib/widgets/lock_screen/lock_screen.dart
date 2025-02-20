import 'package:flutter/material.dart';

import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/common/local_auth_utils.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';

import 'package:moodexample/providers/application/application_provider.dart';

/// 锁屏
Future<void> lockScreen(BuildContext context) async {
  final theme = Theme.of(context);
  final appL10n = AppL10n.of(context);
  final applicationProvider = context.read<ApplicationProvider>();
  applicationProvider.loadKeyPassword();
  applicationProvider.loadKeyBiometric();

  final password = applicationProvider.keyPassword;
  final localAuthUtils = await LocalAuthUtils();

  /// 支持生物特征识别处理
  Widget? customizedButtonChild;
  final canAppKeyBiometric = applicationProvider.keyBiometric;
  final canLocalAuthBiometrics = await localAuthUtils.canLocalAuthBiometrics();
  if (canAppKeyBiometric && canLocalAuthBiometrics) {
    final localAuthList = await localAuthUtils.localAuthList();
    customizedButtonChild = Icon(
      await LocalAuthUtils.localAuthIcon(localAuthList),
      size: 28,
      semanticLabel: appL10n.app_setting_security_biometric_weak,
      color: theme.textTheme.bodyMedium?.color,
    );
  }

  if (password != '' && !applicationProvider.keyPasswordScreenOpen) {
    if (context.mounted) {
      screenLock(
        context: context,
        correctString: password,
        title: Text(appL10n.app_setting_security_lock_screen_title),
        canCancel: false,
        deleteButton: Icon(
          Remix.delete_back_2_fill,
          semanticLabel: '删除',
          color: theme.textTheme.bodyMedium?.color,
        ),
        customizedButtonChild: customizedButtonChild,
        customizedButtonTap: () async {
          final localAuthBiometric = await localAuthUtils.localAuthBiometric(context);
          if (localAuthBiometric) {
            applicationProvider.keyPasswordScreenOpen = false;
            if (context.mounted) {
              context.pop();
            }
          }
        },
        onOpened: () async {
          applicationProvider.keyPasswordScreenOpen = true;
          if (canAppKeyBiometric) {
            final localAuthBiometric = await localAuthUtils.localAuthBiometric(context);
            if (localAuthBiometric) {
              applicationProvider.keyPasswordScreenOpen = false;
              if (context.mounted) {
                context.pop();
              }
            }
          }
        },
        onUnlocked: () {
          applicationProvider.keyPasswordScreenOpen = false;
          context.pop();
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
  void Function(String password) onConfirmed,
) async {
  final theme = Theme.of(context);
  final appL10n = AppL10n.of(context);
  final controller = InputController();
  screenLockCreate(
    context: context,
    inputController: controller,
    title: Text(appL10n.app_setting_security_lock_title_1),
    confirmTitle: Text(appL10n.app_setting_security_lock_title_2),
    onConfirmed: (password) {
      onConfirmed(password);
      context.pop();
    },
    cancelButton: Text(
      appL10n.app_setting_security_lock_cancel,
      style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
    ),
    deleteButton: Icon(
      Remix.delete_back_2_fill,
      semanticLabel: '删除',
      color: theme.textTheme.bodyMedium?.color,
    ),
    footer: TextButton(
      onPressed: () {
        // 重新输入
        controller.unsetConfirmed();
      },
      child: Text(
        appL10n.app_setting_security_lock_resetinput,
        style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
      ),
    ),
    onError: (value) {
      SmartDialog.showToast(appL10n.app_setting_security_lock_error_1);
    },
  );
}
