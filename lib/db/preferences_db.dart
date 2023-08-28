import 'package:flutter/material.dart';

///
import 'package:shared_preferences/shared_preferences.dart';

///
import 'package:moodexample/themes/app_theme.dart';

///
import 'package:moodexample/providers/application/application_provider.dart';

/// shared_preferences
class PreferencesDB {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  /*** APP相关 ***/

  /// 打开APP次数
  static const openAPPCount = 'openAPPCount';

  /// 主题外观模式
  ///
  /// system(默认)：跟随系统 light：普通 dark：深色
  static const appThemeDarkMode = 'appThemeDarkMode';

  /// 多主题模式
  ///
  /// default(默认)
  static const appMultipleThemesMode = 'appMultipleThemesMode';

  /// APP地区语言
  static const appLocale = 'appLocale';

  /// APP地区语言是否跟随系统
  static const appIsLocaleSystem = 'appIsLocaleSystem';

  /// 安全-密码
  static const appKeyPassword = 'appKeyPassword';

  /// 安全-生物特征识别是否开启
  static const appKeyBiometric = 'appKeyBiometric';

  /*** 数据库相关 ***/

  /// 是否填充完成【心情类别】表默认值
  static const initMoodCategoryDefaultType = 'initMoodCategoryDefaultType';

  /*** shared_preferences ***/

  /// 设置-是否填充完成【心情类别】表默认值
  Future setInitMoodCategoryDefaultType(bool value) async {
    final SharedPreferences prefs = await init();
    prefs.setBool(initMoodCategoryDefaultType, value);
  }

  /// 获取-是否填充完成【心情类别】表默认值
  Future<bool> getInitMoodCategoryDefaultType() async {
    final SharedPreferences prefs = await init();
    return prefs.getBool(initMoodCategoryDefaultType) ?? false;
  }

  /// 设置-主题外观模式
  ///
  /// [value] system(默认)：跟随系统 light：普通 dark：深色
  Future setAppThemeDarkMode(
    ApplicationProvider applicationProvider,
    String value,
  ) async {
    final SharedPreferences prefs = await init();
    prefs.setString(appThemeDarkMode, value);
    applicationProvider.themeMode = darkThemeMode(value);
  }

  /// 获取-主题外观模式
  Future<String> getAppThemeDarkMode(
    ApplicationProvider applicationProvider,
  ) async {
    final SharedPreferences prefs = await init();
    final String themeDarkMode = prefs.getString(appThemeDarkMode) ?? 'system';
    applicationProvider.themeMode = darkThemeMode(themeDarkMode);
    return themeDarkMode;
  }

  /// 设置-多主题模式
  Future setMultipleThemesMode(
    ApplicationProvider applicationProvider,
    String value,
  ) async {
    final SharedPreferences prefs = await init();
    prefs.setString(appMultipleThemesMode, value);
    applicationProvider.multipleThemesMode = value;
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode(
    ApplicationProvider applicationProvider,
  ) async {
    final SharedPreferences prefs = await init();
    final String multipleThemesMode =
        prefs.getString(appMultipleThemesMode) ?? 'default';
    applicationProvider.multipleThemesMode = multipleThemesMode;
    return multipleThemesMode;
  }

  /// 设置-APP地区语言
  Future setAppLocale(
    ApplicationProvider applicationProvider,
    String? locale,
  ) async {
    final SharedPreferences prefs = await init();
    print(locale);
    await setAppIsLocaleSystem(applicationProvider, false);
    final appLocaleSystem = locale ?? 'zh';
    final appLocaleList = appLocaleSystem.split('_');
    prefs.setString(appLocale, appLocaleSystem);
    applicationProvider.locale = Locale(
      appLocaleList[0],
      appLocaleList.length > 1 ? appLocaleList[1] : '',
    );
  }

  /// 获取-APP地区语言
  Future<String> getAppLocale(ApplicationProvider applicationProvider) async {
    final SharedPreferences prefs = await init();
    final String getAppLocale = prefs.getString(appLocale) ?? 'zh';
    final appLocaleList = getAppLocale.split('_');
    applicationProvider.locale = Locale(
      appLocaleList[0],
      appLocaleList.length > 1 ? appLocaleList[1] : '',
    );
    return getAppLocale;
  }

  /// 设置-APP地区语言是否跟随系统
  Future setAppIsLocaleSystem(
    ApplicationProvider applicationProvider,
    bool isLocaleSystem,
  ) async {
    final SharedPreferences prefs = await init();
    prefs.setBool(appIsLocaleSystem, isLocaleSystem);
    applicationProvider.localeSystem = isLocaleSystem;
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem(
    ApplicationProvider applicationProvider,
  ) async {
    final SharedPreferences prefs = await init();
    final bool getAppIsLocaleSystem = prefs.getBool(appIsLocaleSystem) ?? true;
    applicationProvider.localeSystem = getAppIsLocaleSystem;
    return getAppIsLocaleSystem;
  }

  /// 设置-安全-密码
  Future setAppKeyPassword(
    ApplicationProvider applicationProvider,
    String keyPassword,
  ) async {
    final SharedPreferences prefs = await init();
    prefs.setString(appKeyPassword, keyPassword);
    applicationProvider.keyPassword = keyPassword;
  }

  /// 获取-安全-密码
  Future<String> getAppKeyPassword(
    ApplicationProvider applicationProvider,
  ) async {
    final SharedPreferences prefs = await init();
    final String getAppKeyPassword = prefs.getString(appKeyPassword) ?? '';
    applicationProvider.keyPassword = getAppKeyPassword;
    return getAppKeyPassword;
  }

  /// 设置-安全-生物特征识别是否开启
  Future setAppKeyBiometric(
    ApplicationProvider applicationProvider,
    bool keyBiometric,
  ) async {
    final SharedPreferences prefs = await init();
    prefs.setBool(appKeyBiometric, keyBiometric);
    applicationProvider.keyBiometric = keyBiometric;
  }

  /// 获取-安全-生物特征识别是否开启
  Future<bool> getAppKeyBiometric(
    ApplicationProvider applicationProvider,
  ) async {
    final SharedPreferences prefs = await init();
    final bool getAppKeyBiometric = prefs.getBool(appKeyBiometric) ?? false;
    applicationProvider.keyBiometric = getAppKeyBiometric;
    return getAppKeyBiometric;
  }
}
