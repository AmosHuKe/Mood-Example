import 'package:flutter/material.dart';

/// App相关
class ApplicationViewModel extends ChangeNotifier {
  /// 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 语言是否跟随系统
  bool _localeSystem = true;

  /// 语言
  Locale _locale = const Locale('zh');

  /// 设置-主题模式
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
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

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get localeSystem => _localeSystem;
}
