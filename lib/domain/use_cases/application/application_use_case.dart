import 'package:flutter/material.dart';
import '../../../utils/result.dart';
import '../../../shared/config/language.dart';
import '../../../shared/config/multiple_theme_mode.dart';
import '../../repositories/application/application_repository.dart';

class ApplicationUseCase {
  ApplicationUseCase({required ApplicationRepository applicationRepository})
    : _applicationRepository = applicationRepository;

  final ApplicationRepository _applicationRepository;

  /// 获取主题模式
  Future<Result<ThemeMode>> getThemeMode() async {
    return _applicationRepository.getThemeMode();
  }

  /// 设置主题模式
  Future<Result<bool>> setThemeMode(ThemeMode themeMode) async {
    return _applicationRepository.setThemeMode(themeMode);
  }

  /// 获取多主题模式
  Future<Result<MultipleThemeMode>> getMultipleThemeMode() async {
    return _applicationRepository.getMultipleThemeMode();
  }

  /// 设置多主题模式
  Future<Result<bool>> setMultipleThemeMode(MultipleThemeMode multipleThemeMode) async {
    return _applicationRepository.setMultipleThemeMode(multipleThemeMode);
  }

  /// 获取语言环境是否跟随系统
  Future<Result<bool>> getLocaleSystem() async {
    final localeSystemResult = await _applicationRepository.getLocaleSystem();
    switch (localeSystemResult) {
      case Success<bool?>():
        return Result.success(localeSystemResult.value ?? true);
      case Error<bool?>():
        print('ApplicationUseCase error: ${localeSystemResult.error}');
        return Result.error(localeSystemResult.error);
    }
  }

  /// 设置语言环境是否跟随系统
  Future<Result<bool>> setLocaleSystem(bool localeSystem) async {
    return _applicationRepository.setLocaleSystem(localeSystem);
  }

  /// 获取语言环境
  Future<Result<Locale>> getLocale() async {
    final localeResult = await _applicationRepository.getLocale();
    switch (localeResult) {
      case Success<Locale?>():
        return Result.success(localeResult.value ?? Language.zhCN.locale);
      case Error<Locale?>():
        print('ApplicationUseCase error: ${localeResult.error}');
        return Result.error(localeResult.error);
    }
  }

  /// 设置语言环境
  Future<Result<bool>> setLocale(Locale locale) async {
    final setLocaleSystemResult = await setLocaleSystem(false);
    switch (setLocaleSystemResult) {
      case Success<bool>():
        return _applicationRepository.setLocale(locale);
      case Error<bool>():
        print('ApplicationUseCase error: ${setLocaleSystemResult.error}');
        return Result.error(setLocaleSystemResult.error);
    }
  }
}
