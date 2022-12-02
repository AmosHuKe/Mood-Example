// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(moodDays) =>
      "Mood swings are calculated on a ${moodDays}-day basis";

  static String m1(moodScoreAverage) => "Average ${moodScoreAverage}";

  static String m2(moodDays) => "Mood swings in recent ${moodDays} days";

  static String m3(moodDays) => "Statistics of mood in recent ${moodDays} days";

  static String m4(daysCount) => "${daysCount} days";

  static String m5(moodCount) => "${moodCount} mood";

  static String m6(moodScoreAverage) => "${moodScoreAverage}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_bottomNavigationBar_title_home":
            MessageLookupByLibrary.simpleMessage("Home"),
        "app_bottomNavigationBar_title_mood":
            MessageLookupByLibrary.simpleMessage("Mood"),
        "app_bottomNavigationBar_title_statistic":
            MessageLookupByLibrary.simpleMessage("Statistic"),
        "app_setting_about": MessageLookupByLibrary.simpleMessage("About"),
        "app_setting_database":
            MessageLookupByLibrary.simpleMessage("Database"),
        "app_setting_database_export_data":
            MessageLookupByLibrary.simpleMessage("Export data"),
        "app_setting_database_export_data_toast_success":
            MessageLookupByLibrary.simpleMessage("Export succeeded"),
        "app_setting_database_import_data":
            MessageLookupByLibrary.simpleMessage("Import data"),
        "app_setting_database_import_data_button_error":
            MessageLookupByLibrary.simpleMessage("ERR"),
        "app_setting_database_import_data_button_template":
            MessageLookupByLibrary.simpleMessage("TMPL"),
        "app_setting_database_import_data_toast_error":
            MessageLookupByLibrary.simpleMessage(
                "Import failed. Please download the wrong data, modify it and try again."),
        "app_setting_database_import_data_toast_success":
            MessageLookupByLibrary.simpleMessage("Import succeeded"),
        "app_setting_laboratory":
            MessageLookupByLibrary.simpleMessage("Laboratory"),
        "app_setting_language":
            MessageLookupByLibrary.simpleMessage("Language"),
        "app_setting_language_system":
            MessageLookupByLibrary.simpleMessage("System"),
        "app_setting_security":
            MessageLookupByLibrary.simpleMessage("Security"),
        "app_setting_security_biometric_face":
            MessageLookupByLibrary.simpleMessage("Face auth"),
        "app_setting_security_biometric_fingerprint":
            MessageLookupByLibrary.simpleMessage("Fingerprint auth"),
        "app_setting_security_biometric_iris":
            MessageLookupByLibrary.simpleMessage("Iris auth"),
        "app_setting_security_biometric_weak":
            MessageLookupByLibrary.simpleMessage("TouchID / FaceID auth"),
        "app_setting_security_content": MessageLookupByLibrary.simpleMessage(
            "You need to unlock the app when you reopen it."),
        "app_setting_security_localauth_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "app_setting_security_localauth_error_1":
            MessageLookupByLibrary.simpleMessage(
                "You have failed many times, please try again later"),
        "app_setting_security_localauth_localizedreason":
            MessageLookupByLibrary.simpleMessage("Please identify"),
        "app_setting_security_localauth_signIntitle":
            MessageLookupByLibrary.simpleMessage("Authentication required"),
        "app_setting_security_lock":
            MessageLookupByLibrary.simpleMessage("Security lock"),
        "app_setting_security_lock_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "app_setting_security_lock_error_1":
            MessageLookupByLibrary.simpleMessage(
                "The two passwords are inconsistent"),
        "app_setting_security_lock_resetinput":
            MessageLookupByLibrary.simpleMessage("Reset input"),
        "app_setting_security_lock_screen_title":
            MessageLookupByLibrary.simpleMessage("Security lock"),
        "app_setting_security_lock_title_1":
            MessageLookupByLibrary.simpleMessage("Set password"),
        "app_setting_security_lock_title_2":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "app_setting_theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "app_setting_theme_appearance":
            MessageLookupByLibrary.simpleMessage("Appearance"),
        "app_setting_theme_appearance_dark":
            MessageLookupByLibrary.simpleMessage("Dark"),
        "app_setting_theme_appearance_light":
            MessageLookupByLibrary.simpleMessage("Light"),
        "app_setting_theme_appearance_system":
            MessageLookupByLibrary.simpleMessage("System"),
        "app_setting_theme_themes":
            MessageLookupByLibrary.simpleMessage("Themes"),
        "home_help_article_content_1": MessageLookupByLibrary.simpleMessage(
            "Cognitive and conscious processes produce attitudes towards external things..."),
        "home_help_article_content_2": MessageLookupByLibrary.simpleMessage(
            "How to better manage your emotions..."),
        "home_help_article_title_1":
            MessageLookupByLibrary.simpleMessage("Self-growth"),
        "home_help_article_title_2":
            MessageLookupByLibrary.simpleMessage("Emotion management"),
        "home_help_title": MessageLookupByLibrary.simpleMessage("Help"),
        "home_hi": MessageLookupByLibrary.simpleMessage("Hi~"),
        "home_moodChoice_title":
            MessageLookupByLibrary.simpleMessage("How are you feeling now"),
        "home_upgrade_button": MessageLookupByLibrary.simpleMessage("Look"),
        "home_upgrade_content": MessageLookupByLibrary.simpleMessage(
            "Learn the latest\nusage scenarios"),
        "home_upgrade_title": MessageLookupByLibrary.simpleMessage("Upgrade"),
        "local_notification_dialog_allow_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "local_notification_dialog_allow_confirm":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "local_notification_dialog_allow_content":
            MessageLookupByLibrary.simpleMessage("Allow Notifications?"),
        "local_notification_dialog_allow_title":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "local_notification_schedule_body":
            MessageLookupByLibrary.simpleMessage("Every 1 minute"),
        "local_notification_schedule_title":
            MessageLookupByLibrary.simpleMessage(
                "📅 Scheduling a Notification"),
        "local_notification_welcome_body": MessageLookupByLibrary.simpleMessage(
            "Send you a notification that the notification has been initialized."),
        "local_notification_welcome_title":
            MessageLookupByLibrary.simpleMessage("👋 Hi"),
        "mood_add_button": MessageLookupByLibrary.simpleMessage("Add"),
        "mood_category_select_title_1":
            MessageLookupByLibrary.simpleMessage("How are you feeling now"),
        "mood_category_select_title_2":
            MessageLookupByLibrary.simpleMessage("Change your mood?"),
        "mood_content_close_button_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "mood_content_close_button_confirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "mood_content_close_button_content":
            MessageLookupByLibrary.simpleMessage(
                "The content will not be saved"),
        "mood_content_close_button_title":
            MessageLookupByLibrary.simpleMessage("Confirm closing?"),
        "mood_content_hintText":
            MessageLookupByLibrary.simpleMessage("Tell me, what happened?"),
        "mood_data_content_empty":
            MessageLookupByLibrary.simpleMessage("Nothing there"),
        "mood_data_delete_button_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "mood_data_delete_button_confirm":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "mood_data_delete_button_content": MessageLookupByLibrary.simpleMessage(
            "Cannot recover after deletion"),
        "mood_data_delete_button_title":
            MessageLookupByLibrary.simpleMessage("Confirm deletion?"),
        "mood_data_score_title":
            MessageLookupByLibrary.simpleMessage("Mood level"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Mood"),
        "onboarding_content_1_1":
            MessageLookupByLibrary.simpleMessage("Release all your feelings"),
        "onboarding_content_1_2": MessageLookupByLibrary.simpleMessage(
            "Easily record what you see and think every moment"),
        "onboarding_content_2_1":
            MessageLookupByLibrary.simpleMessage("Count your joys and sorrows"),
        "onboarding_content_2_2": MessageLookupByLibrary.simpleMessage(
            "Let you know your mental activity"),
        "onboarding_content_3_1": MessageLookupByLibrary.simpleMessage(
            "Start recording a better version of yourself now"),
        "onboarding_title_1":
            MessageLookupByLibrary.simpleMessage("Managing thoughts"),
        "onboarding_title_2":
            MessageLookupByLibrary.simpleMessage("Careful statistics"),
        "onboarding_title_3": MessageLookupByLibrary.simpleMessage("Start now"),
        "statistic_filter_15d": MessageLookupByLibrary.simpleMessage("15d"),
        "statistic_filter_30d": MessageLookupByLibrary.simpleMessage("30d"),
        "statistic_filter_7d": MessageLookupByLibrary.simpleMessage("7d"),
        "statistic_moodScoreAverage_content": m0,
        "statistic_moodScoreAverage_title": m1,
        "statistic_moodScore_content": m2,
        "statistic_moodScore_title":
            MessageLookupByLibrary.simpleMessage("Mood swings"),
        "statistic_moodStatistics_content": m3,
        "statistic_moodStatistics_title":
            MessageLookupByLibrary.simpleMessage("Mood statistics"),
        "statistic_overall_daysCount_subTitle":
            MessageLookupByLibrary.simpleMessage("Cumulative\nrecord days"),
        "statistic_overall_daysCount_title": m4,
        "statistic_overall_moodCount_subTitle":
            MessageLookupByLibrary.simpleMessage("Cumulative\nrecord mood"),
        "statistic_overall_moodCount_title": m5,
        "statistic_overall_moodScoreAverage_subTitle":
            MessageLookupByLibrary.simpleMessage("Average\ntotal score"),
        "statistic_overall_moodScoreAverage_title": m6,
        "statistic_title": MessageLookupByLibrary.simpleMessage("Statistic"),
        "web_view_loading_text":
            MessageLookupByLibrary.simpleMessage("Loading"),
        "widgets_will_pop_scope_route_toast":
            MessageLookupByLibrary.simpleMessage("Press again to exit")
      };
}
