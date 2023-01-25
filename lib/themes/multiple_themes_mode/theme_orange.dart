import 'package:flutter/material.dart';

/// 主题
class AppThemeOrange {
  /// 主颜色
  static const primaryColor = Color(0xFFA77E86);

  /// 浅色主题
  static final lightTheme = ThemeData(
    // 字体
    fontFamily: null,
    // 文字
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black87),
      displayMedium: TextStyle(color: Colors.black87),
      displaySmall: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
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
      displayLarge: TextStyle(color: Color(0xFFEFEFEF)),
      displayMedium: TextStyle(color: Color(0xFFEFEFEF)),
      displaySmall: TextStyle(color: Color(0xFFEFEFEF)),
      bodyLarge: TextStyle(color: Color(0xFFEFEFEF)),
      bodyMedium: TextStyle(color: Color(0xFFEFEFEF)),
      bodySmall: TextStyle(color: Color(0xFFEFEFEF)),
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
      labelColor: Colors.white,
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
