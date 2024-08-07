import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW')
  ];

  /// No description provided for @app_bottomNavigationBar_title_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get app_bottomNavigationBar_title_home;

  /// No description provided for @app_bottomNavigationBar_title_mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get app_bottomNavigationBar_title_mood;

  /// No description provided for @app_bottomNavigationBar_title_statistic.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get app_bottomNavigationBar_title_statistic;

  /// No description provided for @app_setting_database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get app_setting_database;

  /// No description provided for @app_setting_database_export_data.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get app_setting_database_export_data;

  /// No description provided for @app_setting_database_export_data_toast_success.
  ///
  /// In en, this message translates to:
  /// **'Export succeeded'**
  String get app_setting_database_export_data_toast_success;

  /// No description provided for @app_setting_database_import_data.
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get app_setting_database_import_data;

  /// No description provided for @app_setting_database_import_data_button_error.
  ///
  /// In en, this message translates to:
  /// **'ERR'**
  String get app_setting_database_import_data_button_error;

  /// No description provided for @app_setting_database_import_data_button_template.
  ///
  /// In en, this message translates to:
  /// **'TMPL'**
  String get app_setting_database_import_data_button_template;

  /// No description provided for @app_setting_database_import_data_toast_error.
  ///
  /// In en, this message translates to:
  /// **'Import failed. Please download the wrong data, modify it and try again.'**
  String get app_setting_database_import_data_toast_error;

  /// No description provided for @app_setting_database_import_data_toast_success.
  ///
  /// In en, this message translates to:
  /// **'Import succeeded'**
  String get app_setting_database_import_data_toast_success;

  /// No description provided for @app_setting_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get app_setting_security;

  /// No description provided for @app_setting_security_content.
  ///
  /// In en, this message translates to:
  /// **'You need to unlock the app when you reopen it.'**
  String get app_setting_security_content;

  /// No description provided for @app_setting_security_lock.
  ///
  /// In en, this message translates to:
  /// **'Security lock'**
  String get app_setting_security_lock;

  /// No description provided for @app_setting_security_biometric_weak.
  ///
  /// In en, this message translates to:
  /// **'TouchID / FaceID auth'**
  String get app_setting_security_biometric_weak;

  /// No description provided for @app_setting_security_biometric_iris.
  ///
  /// In en, this message translates to:
  /// **'Iris auth'**
  String get app_setting_security_biometric_iris;

  /// No description provided for @app_setting_security_biometric_face.
  ///
  /// In en, this message translates to:
  /// **'Face auth'**
  String get app_setting_security_biometric_face;

  /// No description provided for @app_setting_security_biometric_fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint auth'**
  String get app_setting_security_biometric_fingerprint;

  /// No description provided for @app_setting_security_lock_title_1.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get app_setting_security_lock_title_1;

  /// No description provided for @app_setting_security_lock_title_2.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get app_setting_security_lock_title_2;

  /// No description provided for @app_setting_security_lock_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get app_setting_security_lock_cancel;

  /// No description provided for @app_setting_security_lock_resetinput.
  ///
  /// In en, this message translates to:
  /// **'Reset input'**
  String get app_setting_security_lock_resetinput;

  /// No description provided for @app_setting_security_lock_error_1.
  ///
  /// In en, this message translates to:
  /// **'The two passwords are inconsistent'**
  String get app_setting_security_lock_error_1;

  /// No description provided for @app_setting_security_lock_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Security lock'**
  String get app_setting_security_lock_screen_title;

  /// No description provided for @app_setting_security_localauth_localizedreason.
  ///
  /// In en, this message translates to:
  /// **'Please identify'**
  String get app_setting_security_localauth_localizedreason;

  /// No description provided for @app_setting_security_localauth_signIntitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get app_setting_security_localauth_signIntitle;

  /// No description provided for @app_setting_security_localauth_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get app_setting_security_localauth_cancel;

  /// No description provided for @app_setting_security_localauth_error_1.
  ///
  /// In en, this message translates to:
  /// **'You have failed many times, please try again later'**
  String get app_setting_security_localauth_error_1;

  /// No description provided for @app_setting_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get app_setting_theme;

  /// No description provided for @app_setting_theme_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get app_setting_theme_appearance;

  /// No description provided for @app_setting_theme_appearance_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get app_setting_theme_appearance_system;

  /// No description provided for @app_setting_theme_appearance_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get app_setting_theme_appearance_light;

  /// No description provided for @app_setting_theme_appearance_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get app_setting_theme_appearance_dark;

  /// No description provided for @app_setting_theme_themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get app_setting_theme_themes;

  /// No description provided for @app_setting_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get app_setting_language;

  /// No description provided for @app_setting_language_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get app_setting_language_system;

  /// No description provided for @app_setting_laboratory.
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get app_setting_laboratory;

  /// No description provided for @app_setting_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get app_setting_about;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Managing thoughts'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_content_1_1.
  ///
  /// In en, this message translates to:
  /// **'Release all your feelings'**
  String get onboarding_content_1_1;

  /// No description provided for @onboarding_content_1_2.
  ///
  /// In en, this message translates to:
  /// **'Easily record what you see and think every moment'**
  String get onboarding_content_1_2;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Careful statistics'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_content_2_1.
  ///
  /// In en, this message translates to:
  /// **'Count your joys and sorrows'**
  String get onboarding_content_2_1;

  /// No description provided for @onboarding_content_2_2.
  ///
  /// In en, this message translates to:
  /// **'Let you know your mental activity'**
  String get onboarding_content_2_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_content_3_1.
  ///
  /// In en, this message translates to:
  /// **'Start recording a better version of yourself now'**
  String get onboarding_content_3_1;

  /// No description provided for @home_hi.
  ///
  /// In en, this message translates to:
  /// **'Hi~'**
  String get home_hi;

  /// No description provided for @home_moodChoice_title.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling now'**
  String get home_moodChoice_title;

  /// No description provided for @home_upgrade_title.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get home_upgrade_title;

  /// No description provided for @home_upgrade_content.
  ///
  /// In en, this message translates to:
  /// **'Learn the latest\nusage scenarios'**
  String get home_upgrade_content;

  /// No description provided for @home_upgrade_button.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get home_upgrade_button;

  /// No description provided for @home_help_title.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get home_help_title;

  /// No description provided for @home_help_article_title_1.
  ///
  /// In en, this message translates to:
  /// **'Self-growth'**
  String get home_help_article_title_1;

  /// No description provided for @home_help_article_content_1.
  ///
  /// In en, this message translates to:
  /// **'Cognitive and conscious processes produce attitudes towards external things...'**
  String get home_help_article_content_1;

  /// No description provided for @home_help_article_title_2.
  ///
  /// In en, this message translates to:
  /// **'Emotion management'**
  String get home_help_article_title_2;

  /// No description provided for @home_help_article_content_2.
  ///
  /// In en, this message translates to:
  /// **'How to better manage your emotions...'**
  String get home_help_article_content_2;

  /// No description provided for @mood_title.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood_title;

  /// No description provided for @mood_add_button.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get mood_add_button;

  /// No description provided for @mood_data_delete_button_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deletion?'**
  String get mood_data_delete_button_title;

  /// No description provided for @mood_data_delete_button_content.
  ///
  /// In en, this message translates to:
  /// **'Cannot recover after deletion'**
  String get mood_data_delete_button_content;

  /// No description provided for @mood_data_delete_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mood_data_delete_button_cancel;

  /// No description provided for @mood_data_delete_button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get mood_data_delete_button_confirm;

  /// No description provided for @mood_data_content_empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing there'**
  String get mood_data_content_empty;

  /// No description provided for @mood_data_score_title.
  ///
  /// In en, this message translates to:
  /// **'Mood level'**
  String get mood_data_score_title;

  /// No description provided for @mood_category_select_title_1.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling now'**
  String get mood_category_select_title_1;

  /// No description provided for @mood_category_select_title_2.
  ///
  /// In en, this message translates to:
  /// **'Change your mood?'**
  String get mood_category_select_title_2;

  /// No description provided for @mood_content_hintText.
  ///
  /// In en, this message translates to:
  /// **'Tell me, what happened?'**
  String get mood_content_hintText;

  /// No description provided for @mood_content_close_button_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm closing?'**
  String get mood_content_close_button_title;

  /// No description provided for @mood_content_close_button_content.
  ///
  /// In en, this message translates to:
  /// **'The content will not be saved'**
  String get mood_content_close_button_content;

  /// No description provided for @mood_content_close_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mood_content_close_button_cancel;

  /// No description provided for @mood_content_close_button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get mood_content_close_button_confirm;

  /// No description provided for @statistic_title.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get statistic_title;

  /// No description provided for @statistic_filter_7d.
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get statistic_filter_7d;

  /// No description provided for @statistic_filter_15d.
  ///
  /// In en, this message translates to:
  /// **'15d'**
  String get statistic_filter_15d;

  /// No description provided for @statistic_filter_30d.
  ///
  /// In en, this message translates to:
  /// **'30d'**
  String get statistic_filter_30d;

  /// No description provided for @statistic_overall_daysCount_title.
  ///
  /// In en, this message translates to:
  /// **'{daysCount} days'**
  String statistic_overall_daysCount_title(Object daysCount);

  /// No description provided for @statistic_overall_daysCount_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative\nrecord days'**
  String get statistic_overall_daysCount_subTitle;

  /// No description provided for @statistic_overall_moodCount_title.
  ///
  /// In en, this message translates to:
  /// **'{moodCount} mood'**
  String statistic_overall_moodCount_title(Object moodCount);

  /// No description provided for @statistic_overall_moodCount_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative\nrecord mood'**
  String get statistic_overall_moodCount_subTitle;

  /// No description provided for @statistic_overall_moodScoreAverage_title.
  ///
  /// In en, this message translates to:
  /// **'{moodScoreAverage}'**
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage);

  /// No description provided for @statistic_overall_moodScoreAverage_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Average\ntotal score'**
  String get statistic_overall_moodScoreAverage_subTitle;

  /// No description provided for @statistic_moodScoreAverage_title.
  ///
  /// In en, this message translates to:
  /// **'Average {moodScoreAverage}'**
  String statistic_moodScoreAverage_title(Object moodScoreAverage);

  /// No description provided for @statistic_moodScoreAverage_content.
  ///
  /// In en, this message translates to:
  /// **'Mood swings are calculated on a {moodDays}-day basis'**
  String statistic_moodScoreAverage_content(Object moodDays);

  /// No description provided for @statistic_moodScore_title.
  ///
  /// In en, this message translates to:
  /// **'Mood swings'**
  String get statistic_moodScore_title;

  /// No description provided for @statistic_moodScore_content.
  ///
  /// In en, this message translates to:
  /// **'Mood swings in recent {moodDays} days'**
  String statistic_moodScore_content(Object moodDays);

  /// No description provided for @statistic_moodStatistics_title.
  ///
  /// In en, this message translates to:
  /// **'Mood statistics'**
  String get statistic_moodStatistics_title;

  /// No description provided for @statistic_moodStatistics_content.
  ///
  /// In en, this message translates to:
  /// **'Statistics of mood in recent {moodDays} days'**
  String statistic_moodStatistics_content(Object moodDays);

  /// No description provided for @widgets_will_pop_scope_route_toast.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit'**
  String get widgets_will_pop_scope_route_toast;

  /// WebView加载文字
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get web_view_loading_text;

  /// No description provided for @local_notification_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'👋 Hi'**
  String get local_notification_welcome_title;

  /// No description provided for @local_notification_welcome_body.
  ///
  /// In en, this message translates to:
  /// **'Send you a notification that the notification has been initialized.'**
  String get local_notification_welcome_body;

  /// No description provided for @local_notification_dialog_allow_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get local_notification_dialog_allow_title;

  /// No description provided for @local_notification_dialog_allow_content.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications?'**
  String get local_notification_dialog_allow_content;

  /// No description provided for @local_notification_dialog_allow_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get local_notification_dialog_allow_cancel;

  /// No description provided for @local_notification_dialog_allow_confirm.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get local_notification_dialog_allow_confirm;

  /// No description provided for @local_notification_schedule_title.
  ///
  /// In en, this message translates to:
  /// **'📅 Scheduling a Notification'**
  String get local_notification_schedule_title;

  /// No description provided for @local_notification_schedule_body.
  ///
  /// In en, this message translates to:
  /// **'Every 1 minute'**
  String get local_notification_schedule_body;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return SZhCn();
          case 'HK':
            return SZhHk();
          case 'TW':
            return SZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
