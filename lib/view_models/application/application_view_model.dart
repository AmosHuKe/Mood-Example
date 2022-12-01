import 'package:flutter/material.dart';

/// App相关
class ApplicationViewModel extends ChangeNotifier {
  /// 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 多主题模式
  String _multipleThemesMode = "default";

  /// 语言是否跟随系统
  bool _localeSystem = true;

  /// 语言
  Locale _locale = const Locale('zh');

  /// 安全-密码内容
  String _keyPassword = "";

  /// 安全-密码界面是否打开
  bool _keyPasswordScreenOpen = false;

  /// 安全-生物特征识别是否开启
  bool _keyBiometric = false;

  /// 设置-主题模式
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  /// 设置-多主题模式
  void setMultipleThemesMode(String multipleThemesMode) {
    _multipleThemesMode = multipleThemesMode;
    notifyListeners();
  }

  /// 设置-语言是否跟随系统
  void setLocaleSystem(bool localeSystem) {
    _localeSystem = localeSystem;
    notifyListeners();
  }

  /// 设置-语言
  void setLocale(Locale locale) {
    _localeSystem = false;
    _locale = locale;
    notifyListeners();
  }

  /// 设置-安全-密码内容
  void setKeyPassword(String keyPassword) {
    _keyPassword = keyPassword;
    notifyListeners();
  }

  /// 设置-安全-密码界面是否打开
  void setKeyPasswordScreenOpen(bool keyPasswordScreenOpen) {
    _keyPasswordScreenOpen = keyPasswordScreenOpen;
    notifyListeners();
  }

  /// 设置-安全-生物特征识别是否开启
  void setKeyBiometric(bool keyBiometric) {
    _keyBiometric = keyBiometric;
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
