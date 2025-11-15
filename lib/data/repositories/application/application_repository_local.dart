import 'package:flutter/material.dart';
import '../../../utils/result.dart';
import '../../../themes/app_theme.dart';
import '../../../shared/config/multiple_theme_mode.dart';
import '../../../domain/repositories/application/application_repository.dart';
import '../../dao/application/application_dao.dart';

class ApplicationRepositoryLocal implements ApplicationRepository {
  ApplicationRepositoryLocal({required ApplicationDao applicationDao})
    : _applicationDao = applicationDao;

  final ApplicationDao _applicationDao;

  @override
  Future<Result<ThemeMode>> getThemeMode() async {
    try {
      final value = await _applicationDao.getAppThemeMode();
      final appThemeMode = AppTheme.themeModeFromString(value ?? '');
      return .success(appThemeMode);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> setThemeMode(ThemeMode themeMode) async {
    try {
      await _applicationDao.setAppThemeMode(themeMode);
      return const .success(true);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<MultipleThemeMode>> getMultipleThemeMode() async {
    try {
      final value = await _applicationDao.getAppMultipleThemeMode();
      final appMultipleThemeMode = MultipleThemeMode.fromString(value ?? '');
      return .success(appMultipleThemeMode);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> setMultipleThemeMode(MultipleThemeMode multipleThemeMode) async {
    try {
      await _applicationDao.setAppMultipleThemeMode(multipleThemeMode.name);
      return const .success(true);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool?>> getLocaleSystem() async {
    try {
      final value = await _applicationDao.getAppIsLocaleSystem();
      return .success(value);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> setLocaleSystem(bool localeSystem) async {
    try {
      await _applicationDao.setAppIsLocaleSystem(localeSystem);
      return const .success(true);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<Locale?>> getLocale() async {
    try {
      final value = await _applicationDao.getAppLocale();
      if (value != null) {
        final localeLanguageTag = value.split('-');
        return .success(
          Locale(localeLanguageTag[0], localeLanguageTag.length > 1 ? localeLanguageTag[1] : null),
        );
      } else {
        return const .success(null);
      }
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> setLocale(Locale locale) async {
    try {
      await _applicationDao.setAppLocale(locale);
      return const .success(true);
    } on Exception catch (e) {
      return .error(e);
    }
  }
}
