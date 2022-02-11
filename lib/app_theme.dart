import 'dart:ui';
import 'package:flutter/material.dart';

///
import 'package:provider/provider.dart';

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

/// 主题
class AppTheme {
  // 设备参考大小
  static const double wdp = 360.0;
  static const double hdp = 690.0;
  // fromRGBO(46, 69, 177, 1) fromRGBO(84, 70, 183, 1)
  // 主颜色
  static const primaryColor =
      Color(0xFF3e4663); // #4d5fb4 #2C3751 #3e4663 #F7C95E

  // 次要颜色
  static const subColor = Color(0xFFAFB8BF);
  // 背景色系列
  static const backgroundColor1 = Color(0xFFE8ECF0);
  static const backgroundColor2 = Color(0xFFFCFBFC);
  static const backgroundColor3 = Color(0xFFF3F2F3);

  /// 浅色主题
  static final lightTheme = ThemeData(
    // 字体
    fontFamily: null,
    // 文字
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black87),
      bodyText1: TextStyle(color: Colors.black87),
    ),
    // 主颜色
    primaryColor: primaryColor,
    // scaffold背景颜色
    scaffoldBackgroundColor:
        const Color(0xFFF6F8FA), // 0xFFF7F7F7 0xFFF9F9F9 0xFFF6F8FA 0xFFFCFBFC
    // bottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    // TabBar
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Color(0xFFAFB8BF),
    ),
    // 回弹波浪颜色
    primarySwatch: const MaterialColor(
      0xFF545454,
      {
        50: Color(0xFF545454),
        100: Color(0xFF545454),
        200: Color(0xFF545454),
        300: Color(0xFF545454),
        400: Color(0xFF545454),
        500: Color(0xFF545454),
        600: Color(0xFF545454),
        700: Color(0xFF545454),
        800: Color(0xFF545454),
        900: Color(0xFF545454),
      },
    ),
    // 点击时水波颜色
    splashColor: Colors.transparent,
    // 点击时背景高亮颜色
    highlightColor: Colors.transparent,
    // Card
    cardColor: Colors.white,
    // bottomSheet
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF6F8FA)),
    // Radio
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xFF111315)),
      overlayColor: MaterialStateProperty.all(const Color(0xFF111315)),
    ),
  );

  /// 深色主题
  static final darkTheme = ThemeData(
    // 字体
    fontFamily: null,
    // 文字
    textTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFFEFEFEF)),
      bodyText1: TextStyle(color: Color(0xFFEFEFEF)),
    ),
    // 主颜色
    primaryColor: primaryColor,
    // scaffold背景颜色
    scaffoldBackgroundColor: const Color(0xFF111315),
    // bottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1A1D1F),
    ),
    // TabBar
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(color: Colors.white),
      unselectedLabelColor: Color(0xFF6F767E),
    ),
    // 回弹波浪颜色
    primarySwatch: const MaterialColor(
      0xFF545454,
      {
        50: Color(0xFF545454),
        100: Color(0xFF545454),
        200: Color(0xFF545454),
        300: Color(0xFF545454),
        400: Color(0xFF545454),
        500: Color(0xFF545454),
        600: Color(0xFF545454),
        700: Color(0xFF545454),
        800: Color(0xFF545454),
        900: Color(0xFF545454),
      },
    ),
    // 点击时水波颜色
    splashColor: Colors.transparent,
    // 点击时背景高亮颜色
    highlightColor: Colors.transparent,
    // Card
    cardColor: const Color(0xFF202427),
    // bottomSheet
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF111315)),
    // Radio
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xFFEFEFEF)),
      overlayColor: MaterialStateProperty.all(const Color(0xFFEFEFEF)),
    ),
  );
}
