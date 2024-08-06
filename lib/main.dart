import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'common/notification.dart';

import 'application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 模拟器需要使用（防止异常）
  // SharedPreferences.setMockInitialValues({}); 该操作会清空所有SharedPreferences值

  runApp(const Application());

  /// 通知初始化
  NotificationController.initializeLocalNotifications();

  /// 强制竖屏
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
