import '../../themes/app_theme.dart';
import '../../themes/multiple_theme_mode/theme_default.dart';
import '../../themes/multiple_theme_mode/theme_green.dart';
import '../../themes/multiple_theme_mode/theme_orange.dart';
import '../../themes/multiple_theme_mode/theme_purple.dart';
import '../../themes/multiple_theme_mode/theme_red.dart';
import '../../themes/multiple_theme_mode/theme_cyan.dart';
import '../../themes/multiple_theme_mode/theme_yellow.dart';

/// 多主题
enum MultipleThemeMode {
  kDefault,
  red,
  orange,
  yellow,
  green,
  cyan,
  purple;

  static MultipleThemeMode fromString(String appMultipleThemeMode) =>
      values.firstWhere((e) => e.name == appMultipleThemeMode, orElse: () => kDefault);
}

extension MultipleThemeModeExtension on MultipleThemeMode {
  AppMultipleTheme get data {
    return switch (this) {
      MultipleThemeMode.kDefault => AppThemeDefault(),
      MultipleThemeMode.red => AppThemeRed(),
      MultipleThemeMode.orange => AppThemeOrange(),
      MultipleThemeMode.yellow => AppThemeYellow(),
      MultipleThemeMode.green => AppThemeGreen(),
      MultipleThemeMode.cyan => AppThemeCyan(),
      MultipleThemeMode.purple => AppThemePurple(),
    };
  }
}
