import 'package:flutter/material.dart';

///
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/theme/app_theme.dart';

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
  Future setAppThemeDarkMode(BuildContext context, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appThemeDarkMode, value);
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setThemeMode(darkThemeMode(value));
  }

  /// 获取-主题外观模式
  Future<String> getAppThemeDarkMode(BuildContext context) async {
    SharedPreferences prefs = await init();
    String themeDarkMode = prefs.getString(appThemeDarkMode) ?? "system";
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setThemeMode(darkThemeMode(themeDarkMode));
    return themeDarkMode;
  }

  /// 设置-多主题模式
  Future setMultipleThemesMode(BuildContext context, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(appMultipleThemesMode, value);
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setMultipleThemesMode(value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode(BuildContext context) async {
    SharedPreferences prefs = await init();
    String multipleThemesMode =
        prefs.getString(appMultipleThemesMode) ?? "default";
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setMultipleThemesMode(multipleThemesMode);
    return multipleThemesMode;
  }

  /// 设置-APP地区语言
  Future setAppLocale(BuildContext context, String? locale) async {
    SharedPreferences prefs = await init();
    debugPrint(locale);
    await setAppIsLocaleSystem(context, false);
    final appLocale = locale ?? "zh";
    final appLocaleList = appLocale.split('_');
    prefs.setString(appLocale, appLocale);
    Provider.of<ApplicationViewModel>(context, listen: false).setLocale(Locale(
        appLocaleList[0], appLocaleList.length > 1 ? appLocaleList[1] : ''));
  }

  /// 获取-APP地区语言
  Future<String> getAppLocale(BuildContext context) async {
    SharedPreferences prefs = await init();
    String getAppLocale = prefs.getString(appLocale) ?? "zh";
    final appLocaleList = getAppLocale.split('_');
    Provider.of<ApplicationViewModel>(context, listen: false).setLocale(Locale(
        appLocaleList[0], appLocaleList.length > 1 ? appLocaleList[1] : ''));
    return getAppLocale;
  }

  /// 设置-APP地区语言是否跟随系统
  Future setAppIsLocaleSystem(BuildContext context, bool isLocaleSystem) async {
    SharedPreferences prefs = await init();
    prefs.setBool(appIsLocaleSystem, isLocaleSystem);
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setLocaleSystem(isLocaleSystem);
  }

  /// 获取-APP地区语言是否跟随系统
  Future<bool> getAppIsLocaleSystem(BuildContext context) async {
    SharedPreferences prefs = await init();
    bool getAppIsLocaleSystem = prefs.getBool(appIsLocaleSystem) ?? true;
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setLocaleSystem(getAppIsLocaleSystem);
    return getAppIsLocaleSystem;
  }
}
