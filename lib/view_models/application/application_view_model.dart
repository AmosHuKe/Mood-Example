import 'package:flutter/material.dart';

/// App相关
class ApplicationViewModel extends ChangeNotifier {
  /// 主题模式
  ThemeMode _themeMode = ThemeMode.system;

  /// 设置-主题模式
  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
}
