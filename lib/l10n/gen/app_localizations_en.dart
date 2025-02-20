// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get app_bottomNavigationBar_title_home => 'Home';

  @override
  String get app_bottomNavigationBar_title_mood => 'Mood';

  @override
  String get app_bottomNavigationBar_title_statistic => 'Statistic';

  @override
  String get app_setting_database => 'Database';

  @override
  String get app_setting_database_export_data => 'Export data';

  @override
  String get app_setting_database_export_data_toast_success => 'Export succeeded';

  @override
  String get app_setting_database_import_data => 'Import data';

  @override
  String get app_setting_database_import_data_button_error => 'ERR';

  @override
  String get app_setting_database_import_data_button_template => 'TMPL';

  @override
  String get app_setting_database_import_data_toast_error =>
      'Import failed. Please download the wrong data, modify it and try again.';

  @override
  String get app_setting_database_import_data_toast_success => 'Import succeeded';

  @override
  String get app_setting_security => 'Security';

  @override
  String get app_setting_security_content => 'You need to unlock the app when you reopen it.';

  @override
  String get app_setting_security_lock => 'Security lock';

  @override
  String get app_setting_security_biometric_weak => 'TouchID / FaceID auth';

  @override
  String get app_setting_security_biometric_iris => 'Iris auth';

  @override
  String get app_setting_security_biometric_face => 'Face auth';

  @override
  String get app_setting_security_biometric_fingerprint => 'Fingerprint auth';

  @override
  String get app_setting_security_lock_title_1 => 'Set password';

  @override
  String get app_setting_security_lock_title_2 => 'Confirm password';

  @override
  String get app_setting_security_lock_cancel => 'Cancel';

  @override
  String get app_setting_security_lock_resetinput => 'Reset input';

  @override
  String get app_setting_security_lock_error_1 => 'The two passwords are inconsistent';

  @override
  String get app_setting_security_lock_screen_title => 'Security lock';

  @override
  String get app_setting_security_localauth_localizedreason => 'Please identify';

  @override
  String get app_setting_security_localauth_signIntitle => 'Authentication required';

  @override
  String get app_setting_security_localauth_cancel => 'Cancel';

  @override
  String get app_setting_security_localauth_error_1 =>
      'You have failed many times, please try again later';

  @override
  String get app_setting_theme => 'Theme';

  @override
  String get app_setting_theme_appearance => 'Appearance';

  @override
  String get app_setting_theme_appearance_system => 'System';

  @override
  String get app_setting_theme_appearance_light => 'Light';

  @override
  String get app_setting_theme_appearance_dark => 'Dark';

  @override
  String get app_setting_theme_themes => 'Themes';

  @override
  String get app_setting_language => 'Language';

  @override
  String get app_setting_language_system => 'System';

  @override
  String get app_setting_laboratory => 'Laboratory';

  @override
  String get app_setting_about => 'About';

  @override
  String get onboarding_title_1 => 'Managing thoughts';

  @override
  String get onboarding_content_1_1 => 'Release all your feelings';

  @override
  String get onboarding_content_1_2 => 'Easily record what you see and think every moment';

  @override
  String get onboarding_title_2 => 'Careful statistics';

  @override
  String get onboarding_content_2_1 => 'Count your joys and sorrows';

  @override
  String get onboarding_content_2_2 => 'Let you know your mental activity';

  @override
  String get onboarding_title_3 => 'Start now';

  @override
  String get onboarding_content_3_1 => 'Start recording a better version of yourself now';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => 'How are you feeling now';

  @override
  String get home_upgrade_title => 'Upgrade';

  @override
  String get home_upgrade_content => 'Learn the latest\nusage scenarios';

  @override
  String get home_upgrade_button => 'Read';

  @override
  String get home_help_title => 'Help';

  @override
  String get home_help_article_title_1 => 'Self-growth';

  @override
  String get home_help_article_content_1 =>
      'Cognitive and conscious processes produce attitudes towards external things...';

  @override
  String get home_help_article_title_2 => 'Emotion management';

  @override
  String get home_help_article_content_2 => 'How to better manage your emotions...';

  @override
  String get mood_title => 'Mood';

  @override
  String get mood_add_button => 'Add';

  @override
  String get mood_data_delete_button_title => 'Confirm deletion?';

  @override
  String get mood_data_delete_button_content => 'Cannot recover after deletion';

  @override
  String get mood_data_delete_button_cancel => 'Cancel';

  @override
  String get mood_data_delete_button_confirm => 'Delete';

  @override
  String get mood_data_content_empty => 'Nothing there';

  @override
  String get mood_data_score_title => 'Mood level';

  @override
  String get mood_category_select_title_1 => 'How are you feeling now';

  @override
  String get mood_category_select_title_2 => 'Change your mood?';

  @override
  String get mood_content_hintText => 'Tell me, what happened?';

  @override
  String get mood_content_close_button_title => 'Confirm closing?';

  @override
  String get mood_content_close_button_content => 'The content will not be saved';

  @override
  String get mood_content_close_button_cancel => 'Cancel';

  @override
  String get mood_content_close_button_confirm => 'Confirm';

  @override
  String get statistic_title => 'Statistic';

  @override
  String get statistic_filter_7d => '7d';

  @override
  String get statistic_filter_15d => '15d';

  @override
  String get statistic_filter_30d => '30d';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount days';
  }

  @override
  String get statistic_overall_daysCount_subTitle => 'Cumulative\nrecord days';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount mood';
  }

  @override
  String get statistic_overall_moodCount_subTitle => 'Cumulative\nrecord mood';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => 'Average\ntotal score';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return 'Average $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return 'Mood swings are calculated on a $moodDays-day basis';
  }

  @override
  String get statistic_moodScore_title => 'Mood swings';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return 'Mood swings in recent $moodDays days';
  }

  @override
  String get statistic_moodStatistics_title => 'Mood statistics';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return 'Statistics of mood in recent $moodDays days';
  }

  @override
  String get widgets_will_pop_scope_route_toast => 'Press again to exit';

  @override
  String get web_view_loading_text => 'Loading';

  @override
  String get local_notification_welcome_title => '👋 Hi';

  @override
  String get local_notification_welcome_body =>
      'Send you a notification that the notification has been initialized.';

  @override
  String get local_notification_dialog_allow_title => 'Notifications';

  @override
  String get local_notification_dialog_allow_content => 'Allow Notifications?';

  @override
  String get local_notification_dialog_allow_cancel => 'Cancel';

  @override
  String get local_notification_dialog_allow_confirm => 'Settings';

  @override
  String get local_notification_schedule_title => '📅 Scheduling a Notification';

  @override
  String get local_notification_schedule_body => 'Every 1 minute';
}
