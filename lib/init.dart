import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'data/database/database.dart';
import 'shared/providers/notification_provider.dart';
import 'shared/providers/security_key_provider.dart';
import 'shared/utils/log_utils.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener appLifecycleListener;
  late final securityKeyProvider = context.read<SecurityKeyProvider>();
  late final notificationProvider = context.read<NotificationProvider>();

  @override
  void initState() {
    super.initState();

    /// App 生命周期
    appLifecycleListener = AppLifecycleListener(
      onResume: () => Log.instance.info('App Resume'),
      onInactive: () => Log.instance.info('App Inactive'),
      onHide: () => Log.instance.info('App Hide'),
      onShow: () => Log.instance.info('App Show'),
      onPause: () {
        Log.instance.info('App Pause');
        securityKeyProvider.loadlockScreen(context);
      },
      onRestart: () => Log.instance.info('App Restart'),
      onDetach: () => Log.instance.info('App Detach'),
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
    /// 初始化日志
    Log.instance.onRecord();

    /// 初始化数据库
    DB.instance.database;

    /// 锁屏
    securityKeyProvider.loadlockScreen(context);

    /// 通知
    notificationProvider.allowedNotification(context);
    notificationProvider.sendTest(context);
  }
}
