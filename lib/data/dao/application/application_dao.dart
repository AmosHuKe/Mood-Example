import 'package:flutter/material.dart';
import '../../database/shared_preferences_db.dart';

class ApplicationDao {
  ApplicationDao({required SharedPreferencesDB sharedPreferencesDB})
    : _sharedPreferencesDB = sharedPreferencesDB;

  final SharedPreferencesDB _sharedPreferencesDB;

  /// 设置 - 主题外观模式
  Future<void> setAppThemeMode(ThemeMode themeMode) async {
    await _sharedPreferencesDB.sps.setString(SharedPreferencesKey.appThemeMode, themeMode.name);
  }

  /// 获取 - 主题外观模式
  Future<String?> getAppThemeMode() async {
    return _sharedPreferencesDB.sps.getString(SharedPreferencesKey.appThemeMode);
  }

  /// 设置 - 多主题模式
  Future<void> setAppMultipleThemeMode(String value) async {
    await _sharedPreferencesDB.sps.setString(SharedPreferencesKey.appMultipleThemeMode, value);
  }

  /// 获取 - 多主题模式
  Future<String?> getAppMultipleThemeMode() async {
    return _sharedPreferencesDB.sps.getString(SharedPreferencesKey.appMultipleThemeMode);
  }

  /// 设置 - App 语言环境
  Future<void> setAppLocale(Locale locale) async {
    await _sharedPreferencesDB.sps.setString(
      SharedPreferencesKey.appLocale,
      locale.toLanguageTag(),
    );
  }

  /// 获取 - App 语言环境
  Future<String?> getAppLocale() async {
    return _sharedPreferencesDB.sps.getString(SharedPreferencesKey.appLocale);
  }

  /// 设置 - App 语言环境是否跟随系统
  Future<void> setAppIsLocaleSystem(bool isLocaleSystem) async {
    await _sharedPreferencesDB.sps.setBool(SharedPreferencesKey.appIsLocaleSystem, isLocaleSystem);
  }

  /// 获取 - App 语言环境是否跟随系统
  Future<bool?> getAppIsLocaleSystem() async {
    return _sharedPreferencesDB.sps.getBool(SharedPreferencesKey.appIsLocaleSystem);
  }
}
