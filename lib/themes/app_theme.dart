import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../config/multiple_theme_mode.dart';

import '../../providers/application/application_provider.dart';

/// 多主题
abstract class AppMultipleTheme {
  /// 亮色
  ThemeData lightTheme();

  /// 深色
  ThemeData darkTheme();
}

/// 主题基础
class AppTheme implements AppMultipleTheme {
  AppTheme(this.context);

  final BuildContext context;

  /// 主题模式
  late ThemeMode themeMode = context.read<ApplicationProvider>().themeMode;

  /// 多主题
  late MultipleThemeMode multipleThemeMode = context.read<ApplicationProvider>().multipleThemeMode;

  /// Static 次要颜色
  static const staticSubColor = Color(0xFFAFB8BF);

  /// Static 背景色系列
  static const staticBackgroundColor1 = Color(0xFFE8ECF0);
  static const staticBackgroundColor2 = Color(0xFFFCFBFC);
  static const staticBackgroundColor3 = Color(0xFFF3F2F3);

  @override
  ThemeData lightTheme() => multipleThemeMode.data.lightTheme();

  @override
  ThemeData darkTheme() => multipleThemeMode.data.darkTheme();

  /// 主题模式 FromString
  ///
  /// [themeMode] : [ThemeMode.system.name]
  static ThemeMode themeModeFromString(String themeMode) => ThemeMode.values.firstWhere(
        (e) => e.name == themeMode,
        orElse: () => ThemeMode.system,
      );

  /// 是否深色模式
  bool get isDarkMode {
    Theme.of(context);
    return switch (themeMode) {
      ThemeMode.system => View.of(context).platformDispatcher.platformBrightness == Brightness.dark,
      ThemeMode.dark => true,
      _ => false,
    };
  }
}
