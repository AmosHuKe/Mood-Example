import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'theme_default.dart';

/// 主题
class AppThemeYellow implements AppMultipleTheme {
  /// 主颜色
  static const primaryColor = Color(0xFFD6A548);

  @override
  ThemeData lightTheme() => AppThemeDefault().lightTheme().copyWith(
        primaryColor: primaryColor,
      );

  @override
  ThemeData darkTheme() => AppThemeDefault().darkTheme().copyWith(
        primaryColor: primaryColor,
      );
}
