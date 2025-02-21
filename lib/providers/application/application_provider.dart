import 'package:flutter/material.dart';
import '../../config/multiple_theme_mode.dart';
import '../../database/preferences_db.dart';

/// App相关
class ApplicationProvider extends ChangeNotifier {
  ApplicationProvider() {
    loadThemeMode();
    loadMultipleThemeMode();
    loadLocaleSystem();
    loadLocale();
    loadKeyPassword();
    loadKeyBiometric();
  }

  /// 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 多主题模式
  MultipleThemeMode _multipleThemeMode = MultipleThemeMode.kDefault;

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
    _themeMode = await PreferencesDB.instance.getAppThemeMode();
    notifyListeners();
  }

  /// 设置-主题模式
  set themeMode(ThemeMode themeMode) {
    PreferencesDB.instance.setAppThemeMode(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 获取-多主题模式
  Future<void> loadMultipleThemeMode() async {
    _multipleThemeMode = await PreferencesDB.instance.getMultipleThemeMode();
    notifyListeners();
  }

  /// 设置-多主题模式
  set multipleThemeMode(MultipleThemeMode multipleThemeMode) {
    PreferencesDB.instance.setMultipleThemeMode(multipleThemeMode.name);
    _multipleThemeMode = multipleThemeMode;
    notifyListeners();
  }

  /// 获取-语言是否跟随系统
  Future<void> loadLocaleSystem() async {
    _localeSystem = await PreferencesDB.instance.getAppIsLocaleSystem();
    notifyListeners();
  }

  /// 设置-语言是否跟随系统
  set localeSystem(bool localeSystem) {
    PreferencesDB.instance.setAppIsLocaleSystem(localeSystem);
    _localeSystem = localeSystem;
    notifyListeners();
  }

  /// 获取-语言
  Future<void> loadLocale() async {
    _locale = await PreferencesDB.instance.getAppLocale();
    notifyListeners();
  }

  /// 设置-语言
  set locale(Locale locale) {
    localeSystem = false;
    PreferencesDB.instance.setAppLocale(locale);
    _locale = locale;
    notifyListeners();
  }

  /// 获取-安全-密码内容
  Future<void> loadKeyPassword() async {
    _keyPassword = await PreferencesDB.instance.getAppKeyPassword();
    notifyListeners();
  }

  /// 设置-安全-密码内容
  set keyPassword(String keyPassword) {
    PreferencesDB.instance.setAppKeyPassword(keyPassword);
    _keyPassword = keyPassword;
    notifyListeners();
  }

  /// 获取-安全-生物特征识别是否开启
  Future<void> loadKeyBiometric() async {
    _keyBiometric = await PreferencesDB.instance.getAppKeyBiometric();
    notifyListeners();
  }

  /// 设置-安全-生物特征识别是否开启
  set keyBiometric(bool keyBiometric) {
    PreferencesDB.instance.setAppKeyBiometric(keyBiometric);
    _keyBiometric = keyBiometric;
    notifyListeners();
  }

  /// 设置-安全-密码界面是否打开
  set keyPasswordScreenOpen(bool keyPasswordScreenOpen) {
    _keyPasswordScreenOpen = keyPasswordScreenOpen;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
  MultipleThemeMode get multipleThemeMode => _multipleThemeMode;
  Locale get locale => _locale;
  bool get localeSystem => _localeSystem;
  String get keyPassword => _keyPassword;
  bool get keyBiometric => _keyBiometric;
  bool get keyPasswordScreenOpen => _keyPasswordScreenOpen;
}
