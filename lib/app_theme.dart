import 'package:flutter/material.dart';

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
    // 主颜色
    primaryColor: primaryColor,
    // scaffold背景颜色
    scaffoldBackgroundColor:
        const Color(0xFFF6F8FA), // 0xFFF7F7F7 0xFFF9F9F9 0xFFF6F8FA 0xFFFCFBFC

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
  );

  /// 深色主题
  static final darkTheme = ThemeData(
    // 字体
    fontFamily: null,
    // 主颜色
    primaryColor: primaryColor,
    // scaffold背景颜色
    scaffoldBackgroundColor: const Color(0xFFF6F8FA),

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
  );
}
