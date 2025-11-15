import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../utils/local_auth_utils.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../shared/view_models/security_key_view_model.dart';

/// 锁屏界面弹出
///
/// - [keyPassword] 安全密码
/// - [keyBiometric] 是否开启安全生物特征识别
Future<void> lockScreen(
  BuildContext context, {
  required String keyPassword,
  required bool keyBiometric,
}) async {
  final theme = Theme.of(context);
  final appL10n = AppL10n.of(context);
  final localAuthUtils = await LocalAuthUtils();
  final securityKeyViewModel = context.read<SecurityKeyViewModel>();

  /// 支持生物特征识别处理
  Widget? customizedButtonChild;
  final canLocalAuthBiometrics = await localAuthUtils.canLocalAuthBiometrics();
  if (keyBiometric && canLocalAuthBiometrics) {
    final localAuthList = await localAuthUtils.localAuthList();
    customizedButtonChild = Icon(
      await LocalAuthUtils.localAuthIcon(localAuthList),
      size: 28,
      semanticLabel: appL10n.app_setting_security_biometric_weak,
      color: theme.textTheme.bodyMedium?.color,
    );
  }

  if (keyPassword != '') {
    if (context.mounted) {
      screenLock(
        context: context,
        correctString: keyPassword,
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
            securityKeyViewModel.keyPasswordScreenOpen = false;
            if (context.mounted) {
              context.pop();
            }
          }
        },
        onOpened: () async {
          securityKeyViewModel.keyPasswordScreenOpen = true;
          if (keyBiometric) {
            final localAuthBiometric = await localAuthUtils.localAuthBiometric(context);
            if (localAuthBiometric) {
              securityKeyViewModel.keyPasswordScreenOpen = false;
              if (context.mounted) {
                context.pop();
              }
            }
          }
        },
        onUnlocked: () {
          securityKeyViewModel.keyPasswordScreenOpen = false;
          context.pop();
        },
      );
    }
  }
}

/// 锁屏创建
///
/// - [onConfirmed] 密码确认后的操作
Future<void> createLockScreen(
  BuildContext context,
  void Function(String password) onConfirmed,
) async {
  final theme = Theme.of(context);
  final appL10n = AppL10n.of(context);
  final inputController = InputController();
  screenLockCreate(
    context: context,
    inputController: inputController,
    title: Text(appL10n.app_setting_security_lock_title_1),
    confirmTitle: Text(appL10n.app_setting_security_lock_title_2),
    onConfirmed: (password) {
      onConfirmed(password);
      context.pop();
    },
    cancelButton: Text(
      appL10n.app_setting_security_lock_cancel,
      style: .new(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
    ),
    deleteButton: Icon(
      Remix.delete_back_2_fill,
      semanticLabel: '删除',
      color: theme.textTheme.bodyMedium?.color,
    ),
    footer: TextButton(
      onPressed: () {
        // 重新输入
        inputController.unsetConfirmed();
      },
      child: Text(
        appL10n.app_setting_security_lock_resetinput,
        style: .new(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
      ),
    ),
    onError: (value) {
      SmartDialog.showToast(appL10n.app_setting_security_lock_error_1);
    },
  );
}
