import 'package:flutter/material.dart';

import '../../../shared/config/language.dart';
import '../../../shared/config/multiple_theme_mode.dart';
import '../../../shared/utils/log_utils.dart';
import '../../../shared/utils/result.dart';
import '../../repositories/application/application_repository.dart';

class ApplicationUseCase {
  ApplicationUseCase({required ApplicationRepository applicationRepository})
    : _applicationRepository = applicationRepository;

  final ApplicationRepository _applicationRepository;

  /// 获取主题模式
  Future<Result<ThemeMode>> getThemeMode() async {
    final result = await _applicationRepository.getThemeMode();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<ThemeMode>():
        return .success(result.value);
      case Error<ThemeMode>():
        return .error(result.error);
    }
  }

  /// 设置主题模式
  Future<Result<bool>> setThemeMode(ThemeMode themeMode) async {
    final result = await _applicationRepository.setThemeMode(themeMode);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result, themeMode.name);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取多主题模式
  Future<Result<MultipleThemeMode>> getMultipleThemeMode() async {
    final result = await _applicationRepository.getMultipleThemeMode();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<MultipleThemeMode>():
        return .success(result.value);
      case Error<MultipleThemeMode>():
        return .error(result.error);
    }
  }

  /// 设置多主题模式
  Future<Result<bool>> setMultipleThemeMode(MultipleThemeMode multipleThemeMode) async {
    final result = await _applicationRepository.setMultipleThemeMode(multipleThemeMode);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result, multipleThemeMode.name);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取语言环境是否跟随系统
  Future<Result<bool>> getLocaleSystem() async {
    final result = await _applicationRepository.getLocaleSystem();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<bool?>():
        final resultValue = result.value ?? true;
        return .success(resultValue);
      case Error<bool?>():
        return .error(result.error);
    }
  }

  /// 设置语言环境是否跟随系统
  Future<Result<bool>> setLocaleSystem(bool localeSystem) async {
    final result = await _applicationRepository.setLocaleSystem(localeSystem);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result, localeSystem);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取语言环境
  Future<Result<Locale>> getLocale() async {
    final result = await _applicationRepository.getLocale();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<Locale?>():
        final resultValue = result.value ?? Language.zhCN.locale;
        return .success(resultValue);
      case Error<Locale?>():
        return .error(result.error);
    }
  }

  /// 设置语言环境
  Future<Result<bool>> setLocale(Locale locale) async {
    final result = await _applicationRepository.setLocale(locale);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result, locale);
    }
    switch (result) {
      case Success<bool>():
        return setLocaleSystem(false);
      case Error<bool>():
        return .error(result.error);
    }
  }
}
