import 'package:flutter/material.dart';

///
import 'package:shared_preferences/shared_preferences.dart';

///
import 'package:moodexample/themes/app_theme.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// shared_preferences
class PreferencesDB {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  /*** APP相关 ***/
  /// 打开APP次数
  static const openAPPCount = "openAPPCount";

  /// 主题外观模式
  ///
  /// system(默认)：跟随系统 light：普通 dark：深色
  static const appThemeDarkMode = "appThemeDarkMode";

  /// 多主题模式
  ///
  /// default(默认)
  static const appMultipleThemesMode = "appMultipleThemesMode";

  /// APP地区语言
  static const appLocale = "appLocale";

  /// APP地区语言是否跟随系统
  static const appIsLocaleSystem = "appIsLocaleSystem";

  /// 安全-密码
  static const appKeyPassword = "appKeyPassword";

  /// 安全-生物特征识别是否开启
  static const appKeyBiometric = "appKeyBiometric";

  /*** 数据库相关 ***/
  /// 是否填充完成【心情类别】表默认值
  static const initMoodCategoryDefaultType = "initMoodCategoryDefaultType";

  /*** shared_preferences ***/
  /// 设置-是否填充完成【心情类别】表默认值
  Future setInitMoodCategoryDefaultType(bool value) async {
    SharedPreferences prefs = await init();
    prefs.setBool(initMoodCategoryDefaultType, value);
  }

  /// 获取-是否填充完成【心情类别】表默认值
  Future<bool> getInitMoodCategoryDefaultType() async {
    SharedPreferences prefs = await init();
    return prefs.getBool(initMoodCategoryDefaultType) ?? false;
  }

  /// 设置-主题外观模式
  Future setAppThemeDarkMode(
      ApplicationViewModel applicationViewModel, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appThemeDarkMode, value);
    applicationViewModel.setThemeMode(darkThemeMode(value));
  }

  /// 获取-主题外观模式
  Future<String> getAppThemeDarkMode(
      ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String themeDarkMode = prefs.getString(appThemeDarkMode) ?? "system";
    applicationViewModel.setThemeMode(darkThemeMode(themeDarkMode));
    return themeDarkMode;
  }

  /// 设置-多主题模式
  Future setMultipleThemesMode(
      ApplicationViewModel applicationViewModel, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appMultipleThemesMode, value);
    applicationViewModel.setMultipleThemesMode(value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode(
      ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String multipleThemesMode =
        prefs.getString(appMultipleThemesMode) ?? "default";
    applicationViewModel.setMultipleThemesMode(multipleThemesMode);
    return multipleThemesMode;
  }

  /// 设置-APP地区语言
  Future setAppLocale(
      ApplicationViewModel applicationViewModel, String? locale) async {
    SharedPreferences prefs = await init();
    debugPrint(locale);
    await setAppIsLocaleSystem(applicationViewModel, false);
    final appLocaleSystem = locale ?? "zh";
    final appLocaleList = appLocaleSystem.split('_');
    prefs.setString(appLocale, appLocaleSystem);
    applicationViewModel.setLocale(Locale(
        appLocaleList[0], appLocaleList.length > 1 ? appLocaleList[1] : ''));
  }

  /// 获取-APP地区语言
  Future<String> getAppLocale(ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String getAppLocale = prefs.getString(appLocale) ?? "zh";
    final appLocaleList = getAppLocale.split('_');
    applicationViewModel.setLocale(Locale(
        appLocaleList[0], appLocaleList.length > 1 ? appLocaleList[1] : ''));
    return getAppLocale;
  }

  /// 设置-APP地区语言是否跟随系统
  Future setAppIsLocaleSystem(
      ApplicationViewModel applicationViewModel, bool isLocaleSystem) async {
    SharedPreferences prefs = await init();
    prefs.setBool(appIsLocaleSystem, isLocaleSystem);
    applicationViewModel.setLocaleSystem(isLocaleSystem);
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem(
      ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    bool getAppIsLocaleSystem = prefs.getBool(appIsLocaleSystem) ?? true;
    applicationViewModel.setLocaleSystem(getAppIsLocaleSystem);
    return getAppIsLocaleSystem;
  }

  /// 设置-安全-密码
  Future setAppKeyPassword(
      ApplicationViewModel applicationViewModel, String keyPassword) async {
    SharedPreferences prefs = await init();
    prefs.setString(appKeyPassword, keyPassword);
    applicationViewModel.setKeyPassword(keyPassword);
  }

  /// 获取-安全-密码
  Future<String> getAppKeyPassword(
      ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    String getAppKeyPassword = prefs.getString(appKeyPassword) ?? "";
    applicationViewModel.setKeyPassword(getAppKeyPassword);
    return getAppKeyPassword;
  }

  /// 设置-安全-生物特征识别是否开启
  Future setAppKeyBiometric(
      ApplicationViewModel applicationViewModel, bool keyBiometric) async {
    SharedPreferences prefs = await init();
    prefs.setBool(appKeyBiometric, keyBiometric);
    applicationViewModel.setKeyBiometric(keyBiometric);
  }

  /// 获取-安全-生物特征识别是否开启
  Future<bool> getAppKeyBiometric(
      ApplicationViewModel applicationViewModel) async {
    SharedPreferences prefs = await init();
    bool getAppKeyBiometric = prefs.getBool(appKeyBiometric) ?? false;
    applicationViewModel.setKeyBiometric(getAppKeyBiometric);
    return getAppKeyBiometric;
  }
}
