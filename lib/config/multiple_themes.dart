import '../themes/app_theme.dart';

import '../themes/multiple_themes_mode/theme_default.dart';
import '../themes/multiple_themes_mode/theme_green.dart';
import '../themes/multiple_themes_mode/theme_orange.dart';
import '../themes/multiple_themes_mode/theme_purple.dart';
import '../themes/multiple_themes_mode/theme_red.dart';
import '../themes/multiple_themes_mode/theme_cyan.dart';
import '../themes/multiple_themes_mode/theme_yellow.dart';

/// 多主题
Map<String, AppMultipleTheme> appMultipleThemesMode = {
  'default': AppThemeDefault(),
  'red': AppThemeRed(),
  'orange': AppThemeOrange(),
  'yellow': AppThemeYellow(),
  'green': AppThemeGreen(),
  'cyan': AppThemeCyan(),
  'purple': AppThemePurple(),
};
