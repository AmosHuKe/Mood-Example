import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:moodexample/config/multiple_themes.dart';

import 'package:moodexample/providers/application/application_provider.dart';

/// 是否深色模式
bool isDarkMode(BuildContext context) {
  Theme.of(context);
  final ThemeMode themeMode = context.read<ApplicationProvider>().themeMode;
  if (themeMode == ThemeMode.system) {
    return View.of(context).platformDispatcher.platformBrightness ==
        Brightness.dark;
  } else {
    return themeMode == ThemeMode.dark;
  }
}

/// 当前深色模式
///
/// [mode] system(默认)：跟随系统 light：普通 dark：深色
ThemeMode darkThemeMode(String mode) => switch (mode) {
      'system' => ThemeMode.system,
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };

/// 当前多主题
String getMultipleThemesMode(BuildContext context) {
  final String multipleThemesMode =
      context.read<ApplicationProvider>().multipleThemesMode;
  return multipleThemesMode;
}

/// 多主题
abstract class AppMultipleTheme {
  /// 亮色
  ThemeData lightTheme();

  /// 深色
  ThemeData darkTheme();
}

/// 主题基础
class AppTheme {
  AppTheme(this.multipleThemesMode);

  String multipleThemesMode = 'default';

  /// 设备参考大小
  static const double wdp = 360.0;
  static const double hdp = 690.0;

  /// 次要颜色
  static const subColor = Color(0xFFAFB8BF);

  /// 背景色系列
  static const backgroundColor1 = Color(0xFFE8ECF0);
  static const backgroundColor2 = Color(0xFFFCFBFC);
  static const backgroundColor3 = Color(0xFFF3F2F3);

  /// 多主题 light
  ThemeData multipleThemesLightMode() {
    return appMultipleThemesMode[multipleThemesMode] != null
        ? appMultipleThemesMode[multipleThemesMode]!.lightTheme()
        : appMultipleThemesMode['default']!.lightTheme();
  }

  /// 多主题 dark
  ThemeData multipleThemesDarkMode() {
    return appMultipleThemesMode[multipleThemesMode] != null
        ? appMultipleThemesMode[multipleThemesMode]!.darkTheme()
        : appMultipleThemesMode['default']!.darkTheme();
  }
}
