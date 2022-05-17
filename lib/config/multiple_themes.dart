import 'package:flutter/material.dart';

///
import 'package:moodexample/theme/multiple_themes_mode/theme_default.dart';
import 'package:moodexample/theme/multiple_themes_mode/theme_teal.dart';

/// 多主题
Map<String, Map<String, ThemeData>> appMultipleThemesMode = {
  "default": {
    "light": AppThemeDefault.lightTheme,
    "dark": AppThemeDefault.darkTheme,
  },
  "teal": {
    "light": AppThemeTeal.lightTheme,
    "dark": AppThemeTeal.darkTheme,
  }
};
