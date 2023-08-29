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
  void loadThemeMode() async {
    _themeMode = await PreferencesDB().getAppThemeDarkMode();
    notifyListeners();
  }

  /// 设置-主题模式
  set themeMode(ThemeMode themeMode) {
    PreferencesDB().setAppThemeDarkMode(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取-多主题模式
  void loadMultipleThemesMode() async {
    _multipleThemesMode = await PreferencesDB().getMultipleThemesMode();
    notifyListeners();
  }

  /// 设置-多主题模式
  set multipleThemesMode(String multipleThemesMode) {
    PreferencesDB().setMultipleThemesMode(multipleThemesMode);
    _multipleThemesMode = multipleThemesMode;
    notifyListeners();
  }

  /// 获取-语言是否跟随系统
  void loadLocaleSystem() async {
    _localeSystem = await PreferencesDB().getAppIsLocaleSystem();
    notifyListeners();
  }

  /// 设置-语言是否跟随系统
  set localeSystem(bool localeSystem) {
    PreferencesDB().setAppIsLocaleSystem(localeSystem);
    _localeSystem = localeSystem;
    notifyListeners();
  }

  /// 获取-语言
  void loadLocale() async {
    _locale = await PreferencesDB().getAppLocale();
    notifyListeners();
  }

  /// 设置-语言
  set locale(Locale locale) {
    localeSystem = false;
    PreferencesDB().setAppLocale(locale);
    _locale = locale;
    notifyListeners();
  }

  /// 获取-安全-密码内容
  void loadKeyPassword() async {
    _keyPassword = await PreferencesDB().getAppKeyPassword();
    notifyListeners();
  }

  /// 设置-安全-密码内容
  set keyPassword(String keyPassword) {
    PreferencesDB().setAppKeyPassword(keyPassword);
    _keyPassword = keyPassword;
    notifyListeners();
  }

  /// 获取-安全-生物特征识别是否开启
  void loadKeyBiometric() async {
    _keyBiometric = await PreferencesDB().getAppKeyBiometric();
    notifyListeners();
  }

  /// 设置-安全-生物特征识别是否开启
  set keyBiometric(bool keyBiometric) {
    PreferencesDB().setAppKeyBiometric(keyBiometric);
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
