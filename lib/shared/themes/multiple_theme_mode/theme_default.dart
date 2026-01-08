import 'package:flutter/material.dart';
import '../app_theme.dart';

/// 默认主题
class AppThemeDefault implements AppMultipleTheme {
  /// 主颜色
  static const primaryColor = Color(0xFF3e4663);

  /// 次要颜色
  static const subColor = Color(0xFFAFB8BF);

  /// 背景色系列
  static const backgroundColor1 = Color(0xFFE8ECF0);
  static const backgroundColor2 = Color(0xFFFCFBFC);
  static const backgroundColor3 = Color(0xFFF3F2F3);

  /// 浅色主题
  @override
  ThemeData lightTheme() {
    return ThemeData(
      brightness: .light,
      // 字体
      fontFamily: null,
      // 文字
      textTheme: const .new(
        displayLarge: .new(color: Colors.black87),
        displayMedium: .new(color: Colors.black87),
        displaySmall: .new(color: Colors.black87),
        bodyLarge: .new(color: Colors.black87),
        bodyMedium: .new(color: Colors.black87),
        bodySmall: .new(color: Colors.black87),
      ),
      // 主颜色
      primaryColor: primaryColor,
      // scaffold背景颜色 // 0xFFF7F7F7 0xFFF9F9F9 0xFFF6F8FA 0xFFFCFBFC
      scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      // AppBar
      appBarTheme: AppBarTheme(
        systemOverlayStyle: .dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      floatingActionButtonTheme: const .new(
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
      // bottomNavigationBar
      bottomNavigationBarTheme: const .new(backgroundColor: Colors.white),
      // TabBar
      tabBarTheme: const .new(
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFFAFB8BF),
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
      ),
      // OutlinedButton
      outlinedButtonTheme: const .new(style: .new(side: WidgetStatePropertyAll(BorderSide.none))),
      // 水波纹
      splashFactory: NoSplash.splashFactory,
      // 点击时水波颜色
      splashColor: Colors.transparent,
      // 点击时背景高亮颜色
      highlightColor: Colors.transparent,
      // Card
      cardColor: Colors.white,
      // bottomSheet
      bottomSheetTheme: const .new(modalBackgroundColor: Color(0xFFF6F8FA)),
      // Radio
      radioTheme: const .new(
        fillColor: WidgetStatePropertyAll(Color(0xFF111315)),
        overlayColor: WidgetStatePropertyAll(Color(0xFF111315)),
      ),
    );
  }

  /// 深色主题
  @override
  ThemeData darkTheme() {
    return ThemeData(
      brightness: .dark,
      // 字体
      fontFamily: null,
      // 文字
      textTheme: const .new(
        displayLarge: .new(color: Color(0xFFEFEFEF)),
        displayMedium: .new(color: Color(0xFFEFEFEF)),
        displaySmall: .new(color: Color(0xFFEFEFEF)),
        bodyLarge: .new(color: Color(0xFFEFEFEF)),
        bodyMedium: .new(color: Color(0xFFEFEFEF)),
        bodySmall: .new(color: Color(0xFFEFEFEF)),
      ),
      // 主颜色
      primaryColor: primaryColor,
      // scaffold背景颜色
      scaffoldBackgroundColor: const Color(0xFF111315),
      // AppBar
      appBarTheme: AppBarTheme(
        systemOverlayStyle: .light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      floatingActionButtonTheme: const .new(
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
      ),
      // bottomNavigationBar
      bottomNavigationBarTheme: const .new(backgroundColor: Color(0xFF1A1D1F)),
      // TabBar
      tabBarTheme: const .new(
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xFF6F767E),
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
      ),
      // OutlinedButton
      outlinedButtonTheme: const .new(
        style: ButtonStyle(side: WidgetStatePropertyAll(BorderSide.none)),
      ),
      // 水波纹
      splashFactory: NoSplash.splashFactory,
      // 点击时水波颜色
      splashColor: Colors.transparent,
      // 点击时背景高亮颜色
      highlightColor: Colors.transparent,
      // Card
      cardColor: const Color(0xFF202427),
      // bottomSheet
      bottomSheetTheme: const .new(modalBackgroundColor: Color(0xFF111315)),
      // Radio
      radioTheme: const .new(
        fillColor: WidgetStatePropertyAll(Color(0xFFEFEFEF)),
        overlayColor: WidgetStatePropertyAll(Color(0xFFEFEFEF)),
      ),
    );
  }
}
