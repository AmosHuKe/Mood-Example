import 'package:flutter/material.dart';

import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:moodexample/common/local_auth_utils.dart';
import 'package:moodexample/db/preferences_db.dart';

import 'package:moodexample/view_models/application/application_view_model.dart';

/// 锁屏
Future<void> lockScreen(BuildContext context) async {
  ApplicationViewModel applicationViewModel =
      Provider.of<ApplicationViewModel>(context, listen: false);
  String password =
      await PreferencesDB().getAppKeyPassword(applicationViewModel);

  /// 支持生物特征识别处理
  Widget? customizedButtonChild;
  bool canAppKeyBiometric =
      await PreferencesDB().getAppKeyBiometric(applicationViewModel);
  bool canLocalAuthBiometrics = await LocalAuthUtils().canLocalAuthBiometrics();
  if (canAppKeyBiometric && canLocalAuthBiometrics) {
    customizedButtonChild = Icon(
      await LocalAuthUtils().localAuthIcon(),
      size: 28.sp,
    );
  }
  if (password != "" && !applicationViewModel.keyPasswordScreenOpen) {
    return screenLock(
      context: context,
      correctString: password,
      title: const Text("输入密码解锁"),
      canCancel: false,
      customizedButtonChild: customizedButtonChild,
      cancelButton: const Text("关闭"),
      customizedButtonTap: () async {
        await LocalAuthUtils().localAuthBiometric()
            ? Navigator.pop(context)
            : null;
      },
      onOpened: () async {
        applicationViewModel.setKeyPasswordScreenOpen(true);
        if (canAppKeyBiometric) {
          if (await LocalAuthUtils().localAuthBiometric()) {
            applicationViewModel.setKeyPasswordScreenOpen(false);
            Navigator.pop(context);
          }
        }
      },
      onUnlocked: () {
        applicationViewModel.setKeyPasswordScreenOpen(false);
        Navigator.pop(context);
      },
    );
  }
}

/// 锁屏创建
///
/// Function(String password) onConfirmed 密码确认后的操作
Future<void> createlockScreen(
    BuildContext context, Function(String password) onConfirmed) async {
  final controller = InputController();
  screenLockCreate(
    context: context,
    inputController: controller,
    title: const Text("设置密码"),
    confirmTitle: const Text("再次输入确认密码"),
    onConfirmed: (password) {
      onConfirmed(password);
      Navigator.of(context).pop();
    },
    cancelButton: const Text("关闭"),
    footer: TextButton(
      onPressed: () {
        // 重新输入
        controller.unsetConfirmed();
      },
      child: const Text("重新输入"),
    ),
    onError: (value) {
      Fluttertoast.showToast(
        msg: "密码不一致",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 12.sp,
      );
    },
  );
}
