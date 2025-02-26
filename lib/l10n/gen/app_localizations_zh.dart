// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppL10nZh extends AppL10n {
  AppL10nZh([String locale = 'zh']) : super(locale);

  @override
  String get app_bottomNavigationBar_title_home => '首页';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '统计';

  @override
  String get app_setting_database => '数据';

  @override
  String get app_setting_database_export_data => '导出数据';

  @override
  String get app_setting_database_export_data_toast_success => '导出成功';

  @override
  String get app_setting_database_import_data => '导入数据';

  @override
  String get app_setting_database_import_data_button_error => '错误';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '导入失败，请下载错误数据，修改后再试。';

  @override
  String get app_setting_database_import_data_toast_success => '导入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打开应用时需要进行解锁。';

  @override
  String get app_setting_security_lock => '密码锁';

  @override
  String get app_setting_security_biometric_weak => '指纹、面部等识别';

  @override
  String get app_setting_security_biometric_iris => '虹膜识别';

  @override
  String get app_setting_security_biometric_face => '面部识别';

  @override
  String get app_setting_security_biometric_fingerprint => '指纹识别';

  @override
  String get app_setting_security_lock_title_1 => '设置密码';

  @override
  String get app_setting_security_lock_title_2 => '再次输入确认密码';

  @override
  String get app_setting_security_lock_cancel => '关闭';

  @override
  String get app_setting_security_lock_resetinput => '重新输入';

  @override
  String get app_setting_security_lock_error_1 => '两次密码不一致';

  @override
  String get app_setting_security_lock_screen_title => '输入密码解锁';

  @override
  String get app_setting_security_localauth_localizedreason => '请进行识别';

  @override
  String get app_setting_security_localauth_signIntitle => '身份认证';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失败多次，请稍后重试';

  @override
  String get app_setting_theme => '主题';

  @override
  String get app_setting_theme_appearance => '主题外观';

  @override
  String get app_setting_theme_appearance_system => '跟随系统';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主题';

  @override
  String get app_setting_language => '语言';

  @override
  String get app_setting_language_system => '跟随系统';

  @override
  String get app_setting_laboratory => '实验室';

  @override
  String get app_setting_about => '关于';

  @override
  String get onboarding_title_1 => '管理思绪';

  @override
  String get onboarding_content_1_1 => '释放你的所有心情';

  @override
  String get onboarding_content_1_2 => '轻松记录你每刻的所见所想';

  @override
  String get onboarding_title_2 => '精心统计';

  @override
  String get onboarding_content_2_1 => '统计你的喜怒哀乐';

  @override
  String get onboarding_content_2_2 => '让你了解自己心理活动状况';

  @override
  String get onboarding_title_3 => '即刻开始';

  @override
  String get onboarding_content_3_1 => '从现在开始记录更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '现在感觉如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用场景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '帮助';

  @override
  String get home_help_article_title_1 => '自我成长';

  @override
  String get home_help_article_content_1 => '认知和意识过程产生对外界事物的态度...';

  @override
  String get home_help_article_title_2 => '情绪管理';

  @override
  String get home_help_article_content_2 => '如何更好地管理自己的情绪...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '记录';

  @override
  String get mood_data_delete_button_title => '确认删除？';

  @override
  String get mood_data_delete_button_content => '删除后无法恢复';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '删除';

  @override
  String get mood_data_content_empty => '什么都没有说';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '现在感觉如何';

  @override
  String get mood_category_select_title_2 => '换一种心情？';

  @override
  String get mood_content_hintText => '跟我说说，发生什么事情？';

  @override
  String get mood_content_close_button_title => '确认关闭？';

  @override
  String get mood_content_close_button_content => '内容不会保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '确认';

  @override
  String get statistic_title => '统计';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累计记录天数';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 条';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累计记录心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波动';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日计算情绪波动';
  }

  @override
  String get statistic_moodScore_title => '情绪波动';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情绪波动';
  }

  @override
  String get statistic_moodStatistics_title => '心情统计';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情数量统计';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加载中';

  @override
  String get local_notification_welcome_title => '👋 欢迎来到这里';

  @override
  String get local_notification_welcome_body => '进入给你发送一条通知，证明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知权限';

  @override
  String get local_notification_dialog_allow_content => '打开权限后通知才会生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往设置';

  @override
  String get local_notification_schedule_title => '📅 定时计划通知';

  @override
  String get local_notification_schedule_body => '每1分钟你将看见此通知';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppL10nZhCn extends AppL10nZh {
  AppL10nZhCn() : super('zh_CN');

  @override
  String get app_bottomNavigationBar_title_home => '首页';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '统计';

  @override
  String get app_setting_database => '数据';

  @override
  String get app_setting_database_export_data => '导出数据';

  @override
  String get app_setting_database_export_data_toast_success => '导出成功';

  @override
  String get app_setting_database_import_data => '导入数据';

  @override
  String get app_setting_database_import_data_button_error => '错误';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '导入失败，请下载错误数据，修改后再试。';

  @override
  String get app_setting_database_import_data_toast_success => '导入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打开应用时需要进行解锁。';

  @override
  String get app_setting_security_lock => '密码锁';

  @override
  String get app_setting_security_biometric_weak => '指纹、面部等识别';

  @override
  String get app_setting_security_biometric_iris => '虹膜识别';

  @override
  String get app_setting_security_biometric_face => '面部识别';

  @override
  String get app_setting_security_biometric_fingerprint => '指纹识别';

  @override
  String get app_setting_security_lock_title_1 => '设置密码';

  @override
  String get app_setting_security_lock_title_2 => '再次输入确认密码';

  @override
  String get app_setting_security_lock_cancel => '关闭';

  @override
  String get app_setting_security_lock_resetinput => '重新输入';

  @override
  String get app_setting_security_lock_error_1 => '两次密码不一致';

  @override
  String get app_setting_security_lock_screen_title => '输入密码解锁';

  @override
  String get app_setting_security_localauth_localizedreason => '请进行识别';

  @override
  String get app_setting_security_localauth_signIntitle => '身份认证';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失败多次，请稍后重试';

  @override
  String get app_setting_theme => '主题';

  @override
  String get app_setting_theme_appearance => '主题外观';

  @override
  String get app_setting_theme_appearance_system => '跟随系统';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主题';

  @override
  String get app_setting_language => '语言';

  @override
  String get app_setting_language_system => '跟随系统';

  @override
  String get app_setting_laboratory => '实验室';

  @override
  String get app_setting_about => '关于';

  @override
  String get onboarding_title_1 => '管理思绪';

  @override
  String get onboarding_content_1_1 => '释放你的所有心情';

  @override
  String get onboarding_content_1_2 => '轻松记录你每刻的所见所想';

  @override
  String get onboarding_title_2 => '精心统计';

  @override
  String get onboarding_content_2_1 => '统计你的喜怒哀乐';

  @override
  String get onboarding_content_2_2 => '让你了解自己心理活动状况';

  @override
  String get onboarding_title_3 => '即刻开始';

  @override
  String get onboarding_content_3_1 => '从现在开始记录更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '现在感觉如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用场景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '帮助';

  @override
  String get home_help_article_title_1 => '自我成长';

  @override
  String get home_help_article_content_1 => '认知和意识过程产生对外界事物的态度...';

  @override
  String get home_help_article_title_2 => '情绪管理';

  @override
  String get home_help_article_content_2 => '如何更好地管理自己的情绪...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '记录';

  @override
  String get mood_data_delete_button_title => '确认删除？';

  @override
  String get mood_data_delete_button_content => '删除后无法恢复';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '删除';

  @override
  String get mood_data_content_empty => '什么都没有说';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '现在感觉如何';

  @override
  String get mood_category_select_title_2 => '换一种心情？';

  @override
  String get mood_content_hintText => '跟我说说，发生什么事情？';

  @override
  String get mood_content_close_button_title => '确认关闭？';

  @override
  String get mood_content_close_button_content => '内容不会保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '确认';

  @override
  String get statistic_title => '统计';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累计记录天数';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 条';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累计记录心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波动';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日计算情绪波动';
  }

  @override
  String get statistic_moodScore_title => '情绪波动';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情绪波动';
  }

  @override
  String get statistic_moodStatistics_title => '心情统计';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情数量统计';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加载中';

  @override
  String get local_notification_welcome_title => '👋 欢迎来到这里';

  @override
  String get local_notification_welcome_body => '进入给你发送一条通知，证明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知权限';

  @override
  String get local_notification_dialog_allow_content => '打开权限后通知才会生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往设置';

  @override
  String get local_notification_schedule_title => '📅 定时计划通知';

  @override
  String get local_notification_schedule_body => '每1分钟你将看见此通知';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppL10nZhHk extends AppL10nZh {
  AppL10nZhHk() : super('zh_HK');

  @override
  String get app_bottomNavigationBar_title_home => '首頁';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '統計';

  @override
  String get app_setting_database => '數據';

  @override
  String get app_setting_database_export_data => '導出數據';

  @override
  String get app_setting_database_export_data_toast_success => '導出成功';

  @override
  String get app_setting_database_import_data => '導入數據';

  @override
  String get app_setting_database_import_data_button_error => '錯誤';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '導入失敗，請下載錯誤數據，修改後再試。';

  @override
  String get app_setting_database_import_data_toast_success => '導入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打開應用時需要進行解鎖。';

  @override
  String get app_setting_security_lock => '密碼鎖';

  @override
  String get app_setting_security_biometric_weak => '指紋、面部等識別';

  @override
  String get app_setting_security_biometric_iris => '虹膜識別';

  @override
  String get app_setting_security_biometric_face => '面部識別';

  @override
  String get app_setting_security_biometric_fingerprint => '指紋識別';

  @override
  String get app_setting_security_lock_title_1 => '設置密碼';

  @override
  String get app_setting_security_lock_title_2 => '再次輸入確認密碼';

  @override
  String get app_setting_security_lock_cancel => '關閉';

  @override
  String get app_setting_security_lock_resetinput => '重新輸入';

  @override
  String get app_setting_security_lock_error_1 => '兩次密碼不一致';

  @override
  String get app_setting_security_lock_screen_title => '輸入密碼解鎖';

  @override
  String get app_setting_security_localauth_localizedreason => '請進行識別';

  @override
  String get app_setting_security_localauth_signIntitle => '身份認證';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失敗多次，請稍後重試';

  @override
  String get app_setting_theme => '主題';

  @override
  String get app_setting_theme_appearance => '主題外觀';

  @override
  String get app_setting_theme_appearance_system => '跟隨系統';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主題';

  @override
  String get app_setting_language => '語言';

  @override
  String get app_setting_language_system => '跟隨系統';

  @override
  String get app_setting_laboratory => '實驗室';

  @override
  String get app_setting_about => '關於';

  @override
  String get onboarding_title_1 => '管理思緒';

  @override
  String get onboarding_content_1_1 => '釋放你的所有心情';

  @override
  String get onboarding_content_1_2 => '輕鬆記錄你每刻的所見所想';

  @override
  String get onboarding_title_2 => '精心統計';

  @override
  String get onboarding_content_2_1 => '統計你的喜怒哀樂';

  @override
  String get onboarding_content_2_2 => '讓你了解自己心理活動狀況';

  @override
  String get onboarding_title_3 => '即刻開始';

  @override
  String get onboarding_content_3_1 => '從現在開始記錄更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '現在感覺如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用場景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '幫助';

  @override
  String get home_help_article_title_1 => '自我成長';

  @override
  String get home_help_article_content_1 => '認知和意識過程產生對外界事物的態度...';

  @override
  String get home_help_article_title_2 => '情緒管理';

  @override
  String get home_help_article_content_2 => '如何更好地管理自己的情緒...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '記錄';

  @override
  String get mood_data_delete_button_title => '確認刪除？';

  @override
  String get mood_data_delete_button_content => '刪除後無法恢復';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '刪除';

  @override
  String get mood_data_content_empty => '什麼都沒有說';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '現在感覺如何';

  @override
  String get mood_category_select_title_2 => '換一種心情？';

  @override
  String get mood_content_hintText => '跟我說說，發生什麼事情？';

  @override
  String get mood_content_close_button_title => '確認關閉？';

  @override
  String get mood_content_close_button_content => '內容不會保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '確認';

  @override
  String get statistic_title => '統計';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累計記錄天數';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 條';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累計記錄心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波動';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日計算情緒波動';
  }

  @override
  String get statistic_moodScore_title => '情緒波動';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情緒波動';
  }

  @override
  String get statistic_moodStatistics_title => '心情統計';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情數量統計';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加載中';

  @override
  String get local_notification_welcome_title => '👋 歡迎來到這裏';

  @override
  String get local_notification_welcome_body => '進入給你發送一條通知，證明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知權限';

  @override
  String get local_notification_dialog_allow_content => '打開權限後通知才會生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往設置';

  @override
  String get local_notification_schedule_title => '📅 定時計劃通知';

  @override
  String get local_notification_schedule_body => '每1分鐘你將看見此通知';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppL10nZhTw extends AppL10nZh {
  AppL10nZhTw() : super('zh_TW');

  @override
  String get app_bottomNavigationBar_title_home => '首頁';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '統計';

  @override
  String get app_setting_database => '數據';

  @override
  String get app_setting_database_export_data => '導出數據';

  @override
  String get app_setting_database_export_data_toast_success => '導出成功';

  @override
  String get app_setting_database_import_data => '導入數據';

  @override
  String get app_setting_database_import_data_button_error => '錯誤';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '導入失敗，請下載錯誤數據，修改後再試。';

  @override
  String get app_setting_database_import_data_toast_success => '導入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打開應用時需要進行解鎖。';

  @override
  String get app_setting_security_lock => '密碼鎖';

  @override
  String get app_setting_security_biometric_weak => '指紋、面部等識別';

  @override
  String get app_setting_security_biometric_iris => '虹膜識別';

  @override
  String get app_setting_security_biometric_face => '面部識別';

  @override
  String get app_setting_security_biometric_fingerprint => '指紋識別';

  @override
  String get app_setting_security_lock_title_1 => '設置密碼';

  @override
  String get app_setting_security_lock_title_2 => '再次輸入確認密碼';

  @override
  String get app_setting_security_lock_cancel => '關閉';

  @override
  String get app_setting_security_lock_resetinput => '重新輸入';

  @override
  String get app_setting_security_lock_error_1 => '兩次密碼不一致';

  @override
  String get app_setting_security_lock_screen_title => '輸入密碼解鎖';

  @override
  String get app_setting_security_localauth_localizedreason => '請進行識別';

  @override
  String get app_setting_security_localauth_signIntitle => '身份認證';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失敗多次，請稍後重試';

  @override
  String get app_setting_theme => '主題';

  @override
  String get app_setting_theme_appearance => '主題外觀';

  @override
  String get app_setting_theme_appearance_system => '跟隨系統';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主題';

  @override
  String get app_setting_language => '語言';

  @override
  String get app_setting_language_system => '跟隨系統';

  @override
  String get app_setting_laboratory => '實驗室';

  @override
  String get app_setting_about => '關於';

  @override
  String get onboarding_title_1 => '管理思緒';

  @override
  String get onboarding_content_1_1 => '釋放你的所有心情';

  @override
  String get onboarding_content_1_2 => '輕鬆記錄你每刻的所見所想';

  @override
  String get onboarding_title_2 => '精心統計';

  @override
  String get onboarding_content_2_1 => '統計你的喜怒哀樂';

  @override
  String get onboarding_content_2_2 => '讓你了解自己心理活動狀況';

  @override
  String get onboarding_title_3 => '即刻開始';

  @override
  String get onboarding_content_3_1 => '從現在開始記錄更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '現在感覺如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用場景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '幫助';

  @override
  String get home_help_article_title_1 => '自我成長';

  @override
  String get home_help_article_content_1 => '認知和意識過程產生對外界事物的態度...';

  @override
  String get home_help_article_title_2 => '情緒管理';

  @override
  String get home_help_article_content_2 => '如何更好地管理自己的情緒...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '記錄';

  @override
  String get mood_data_delete_button_title => '確認刪除？';

  @override
  String get mood_data_delete_button_content => '刪除後無法恢復';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '刪除';

  @override
  String get mood_data_content_empty => '什麼都沒有說';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '現在感覺如何';

  @override
  String get mood_category_select_title_2 => '換一種心情？';

  @override
  String get mood_content_hintText => '跟我說說，發生什麼事情？';

  @override
  String get mood_content_close_button_title => '確認關閉？';

  @override
  String get mood_content_close_button_content => '內容不會保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '確認';

  @override
  String get statistic_title => '統計';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累計記錄天數';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 條';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累計記錄心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波動';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日計算情緒波動';
  }

  @override
  String get statistic_moodScore_title => '情緒波動';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情緒波動';
  }

  @override
  String get statistic_moodStatistics_title => '心情統計';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情數量統計';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加載中';

  @override
  String get local_notification_welcome_title => '👋 歡迎來到這裡';

  @override
  String get local_notification_welcome_body => '進入給你發送一條通知，證明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知權限';

  @override
  String get local_notification_dialog_allow_content => '打開權限後通知才會生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往設置';

  @override
  String get local_notification_schedule_title => '📅 定時計劃通知';

  @override
  String get local_notification_schedule_body => '每1分鐘你將看見此通知';
}
