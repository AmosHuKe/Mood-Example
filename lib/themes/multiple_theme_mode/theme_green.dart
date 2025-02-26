import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'theme_default.dart';

/// 主题
class AppThemeGreen implements AppMultipleTheme {
  /// 主颜色
  static const primaryColor = Color(0xFF6C7A6B);

  @override
  ThemeData lightTheme() => AppThemeDefault().lightTheme().copyWith(primaryColor: primaryColor);

  @override
  ThemeData darkTheme() => AppThemeDefault().darkTheme().copyWith(primaryColor: primaryColor);
}
