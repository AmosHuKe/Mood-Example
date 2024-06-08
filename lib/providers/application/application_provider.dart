import 'package:flutter/material.dart';

import 'package:moodexample/db/preferences_db.dart';

/// App相关
class ApplicationProvider extends ChangeNotifier {
  /// 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 多主题模式
  String _multipleThemesMode = 'default';

  /// 语言是否跟随系统
  bool _localeSystem = true;

  /// 语言
  Locale _locale = const Locale('zh');

  /// 安全-密码内容
  String _keyPassword = '';

  /// 安全-密码界面是否打开
  bool _keyPasswordScreenOpen = false;

  /// 安全-生物特征识别是否开启
  bool _keyBiometric = false;

  /// 获取-主题模式
  Future<void> loadThemeMode() async {
    _themeMode = await PreferencesDB.db.getAppThemeDarkMode();
    notifyListeners();
  }

  /// 设置-主题模式
  set themeMode(ThemeMode themeMode) {
    PreferencesDB.db.setAppThemeDarkMode(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取-多主题模式
  Future<void> loadMultipleThemesMode() async {
    _multipleThemesMode = await PreferencesDB.db.getMultipleThemesMode();
    notifyListeners();
  }

  /// 设置-多主题模式
  set multipleThemesMode(String multipleThemesMode) {
    PreferencesDB.db.setMultipleThemesMode(multipleThemesMode);
    _multipleThemesMode = multipleThemesMode;
    notifyListeners();
  }

  /// 获取-语言是否跟随系统
  Future<void> loadLocaleSystem() async {
    _localeSystem = await PreferencesDB.db.getAppIsLocaleSystem();
    notifyListeners();
  }

  /// 设置-语言是否跟随系统
  set localeSystem(bool localeSystem) {
    PreferencesDB.db.setAppIsLocaleSystem(localeSystem);
    _localeSystem = localeSystem;
    notifyListeners();
  }

  /// 获取-语言
  Future<void> loadLocale() async {
    _locale = await PreferencesDB.db.getAppLocale();
    notifyListeners();
  }

  /// 设置-语言
  set locale(Locale locale) {
    localeSystem = false;
    PreferencesDB.db.setAppLocale(locale);
    _locale = locale;
    notifyListeners();
  }

  /// 获取-安全-密码内容
  Future<void> loadKeyPassword() async {
    _keyPassword = await PreferencesDB.db.getAppKeyPassword();
    notifyListeners();
  }

  /// 设置-安全-密码内容
  set keyPassword(String keyPassword) {
    PreferencesDB.db.setAppKeyPassword(keyPassword);
    _keyPassword = keyPassword;
    notifyListeners();
  }

  /// 获取-安全-生物特征识别是否开启
  Future<void> loadKeyBiometric() async {
    _keyBiometric = await PreferencesDB.db.getAppKeyBiometric();
    notifyListeners();
  }

  /// 设置-安全-生物特征识别是否开启
  set keyBiometric(bool keyBiometric) {
    PreferencesDB.db.setAppKeyBiometric(keyBiometric);
    _keyBiometric = keyBiometric;
    notifyListeners();
  }

  /// 设置-安全-密码界面是否打开
  set keyPasswordScreenOpen(bool keyPasswordScreenOpen) {
    _keyPasswordScreenOpen = keyPasswordScreenOpen;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
  String get multipleThemesMode => _multipleThemesMode;
  Locale get locale => _locale;
  bool get localeSystem => _localeSystem;
  String get keyPassword => _keyPassword;
  bool get keyBiometric => _keyBiometric;
  bool get keyPasswordScreenOpen => _keyPasswordScreenOpen;
}
