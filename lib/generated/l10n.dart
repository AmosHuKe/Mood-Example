// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Database`
  String get app_setting_database {
    return Intl.message(
      'Database',
      name: 'app_setting_database',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get app_setting_theme {
    return Intl.message(
      'Theme',
      name: 'app_setting_theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get app_setting_language {
    return Intl.message(
      'Language',
      name: 'app_setting_language',
      desc: '',
      args: [],
    );
  }

  /// `Laboratory`
  String get app_setting_laboratory {
    return Intl.message(
      'Laboratory',
      name: 'app_setting_laboratory',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get app_setting_about {
    return Intl.message(
      'About',
      name: 'app_setting_about',
      desc: '',
      args: [],
    );
  }

  /// `Hi~`
  String get home_hi {
    return Intl.message(
      'Hi~',
      name: 'home_hi',
      desc: '',
      args: [],
    );
  }

  /// `How do you feel now`
  String get home_moodChoice {
    return Intl.message(
      'How do you feel now',
      name: 'home_moodChoice',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
