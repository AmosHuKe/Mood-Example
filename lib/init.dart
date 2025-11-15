import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'data/database/database.dart';
import 'shared/view_models/security_key_view_model.dart';
import 'shared/view_models/notification_view_model.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener appLifecycleListener;
  late final securityKeyViewModel = context.read<SecurityKeyViewModel>();
  late final notificationViewModel = context.read<NotificationViewModel>();

  @override
  void initState() {
    super.initState();

    /// App 生命周期
    appLifecycleListener = AppLifecycleListener(
      onResume: () => print('App Resume'),
      onInactive: () => print('App Inactive'),
      onHide: () => print('App Hide'),
      onShow: () => print('App Show'),
      onPause: () {
        print('App Pause');
        securityKeyViewModel.loadlockScreen(context);
      },
      onRestart: () => print('App Restart'),
      onDetach: () => print('App Detach'),
    );

    init();
  }

  @override
  void dispose() {
    appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case .android:
        // 沉浸模式（全屏模式）
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      case _:
    }

    return widget.child;
  }

  void init() {
    /// 初始化数据库
    DB.instance.database;

    /// 锁屏
    securityKeyViewModel.loadlockScreen(context);

    /// 通知
    notificationViewModel.allowedNotification(context);
    notificationViewModel.sendTest(context);
  }
}
