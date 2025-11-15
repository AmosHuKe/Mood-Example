import 'package:flutter/material.dart';
import '../../utils/result.dart';
import '../../shared/config/language.dart';
import '../../domain/use_cases/application/application_use_case.dart';
import '../config/multiple_theme_mode.dart';

class ApplicationViewModel extends ChangeNotifier {
  ApplicationViewModel({required ApplicationUseCase applicationUseCase})
    : _applicationUseCase = applicationUseCase {
    loadThemeMode();
    loadMultipleThemeMode();
    loadLocaleSystem();
    loadLocale();
  }

  final ApplicationUseCase _applicationUseCase;

  /// 主题模式
  ThemeMode _themeMode = .system;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode value) {
    _applicationUseCase.setThemeMode(value);
    _themeMode = value;
    notifyListeners();
  }

  /// 多主题模式
  MultipleThemeMode _multipleThemeMode = .kDefault;
  MultipleThemeMode get multipleThemeMode => _multipleThemeMode;
  set multipleThemeMode(MultipleThemeMode value) {
    _applicationUseCase.setMultipleThemeMode(value);
    _multipleThemeMode = value;
    notifyListeners();
  }

  /// 语言环境是否跟随系统
  bool _localeSystem = true;
  bool get localeSystem => _localeSystem;
  set localeSystem(bool value) {
    _applicationUseCase.setLocaleSystem(value);
    _localeSystem = value;
    notifyListeners();
  }

  /// 语言环境
  Locale _locale = Language.zhCN.locale;
  Locale get locale => _locale;
  set locale(Locale value) {
    localeSystem = false;
    _applicationUseCase.setLocale(value);
    _locale = value;
    notifyListeners();
  }

  /// 获取主题模式
  Future<Result<void>> loadThemeMode() async {
    final result = await _applicationUseCase.getThemeMode();
    switch (result) {
      case Success<ThemeMode>():
        _themeMode = result.value;
        notifyListeners();
        return const .success(null);
      case Error<ThemeMode>():
        return .error(result.error);
    }
  }

  /// 获取多主题模式
  Future<Result<void>> loadMultipleThemeMode() async {
    final result = await _applicationUseCase.getMultipleThemeMode();
    switch (result) {
      case Success<MultipleThemeMode>():
        _multipleThemeMode = result.value;
        notifyListeners();
        return const .success(null);
      case Error<MultipleThemeMode>():
        return .error(result.error);
    }
  }

  /// 获取语言环境是否跟随系统
  Future<Result<void>> loadLocaleSystem() async {
    final result = await _applicationUseCase.getLocaleSystem();
    switch (result) {
      case Success<bool>():
        _localeSystem = result.value;
        notifyListeners();
        return const .success(null);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取语言环境
  Future<Result<void>> loadLocale() async {
    final result = await _applicationUseCase.getLocale();
    switch (result) {
      case Success<Locale>():
        _locale = result.value;
        notifyListeners();
        return const .success(null);
      case Error<Locale>():
        return .error(result.error);
    }
  }
}
