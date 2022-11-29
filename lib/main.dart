import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moodexample/common/notification.dart';

/// Application
import 'application.dart';

void main() async {
  // shared_preferences 模拟器需要使用（防止异常）
  // SharedPreferences.setMockInitialValues({}); 该操作会清空所有SharedPreferences值
  await ScreenUtil.ensureScreenSize();

  /// 通知初始化
  await NotificationController.initializeLocalNotifications();

  /// 强制竖屏
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then(
    (_) => {
      // 解决开屏白屏问题
      // 如果size是0，则设置回调，在回调中runApp
      if (window.physicalSize.isEmpty)
        {
          window.onMetricsChanged = () {
            // 在回调中，size仍然有可能是0
            if (!window.physicalSize.isEmpty) {
              window.onMetricsChanged = null;
              runApp(const Application());
            }
          }
        }
      else
        {
          // 如果size非0，则直接runApp
          runApp(const Application())
        }
    },
  );
}
