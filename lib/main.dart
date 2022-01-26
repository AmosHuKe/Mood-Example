import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Application
import 'application.dart';

void main() async {
  // shared_preferences 模拟器需要使用（防止异常）
  // SharedPreferences.setMockInitialValues({}); 该操作会清空所有SharedPreferences值

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

              /// 国际化
              initializeDateFormatting()
                  .then((_) => runApp(const Application()));
            }
          }
        }
      else
        {
          // 如果size非0，则直接runApp

          /// 国际化
          initializeDateFormatting().then((_) => runApp(const Application()))
        }
    },
  );
}
