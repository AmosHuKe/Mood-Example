import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../config/language.dart';
import '../config/multiple_theme_mode.dart';
import '../themes/app_theme.dart';

/// shared_preferences
class PreferencesDB {
  PreferencesDB._();
  static final PreferencesDB instance = PreferencesDB._();
  SharedPreferencesAsync? _instance;
  SharedPreferencesAsync get sps => _instance ??= SharedPreferencesAsync();

  /*** APP相关 ***/

  /// 打开APP次数
  static const openAPPCount = 'openAPPCount';

  /// 主题外观模式
  ///
  /// [ThemeMode]
  static const appThemeMode = 'appThemeMode';

  /// 多主题模式
  ///
  /// [MultipleThemeMode]
  static const appMultipleThemeMode = 'appMultipleThemeMode';

  /// APP地区语言
  static const appLocale = 'appLocale';

  /// APP地区语言是否跟随系统
  static const appIsLocaleSystem = 'appIsLocaleSystem';

  /// 安全-密码
  static const appKeyPassword = 'appKeyPassword';

  /// 安全-生物特征识别是否开启
  static const appKeyBiometric = 'appKeyBiometric';

  ////// 数据库相关

  /// 是否填充完成【心情类别】表默认值
  static const initMoodCategoryDefaultType = 'initMoodCategoryDefaultType';

  ////// shared_preferences

  /// 设置-是否填充完成【心情类别】表默认值
  Future<void> setInitMoodCategoryDefaultType(bool value) async {
    await sps.setBool(initMoodCategoryDefaultType, value);
  }

  /// 获取-是否填充完成【心情类别】表默认值
  Future<bool> getInitMoodCategoryDefaultType() async {
    return await sps.getBool(initMoodCategoryDefaultType) ?? false;
  }

  /// 设置-主题外观模式
  Future<void> setAppThemeMode(ThemeMode themeMode) async {
    await sps.setString(appThemeMode, themeMode.name);
  }

  /// 获取-主题外观模式
  Future<ThemeMode> getAppThemeMode() async {
    final themeDarkMode = await sps.getString(appThemeMode) ?? ThemeMode.system.name;
    return AppTheme.themeModeFromString(themeDarkMode);
  }

  /// 设置-多主题模式
  Future<void> setMultipleThemeMode(String value) async {
    await sps.setString(appMultipleThemeMode, value);
  }

  /// 获取-多主题模式
  Future<MultipleThemeMode> getMultipleThemeMode() async {
    final appThemeMode =
        await sps.getString(appMultipleThemeMode) ?? MultipleThemeMode.kDefault.name;
    return MultipleThemeMode.fromString(appThemeMode);
  }

  /// 设置-APP地区语言
  Future<void> setAppLocale(Locale locale) async {
    print(locale.toLanguageTag());
    await sps.setString(appLocale, locale.toLanguageTag());
  }

  /// 获取-APP地区语言
  Future<Locale> getAppLocale() async {
    final getAppLocale = await sps.getString(appLocale) ?? Language.zhCN.locale.toLanguageTag();
    final appLocaleList = getAppLocale.split('-');
    return Locale(appLocaleList[0], appLocaleList.length > 1 ? appLocaleList[1] : '');
  }

  /// 设置-APP地区语言是否跟随系统
  Future<void> setAppIsLocaleSystem(bool isLocaleSystem) async {
    await sps.setBool(appIsLocaleSystem, isLocaleSystem);
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem() async {
    return await sps.getBool(appIsLocaleSystem) ?? true;
  }

  /// 设置-安全-密码
  Future<void> setAppKeyPassword(String keyPassword) async {
    await sps.setString(appKeyPassword, keyPassword);
  }

  /// 获取-安全-密码
  Future<String> getAppKeyPassword() async {
    return await sps.getString(appKeyPassword) ?? '';
  }

  /// 设置-安全-生物特征识别是否开启
  Future<void> setAppKeyBiometric(bool keyBiometric) async {
    await sps.setBool(appKeyBiometric, keyBiometric);
  }

  /// 获取-安全-生物特征识别是否开启
  Future<bool> getAppKeyBiometric() async {
    return await sps.getBool(appKeyBiometric) ?? false;
  }
}
