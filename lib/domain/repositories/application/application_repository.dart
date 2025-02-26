import 'package:flutter/material.dart';
import '../../../utils/result.dart';
import '../../../shared/config/multiple_theme_mode.dart';

abstract class ApplicationRepository {
  /// 获取主题模式
  Future<Result<ThemeMode>> getThemeMode();

  /// 设置主题模式
  Future<Result<bool>> setThemeMode(ThemeMode themeMode);

  /// 获取多主题模式
  Future<Result<MultipleThemeMode>> getMultipleThemeMode();

  /// 设置多主题模式
  Future<Result<bool>> setMultipleThemeMode(MultipleThemeMode multipleThemeMode);

  /// 获取语言环境是否跟随系统
  Future<Result<bool?>> getLocaleSystem();

  /// 设置语言环境是否跟随系统
  Future<Result<bool>> setLocaleSystem(bool localeSystem);

  /// 获取语言环境
  Future<Result<Locale?>> getLocale();

  /// 设置语言环境
  Future<Result<bool>> setLocale(Locale locale);
}
