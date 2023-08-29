import 'package:flutter/material.dart';

import 'package:moodexample/themes/multiple_themes_mode/theme_default.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_green.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_orange.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_purple.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_red.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_cyan.dart';
import 'package:moodexample/themes/multiple_themes_mode/theme_yellow.dart';

enum AppMultipleThemesMode { light, dark }

/// 多主题
Map<String, Map<AppMultipleThemesMode, ThemeData>> appMultipleThemesMode = {
  'default': {
    AppMultipleThemesMode.light: AppThemeDefault.lightTheme,
    AppMultipleThemesMode.dark: AppThemeDefault.darkTheme,
  },
  'red': {
    AppMultipleThemesMode.light: AppThemeRed.lightTheme,
    AppMultipleThemesMode.dark: AppThemeRed.darkTheme,
  },
  'orange': {
    AppMultipleThemesMode.light: AppThemeOrange.lightTheme,
    AppMultipleThemesMode.dark: AppThemeOrange.darkTheme,
  },
  'yellow': {
    AppMultipleThemesMode.light: AppThemeYellow.lightTheme,
    AppMultipleThemesMode.dark: AppThemeYellow.darkTheme,
  },
  'green': {
    AppMultipleThemesMode.light: AppThemeGreen.lightTheme,
    AppMultipleThemesMode.dark: AppThemeGreen.darkTheme,
  },
  'cyan': {
    AppMultipleThemesMode.light: AppThemeCyan.lightTheme,
    AppMultipleThemesMode.dark: AppThemeCyan.darkTheme,
  },
  'purple': {
    AppMultipleThemesMode.light: AppThemePurple.lightTheme,
    AppMultipleThemesMode.dark: AppThemePurple.darkTheme,
  },
};
