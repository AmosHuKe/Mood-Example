import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:moodexample/themes/app_theme.dart';

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
  Future<bool> setInitMoodCategoryDefaultType(bool value) async {
    final SharedPreferences prefs = await init();
    return prefs.setBool(initMoodCategoryDefaultType, value);
  }

  /// 获取-是否填充完成【心情类别】表默认值
  Future<bool> getInitMoodCategoryDefaultType() async {
    final SharedPreferences prefs = await init();
    return prefs.getBool(initMoodCategoryDefaultType) ?? false;
  }

  /// 设置-主题外观模式
  Future<bool> setAppThemeDarkMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await init();
    return prefs.setString(appThemeDarkMode, themeMode.name);
  }

  /// 获取-主题外观模式
  Future<ThemeMode> getAppThemeDarkMode() async {
    final SharedPreferences prefs = await init();
    final String themeDarkMode = prefs.getString(appThemeDarkMode) ?? 'system';
    return darkThemeMode(themeDarkMode);
  }

  /// 设置-多主题模式
  Future<bool> setMultipleThemesMode(String value) async {
    final SharedPreferences prefs = await init();
    return prefs.setString(appMultipleThemesMode, value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode() async {
    final SharedPreferences prefs = await init();
    return prefs.getString(appMultipleThemesMode) ?? 'default';
  }

  /// 设置-APP地区语言
  Future<bool> setAppLocale(Locale locale) async {
    final SharedPreferences prefs = await init();
    print(locale.toLanguageTag());
    return prefs.setString(appLocale, locale.toLanguageTag());
  }

  /// 获取-APP地区语言
  Future<Locale> getAppLocale() async {
    final SharedPreferences prefs = await init();
    final String getAppLocale = prefs.getString(appLocale) ?? 'zh';
    final appLocaleList = getAppLocale.split('-');
    return Locale(
      appLocaleList[0],
      appLocaleList.length > 1 ? appLocaleList[1] : '',
    );
  }

  /// 设置-APP地区语言是否跟随系统
  Future<bool> setAppIsLocaleSystem(bool isLocaleSystem) async {
    final SharedPreferences prefs = await init();
    return prefs.setBool(appIsLocaleSystem, isLocaleSystem);
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem() async {
    final SharedPreferences prefs = await init();
    return prefs.getBool(appIsLocaleSystem) ?? true;
  }

  /// 设置-安全-密码
  Future<bool> setAppKeyPassword(String keyPassword) async {
    final SharedPreferences prefs = await init();
    return prefs.setString(appKeyPassword, keyPassword);
  }

  /// 获取-安全-密码
  Future<String> getAppKeyPassword() async {
    final SharedPreferences prefs = await init();
    return prefs.getString(appKeyPassword) ?? '';
  }

  /// 设置-安全-生物特征识别是否开启
  Future<bool> setAppKeyBiometric(bool keyBiometric) async {
    final SharedPreferences prefs = await init();
    return prefs.setBool(appKeyBiometric, keyBiometric);
  }

  /// 获取-安全-生物特征识别是否开启
  Future<bool> getAppKeyBiometric() async {
    final SharedPreferences prefs = await init();
    return prefs.getBool(appKeyBiometric) ?? false;
  }
}
