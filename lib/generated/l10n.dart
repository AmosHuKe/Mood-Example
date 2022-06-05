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

  /// `Home`
  String get app_bottomNavigationBar_title_home {
    return Intl.message(
      'Home',
      name: 'app_bottomNavigationBar_title_home',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get app_bottomNavigationBar_title_mood {
    return Intl.message(
      'Mood',
      name: 'app_bottomNavigationBar_title_mood',
      desc: '',
      args: [],
    );
  }

  /// `Statistic`
  String get app_bottomNavigationBar_title_statistic {
    return Intl.message(
      'Statistic',
      name: 'app_bottomNavigationBar_title_statistic',
      desc: '',
      args: [],
    );
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

  /// `Export data`
  String get app_setting_database_export_data {
    return Intl.message(
      'Export data',
      name: 'app_setting_database_export_data',
      desc: '',
      args: [],
    );
  }

  /// `Export succeeded`
  String get app_setting_database_export_data_toast_success {
    return Intl.message(
      'Export succeeded',
      name: 'app_setting_database_export_data_toast_success',
      desc: '',
      args: [],
    );
  }

  /// `Import data`
  String get app_setting_database_import_data {
    return Intl.message(
      'Import data',
      name: 'app_setting_database_import_data',
      desc: '',
      args: [],
    );
  }

  /// `ERR`
  String get app_setting_database_import_data_button_error {
    return Intl.message(
      'ERR',
      name: 'app_setting_database_import_data_button_error',
      desc: '',
      args: [],
    );
  }

  /// `TMPL`
  String get app_setting_database_import_data_button_template {
    return Intl.message(
      'TMPL',
      name: 'app_setting_database_import_data_button_template',
      desc: '',
      args: [],
    );
  }

  /// `Import failed. Please download the wrong data, modify it and try again.`
  String get app_setting_database_import_data_toast_error {
    return Intl.message(
      'Import failed. Please download the wrong data, modify it and try again.',
      name: 'app_setting_database_import_data_toast_error',
      desc: '',
      args: [],
    );
  }

  /// `Import succeeded`
  String get app_setting_database_import_data_toast_success {
    return Intl.message(
      'Import succeeded',
      name: 'app_setting_database_import_data_toast_success',
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

  /// `Appearance`
  String get app_setting_theme_appearance {
    return Intl.message(
      'Appearance',
      name: 'app_setting_theme_appearance',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get app_setting_theme_appearance_system {
    return Intl.message(
      'System',
      name: 'app_setting_theme_appearance_system',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get app_setting_theme_appearance_light {
    return Intl.message(
      'Light',
      name: 'app_setting_theme_appearance_light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get app_setting_theme_appearance_dark {
    return Intl.message(
      'Dark',
      name: 'app_setting_theme_appearance_dark',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get app_setting_theme_themes {
    return Intl.message(
      'Themes',
      name: 'app_setting_theme_themes',
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

  /// `System`
  String get app_setting_language_system {
    return Intl.message(
      'System',
      name: 'app_setting_language_system',
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

  /// `Managing thoughts`
  String get onboarding_title_1 {
    return Intl.message(
      'Managing thoughts',
      name: 'onboarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Release all your feelings`
  String get onboarding_content_1_1 {
    return Intl.message(
      'Release all your feelings',
      name: 'onboarding_content_1_1',
      desc: '',
      args: [],
    );
  }

  /// `Easily record what you see and think every moment`
  String get onboarding_content_1_2 {
    return Intl.message(
      'Easily record what you see and think every moment',
      name: 'onboarding_content_1_2',
      desc: '',
      args: [],
    );
  }

  /// `Careful statistics`
  String get onboarding_title_2 {
    return Intl.message(
      'Careful statistics',
      name: 'onboarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Count your joys and sorrows`
  String get onboarding_content_2_1 {
    return Intl.message(
      'Count your joys and sorrows',
      name: 'onboarding_content_2_1',
      desc: '',
      args: [],
    );
  }

  /// `Let you know your mental activity`
  String get onboarding_content_2_2 {
    return Intl.message(
      'Let you know your mental activity',
      name: 'onboarding_content_2_2',
      desc: '',
      args: [],
    );
  }

  /// `Start now`
  String get onboarding_title_3 {
    return Intl.message(
      'Start now',
      name: 'onboarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Start recording a better version of yourself now`
  String get onboarding_content_3_1 {
    return Intl.message(
      'Start recording a better version of yourself now',
      name: 'onboarding_content_3_1',
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

  /// `How are you feeling now`
  String get home_moodChoice_title {
    return Intl.message(
      'How are you feeling now',
      name: 'home_moodChoice_title',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get home_upgrade_title {
    return Intl.message(
      'Upgrade',
      name: 'home_upgrade_title',
      desc: '',
      args: [],
    );
  }

  /// `Learn the latest\nusage scenarios`
  String get home_upgrade_content {
    return Intl.message(
      'Learn the latest\nusage scenarios',
      name: 'home_upgrade_content',
      desc: '',
      args: [],
    );
  }

  /// `Look`
  String get home_upgrade_button {
    return Intl.message(
      'Look',
      name: 'home_upgrade_button',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get home_help_title {
    return Intl.message(
      'Help',
      name: 'home_help_title',
      desc: '',
      args: [],
    );
  }

  /// `Self-growth`
  String get home_help_article_title_1 {
    return Intl.message(
      'Self-growth',
      name: 'home_help_article_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Cognitive and conscious processes produce attitudes towards external things...`
  String get home_help_article_content_1 {
    return Intl.message(
      'Cognitive and conscious processes produce attitudes towards external things...',
      name: 'home_help_article_content_1',
      desc: '',
      args: [],
    );
  }

  /// `Emotion management`
  String get home_help_article_title_2 {
    return Intl.message(
      'Emotion management',
      name: 'home_help_article_title_2',
      desc: '',
      args: [],
    );
  }

  /// `How to better manage your emotions...`
  String get home_help_article_content_2 {
    return Intl.message(
      'How to better manage your emotions...',
      name: 'home_help_article_content_2',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get mood_title {
    return Intl.message(
      'Mood',
      name: 'mood_title',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get mood_add_button {
    return Intl.message(
      'Add',
      name: 'mood_add_button',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion?`
  String get mood_data_delete_button_title {
    return Intl.message(
      'Confirm deletion?',
      name: 'mood_data_delete_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Cannot recover after deletion`
  String get mood_data_delete_button_content {
    return Intl.message(
      'Cannot recover after deletion',
      name: 'mood_data_delete_button_content',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get mood_data_delete_button_cancel {
    return Intl.message(
      'Cancel',
      name: 'mood_data_delete_button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get mood_data_delete_button_confirm {
    return Intl.message(
      'Delete',
      name: 'mood_data_delete_button_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Nothing there`
  String get mood_data_content_empty {
    return Intl.message(
      'Nothing there',
      name: 'mood_data_content_empty',
      desc: '',
      args: [],
    );
  }

  /// `Mood level`
  String get mood_data_score_title {
    return Intl.message(
      'Mood level',
      name: 'mood_data_score_title',
      desc: '',
      args: [],
    );
  }

  /// `How are you feeling now`
  String get mood_category_select_title_1 {
    return Intl.message(
      'How are you feeling now',
      name: 'mood_category_select_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Change your mood?`
  String get mood_category_select_title_2 {
    return Intl.message(
      'Change your mood?',
      name: 'mood_category_select_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Tell me, what happened?`
  String get mood_content_hintText {
    return Intl.message(
      'Tell me, what happened?',
      name: 'mood_content_hintText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm closing?`
  String get mood_content_close_button_title {
    return Intl.message(
      'Confirm closing?',
      name: 'mood_content_close_button_title',
      desc: '',
      args: [],
    );
  }

  /// `The content will not be saved`
  String get mood_content_close_button_content {
    return Intl.message(
      'The content will not be saved',
      name: 'mood_content_close_button_content',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get mood_content_close_button_cancel {
    return Intl.message(
      'Cancel',
      name: 'mood_content_close_button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get mood_content_close_button_confirm {
    return Intl.message(
      'Confirm',
      name: 'mood_content_close_button_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Statistic`
  String get statistic_title {
    return Intl.message(
      'Statistic',
      name: 'statistic_title',
      desc: '',
      args: [],
    );
  }

  /// `7d`
  String get statistic_filter_7d {
    return Intl.message(
      '7d',
      name: 'statistic_filter_7d',
      desc: '',
      args: [],
    );
  }

  /// `15d`
  String get statistic_filter_15d {
    return Intl.message(
      '15d',
      name: 'statistic_filter_15d',
      desc: '',
      args: [],
    );
  }

  /// `30d`
  String get statistic_filter_30d {
    return Intl.message(
      '30d',
      name: 'statistic_filter_30d',
      desc: '',
      args: [],
    );
  }

  /// `{daysCount} days`
  String statistic_overall_daysCount_title(Object daysCount) {
    return Intl.message(
      '$daysCount days',
      name: 'statistic_overall_daysCount_title',
      desc: '',
      args: [daysCount],
    );
  }

  /// `Cumulative\nrecord days`
  String get statistic_overall_daysCount_subTitle {
    return Intl.message(
      'Cumulative\nrecord days',
      name: 'statistic_overall_daysCount_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `{moodCount} mood`
  String statistic_overall_moodCount_title(Object moodCount) {
    return Intl.message(
      '$moodCount mood',
      name: 'statistic_overall_moodCount_title',
      desc: '',
      args: [moodCount],
    );
  }

  /// `Cumulative\nrecord mood`
  String get statistic_overall_moodCount_subTitle {
    return Intl.message(
      'Cumulative\nrecord mood',
      name: 'statistic_overall_moodCount_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `{moodScoreAverage}`
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return Intl.message(
      '$moodScoreAverage',
      name: 'statistic_overall_moodScoreAverage_title',
      desc: '',
      args: [moodScoreAverage],
    );
  }

  /// `Average\ntotal score`
  String get statistic_overall_moodScoreAverage_subTitle {
    return Intl.message(
      'Average\ntotal score',
      name: 'statistic_overall_moodScoreAverage_subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Average {moodScoreAverage}`
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return Intl.message(
      'Average $moodScoreAverage',
      name: 'statistic_moodScoreAverage_title',
      desc: '',
      args: [moodScoreAverage],
    );
  }

  /// `Mood swings are calculated on a {moodDays}-day basis`
  String statistic_moodScoreAverage_content(Object moodDays) {
    return Intl.message(
      'Mood swings are calculated on a $moodDays-day basis',
      name: 'statistic_moodScoreAverage_content',
      desc: '',
      args: [moodDays],
    );
  }

  /// `Mood swings`
  String get statistic_moodScore_title {
    return Intl.message(
      'Mood swings',
      name: 'statistic_moodScore_title',
      desc: '',
      args: [],
    );
  }

  /// `Mood swings in recent {moodDays} days`
  String statistic_moodScore_content(Object moodDays) {
    return Intl.message(
      'Mood swings in recent $moodDays days',
      name: 'statistic_moodScore_content',
      desc: '',
      args: [moodDays],
    );
  }

  /// `Mood statistics`
  String get statistic_moodStatistics_title {
    return Intl.message(
      'Mood statistics',
      name: 'statistic_moodStatistics_title',
      desc: '',
      args: [],
    );
  }

  /// `Statistics of mood in recent {moodDays} days`
  String statistic_moodStatistics_content(Object moodDays) {
    return Intl.message(
      'Statistics of mood in recent $moodDays days',
      name: 'statistic_moodStatistics_content',
      desc: '',
      args: [moodDays],
    );
  }

  /// `Press again to exit`
  String get widgets_will_pop_scope_route_toast {
    return Intl.message(
      'Press again to exit',
      name: 'widgets_will_pop_scope_route_toast',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get web_view_loading_text {
    return Intl.message(
      'Loading',
      name: 'web_view_loading_text',
      desc: 'WebView加载文字',
      args: [],
    );
  }

  /// `👋 Hi`
  String get local_notification_welcome_title {
    return Intl.message(
      '👋 Hi',
      name: 'local_notification_welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Send you a notification that the notification has been initialized.`
  String get local_notification_welcome_body {
    return Intl.message(
      'Send you a notification that the notification has been initialized.',
      name: 'local_notification_welcome_body',
      desc: '',
      args: [],
    );
  }

  /// `Notification Click`
  String get local_notification_dialog_welcome_title {
    return Intl.message(
      'Notification Click',
      name: 'local_notification_dialog_welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `payload: {payload}`
  String local_notification_dialog_welcome_content(Object payload) {
    return Intl.message(
      'payload: $payload',
      name: 'local_notification_dialog_welcome_content',
      desc: '',
      args: [payload],
    );
  }

  /// `OK`
  String get local_notification_dialog_welcome_ok {
    return Intl.message(
      'OK',
      name: 'local_notification_dialog_welcome_ok',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get local_notification_mood_title {
    return Intl.message(
      'Hi',
      name: 'local_notification_mood_title',
      desc: '',
      args: [],
    );
  }

  /// `If you click this notification, a schedule notification will be notified in 5 seconds.`
  String get local_notification_mood_body {
    return Intl.message(
      'If you click this notification, a schedule notification will be notified in 5 seconds.',
      name: 'local_notification_mood_body',
      desc: '',
      args: [],
    );
  }

  /// `Hi~ I am a scheduled notification`
  String get local_notification_schedule_mood_title {
    return Intl.message(
      'Hi~ I am a scheduled notification',
      name: 'local_notification_schedule_mood_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get local_notification_schedule_mood_body {
    return Intl.message(
      '',
      name: 'local_notification_schedule_mood_body',
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
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
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
