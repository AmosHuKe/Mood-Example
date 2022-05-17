import 'dart:ui';
import 'package:flutter/material.dart';

///
import 'package:provider/provider.dart';

///
import 'package:moodexample/config/multiple_themes.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 是否深色模式
bool isDarkMode(BuildContext context) {
  final ThemeMode _themeMode =
      Provider.of<ApplicationViewModel>(context, listen: false).themeMode;
  if (_themeMode == ThemeMode.system) {
    return window.platformBrightness == Brightness.dark;
  } else {
    return _themeMode == ThemeMode.dark;
  }
}

/// 当前深色模式
///
/// system(默认)：跟随系统 light：普通 dark：深色
ThemeMode darkThemeMode(String mode) {
  ThemeMode themeMode = ThemeMode.system;
  switch (mode) {
    case "system":
      themeMode = ThemeMode.system;
      break;
    case "dark":
      themeMode = ThemeMode.dark;
      break;
    case "light":
      themeMode = ThemeMode.light;
      break;
    default:
      themeMode = ThemeMode.system;
      break;
  }
  return themeMode;
}

/// 主题基础
class AppTheme {
  late String multipleThemesMode = "default";
  AppTheme(this.multipleThemesMode);

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
  ThemeData? multipleThemesLightMode() {
    ThemeData? lightTheme = appMultipleThemesMode["default"]!["light"];
    if (appMultipleThemesMode[multipleThemesMode] != null) {
      lightTheme = appMultipleThemesMode[multipleThemesMode]!["light"];
    }
    return lightTheme;
  }

  /// 多主题 dark
  ThemeData? multipleThemesDarkMode() {
    ThemeData? darkTheme = appMultipleThemesMode["default"]!["dark"];
    if (appMultipleThemesMode[multipleThemesMode] != null) {
      darkTheme = appMultipleThemesMode[multipleThemesMode]!["dark"];
    }
    return darkTheme;
  }
}
