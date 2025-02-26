import 'package:shared_preferences/shared_preferences.dart';

abstract final class SharedPreferencesKey {
  /*** App 相关 ***/

  /// 打开 App 次数
  static const openAPPCount = 'openAPPCount';

  /// 主题外观模式
  static const appThemeMode = 'appThemeMode';

  /// 多主题模式
  static const appMultipleThemeMode = 'appMultipleThemeMode';

  /// App 语言环境
  static const appLocale = 'appLocale';

  /// App 语言环境是否跟随系统
  static const appIsLocaleSystem = 'appIsLocaleSystem';

  /// 安全-密码
  static const appKeyPassword = 'appKeyPassword';

  /// 安全-是否开启生物特征识别
  static const appKeyBiometric = 'appKeyBiometric';

  /*** 心情类别相关 ***/

  /// 是否填充完成【心情类别】表默认值
  static const initMoodCategoryDefaultType = 'initMoodCategoryDefaultType';
}

/// shared_preferences
class SharedPreferencesDB {
  SharedPreferencesDB._();
  static final SharedPreferencesDB instance = SharedPreferencesDB._();
  SharedPreferencesAsync? _instance;
  SharedPreferencesAsync get sps => _instance ??= SharedPreferencesAsync();
}
