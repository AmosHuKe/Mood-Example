import 'package:flutter/material.dart';
import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../../shared/config/language.dart';
import '../../../shared/config/multiple_theme_mode.dart';
import '../../repositories/application/application_repository.dart';

class ApplicationUseCase {
  ApplicationUseCase({required ApplicationRepository applicationRepository})
    : _applicationRepository = applicationRepository;

  final ApplicationRepository _applicationRepository;

  void _log(Object? value, {Result<Object?> result = const .success(null)}) {
    LogUtils.log('${'[${this.runtimeType}]'.blue} ${value}', result: result);
  }

  /// 获取主题模式
  Future<Result<ThemeMode>> getThemeMode() async {
    final result = await _applicationRepository.getThemeMode();
    switch (result) {
      case Success<ThemeMode>():
        _log('${getThemeMode.toString()} ${result.value}', result: result);
        return .success(result.value);
      case Error<ThemeMode>():
        _log('${getThemeMode.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 设置主题模式
  Future<Result<bool>> setThemeMode(ThemeMode themeMode) async {
    final result = await _applicationRepository.setThemeMode(themeMode);
    switch (result) {
      case Success<bool>():
        _log('${setThemeMode.toString()} ${themeMode}', result: result);
        return .success(result.value);
      case Error<bool>():
        _log('${setThemeMode.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取多主题模式
  Future<Result<MultipleThemeMode>> getMultipleThemeMode() async {
    final result = await _applicationRepository.getMultipleThemeMode();
    switch (result) {
      case Success<MultipleThemeMode>():
        _log('${getMultipleThemeMode.toString()} ${result.value}', result: result);
        return .success(result.value);
      case Error<MultipleThemeMode>():
        _log('${getMultipleThemeMode.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 设置多主题模式
  Future<Result<bool>> setMultipleThemeMode(MultipleThemeMode multipleThemeMode) async {
    final result = await _applicationRepository.setMultipleThemeMode(multipleThemeMode);
    switch (result) {
      case Success<bool>():
        _log('${setMultipleThemeMode.toString()} ${multipleThemeMode}', result: result);
        return .success(result.value);
      case Error<bool>():
        _log('${setMultipleThemeMode.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取语言环境是否跟随系统
  Future<Result<bool>> getLocaleSystem() async {
    final result = await _applicationRepository.getLocaleSystem();
    switch (result) {
      case Success<bool?>():
        final resultValue = result.value ?? true;
        _log('${getLocaleSystem.toString()} ${resultValue}', result: result);
        return .success(resultValue);
      case Error<bool?>():
        _log('${getLocaleSystem.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 设置语言环境是否跟随系统
  Future<Result<bool>> setLocaleSystem(bool localeSystem) async {
    final result = await _applicationRepository.setLocaleSystem(localeSystem);
    switch (result) {
      case Success<bool>():
        _log('${setLocaleSystem.toString()} ${localeSystem}', result: result);
        return .success(result.value);
      case Error<bool>():
        _log('${setLocaleSystem.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取语言环境
  Future<Result<Locale>> getLocale() async {
    final result = await _applicationRepository.getLocale();
    switch (result) {
      case Success<Locale?>():
        final resultValue = result.value ?? Language.zhCN.locale;
        _log('${getLocale.toString()} ${resultValue}', result: result);
        return .success(resultValue);
      case Error<Locale?>():
        _log('${getLocale.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 设置语言环境
  Future<Result<bool>> setLocale(Locale locale) async {
    final result = await _applicationRepository.setLocale(locale);
    switch (result) {
      case Success<bool>():
        _log('${setLocale.toString()} ${locale}', result: result);
        return setLocaleSystem(false);
      case Error<bool>():
        _log('${setLocale.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }
}
