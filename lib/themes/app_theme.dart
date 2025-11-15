import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/config/multiple_theme_mode.dart';
import '../shared/view_models/application_view_model.dart';

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

  late final applicationViewModel = context.read<ApplicationViewModel>();

  /// 主题模式
  late ThemeMode themeMode = applicationViewModel.themeMode;

  /// 多主题模式
  late MultipleThemeMode multipleThemeMode = applicationViewModel.multipleThemeMode;

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
  /// - [themeMode]: [ThemeMode.system.name]
  static ThemeMode themeModeFromString(String themeMode) => .values.firstWhere(
    (e) => e.name == themeMode,
    orElse: () => .system, // dart format
  );

  /// 是否深色模式
  bool get isDarkMode {
    Theme.of(context);
    return switch (themeMode) {
      .system => View.of(context).platformDispatcher.platformBrightness == .dark,
      .dark => true,
      _ => false,
    };
  }
}
