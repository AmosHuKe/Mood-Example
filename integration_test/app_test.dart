import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:moodexample/generated/l10n.dart';

import 'package:moodexample/main.dart' as app;

import 'package:moodexample/config/language.dart';
import 'package:moodexample/config/multiple_themes.dart';

void main() {
  /// 集成测试环境的初始化
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('基础操作测试', () {
    testWidgets('切换底部菜单 Tab', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder widgetTabHome = find.byKey(const Key('tab_home'));
      final Finder widgetTabMood = find.byKey(const Key('tab_mood'));
      final Finder widgetTabStatistic = find.byKey(const Key('tab_statistic'));
      final Finder notificationRationaleDialog =
          find.byKey(const Key('notification_rationale_dialog'));
      final Finder notificationRationaleOK =
          find.byKey(const Key('notification_rationale_ok'));
      final Finder notificationRationaleClose =
          find.byKey(const Key('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
      }
      await tester.pumpAndSettle();

      /// 检查菜单是否存在
      expect(widgetTabHome, findsOneWidget);
      expect(widgetTabMood, findsOneWidget);
      expect(widgetTabStatistic, findsOneWidget);

      /// 测试点击
      await tester.tap(widgetTabHome);
      await tester.pumpAndSettle();
      await tester.tap(widgetTabMood);
      await tester.pumpAndSettle();
      await tester.tap(widgetTabStatistic);
      await tester.pumpAndSettle();
      await tester.tap(widgetTabHome);
      await tester.pumpAndSettle();
    });

    testWidgets('侧栏基础操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      final BuildContext context =
          tester.element(find.byKey(const Key('widget_menu_page')));
      final i18n = S.of(context);

      final List appMultipleThemesModeKey = [];
      final List language = [];
      final Finder widgetTabScreenLeft =
          find.byKey(const Key('tab_screen_left'));
      final Finder widgetMoveModalBottomSheet =
          find.byKey(const Key('widget_move_modal_bottom_sheet'));
      final Finder widgetLaboratoryPage =
          find.byKey(const Key('widget_laboratory_page'));
      final Finder widgetLaboratoryBackButton =
          find.byKey(const Key('widget_laboratory_back_button'));
      final Finder widgetMenuScreenLeftLogo =
          find.byKey(const Key('widget_menu_screen_left_logo'));
      final Finder widgetWebViewClose =
          find.byKey(const Key('widget_web_view_close'));
      final Finder textData = find.text(i18n.app_setting_database);
      final Finder textDataExport =
          find.text(i18n.app_setting_database_export_data);
      final Finder textDataImport =
          find.text(i18n.app_setting_database_import_data);
      final Finder textSecurity = find.text(i18n.app_setting_security);
      final Finder textTheme = find.text(i18n.app_setting_theme);
      final Finder textThemeSetting =
          find.text(i18n.app_setting_theme_appearance);
      final Finder textThemeSettingSystem =
          find.text(i18n.app_setting_theme_appearance_system);
      final Finder textThemeSettingLight =
          find.text(i18n.app_setting_theme_appearance_light);
      final Finder textThemeSettingDark =
          find.text(i18n.app_setting_theme_appearance_dark);
      final Finder textLanguage = find.text(i18n.app_setting_language);
      final Finder textLanguageChinese = find.text('简体中文');
      final Finder textLanguageEnglish = find.text('English');
      final Finder textLanguageSystem = find.text('System');
      final Finder textLaboratory = find.text(i18n.app_setting_laboratory);
      final Finder textAbout = find.text(i18n.app_setting_about);
      final Finder notificationRationaleDialog =
          find.byKey(const Key('notification_rationale_dialog'));
      final Finder notificationRationaleOK =
          find.byKey(const Key('notification_rationale_ok'));
      final Finder notificationRationaleClose =
          find.byKey(const Key('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
      }
      await tester.pumpAndSettle();

      /// 打开侧栏
      expect(widgetTabScreenLeft, findsOneWidget);
      await tester.tap(widgetTabScreenLeft);
      await tester.pumpAndSettle();
      expect(textAbout, findsOneWidget);

      /// 数据操作
      expect(textData, findsOneWidget);
      await tester.tap(textData);
      await tester.pumpAndSettle();
      expect(textDataExport, findsOneWidget);
      expect(textDataImport, findsOneWidget);
      await tester.tap(textDataImport);
      await tester.pumpAndSettle();
      await tester.tap(textDataExport);

      await tester.fling(
        widgetMoveModalBottomSheet,
        const Offset(0, 400),
        2400.0,
      );
      await tester.pumpAndSettle();

      /// 安全操作
      expect(textSecurity, findsOneWidget);
      await tester.tap(textSecurity);
      await tester.pumpAndSettle();

      await tester.fling(
        widgetMoveModalBottomSheet,
        const Offset(0, 400),
        2400.0,
      );
      await tester.pumpAndSettle();

      /// 主题操作
      expect(textTheme, findsOneWidget);
      await tester.tap(textTheme);
      await tester.pumpAndSettle();
      expect(textThemeSetting, findsOneWidget);

      appMultipleThemesMode
          .forEach((key, value) => appMultipleThemesModeKey.add(key));

      await tester.tap(textThemeSettingLight);
      await tester.pumpAndSettle();
      await Future.forEach(appMultipleThemesModeKey, (key) async {
        await tester.tap(find.byKey(Key('widget_multiple_themes_card_$key')));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingDark);
      await tester.pumpAndSettle();
      await Future.forEach(appMultipleThemesModeKey, (key) async {
        await tester.tap(find.byKey(Key('widget_multiple_themes_card_$key')));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingSystem);
      await tester.pumpAndSettle();
      await tester
          .tap(find.byKey(const Key('widget_multiple_themes_card_default')));

      await tester.fling(
        widgetMoveModalBottomSheet,
        const Offset(0, 400),
        2400.0,
      );
      await tester.pumpAndSettle();

      /// 语言操作
      expect(textLanguage, findsOneWidget);
      await tester.tap(textLanguage);
      await tester.pumpAndSettle();

      for (final element in languageConfig) {
        language.add(element.language);
      }

      await Future.forEach(language, (e) async {
        await tester.tap(find.text(e.toString()));
        await tester.pumpAndSettle();
      });

      await tester.tap(textLanguageEnglish);
      await tester.pumpAndSettle();
      expect(textLanguageSystem, findsOneWidget);
      await tester.tap(textLanguageSystem);
      await tester.pumpAndSettle();
      expect(textLanguageChinese, findsOneWidget);

      await tester.fling(
        widgetMoveModalBottomSheet,
        const Offset(0, 400),
        2400.0,
      );
      await tester.pumpAndSettle();

      /// 实验室操作
      expect(textLaboratory, findsOneWidget);
      await tester.tap(textLaboratory);
      await tester.pumpAndSettle();
      expect(textLaboratory, findsOneWidget);
      await tester.fling(widgetLaboratoryPage, const Offset(0, -400), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetLaboratoryPage, const Offset(0, 400), 2400.0);
      await tester.pumpAndSettle();
      await tester.tap(widgetLaboratoryBackButton);
      await tester.pumpAndSettle();

      /// 关于操作
      expect(textAbout, findsOneWidget);
      await tester.tap(textAbout);
      await tester.pumpAndSettle();
      expect(widgetWebViewClose, findsOneWidget);
      await tester.tap(widgetWebViewClose);
      await tester.pumpAndSettle();

      /// 侧栏关闭
      await tester.tap(widgetMenuScreenLeftLogo);
      await tester.pumpAndSettle();
    });

    testWidgets('首页基础操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      final BuildContext context =
          tester.element(find.byKey(const Key('widget_menu_page')));
      final i18n = S.of(context);

      // Finder widgetHomeBody = find.byKey(const Key("widget_home_body"));
      final Finder widgetTabHome = find.byKey(const Key('tab_home'));
      final Finder widgetOptionMood =
          find.byKey(const Key('widget_option_mood'));
      final Finder widgetActionButtonClose =
          find.byKey(const Key('widget_action_button_close'));
      final Finder widgetNextButton =
          find.byKey(const Key('widget_next_button'));
      final Finder widgetWebViewClose =
          find.byKey(const Key('widget_web_view_close'));
      final Finder widgetHomeArticle1 =
          find.byKey(const Key('widget_home_article_1'));
      final Finder widgetHomeArticle2 =
          find.byKey(const Key('widget_home_article_2'));
      final Finder textHi = find.text(i18n.home_hi);
      final Finder textHelp = find.text(i18n.home_help_title);
      final Finder textHappy = find.text('开心');
      final Finder textAngry = find.text('生气');
      final Finder textOK = find.text(i18n.mood_content_close_button_confirm);
      final Finder textLook = find.text(i18n.home_upgrade_button);
      final Finder textGLSX = find.text(i18n.onboarding_title_1);
      final Finder textJXTJ = find.text(i18n.onboarding_title_2);
      final Finder textJKKS = find.text(i18n.onboarding_title_3);
      final Finder notificationRationaleDialog =
          find.byKey(const Key('notification_rationale_dialog'));
      final Finder notificationRationaleOK =
          find.byKey(const Key('notification_rationale_ok'));
      final Finder notificationRationaleClose =
          find.byKey(const Key('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
      }
      await tester.pumpAndSettle();

      /// 切换到首页，滑动验证内容存在
      await tester.tap(widgetTabHome);
      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);
      await tester.fling(textHelp, const Offset(0, -400), 2400.0);
      await tester.pumpAndSettle();
      expect(textHelp, findsOneWidget);
      await tester.fling(textHelp, const Offset(0, 400), 2400.0);
      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);

      /// 心情操作卡片，首尾滑动触发操作
      expect(textHappy, findsWidgets);
      await tester.tap(textHappy);
      await tester.pumpAndSettle();
      expect(textHappy, findsWidgets);
      await tester.tap(widgetActionButtonClose);
      await tester.pumpAndSettle();
      await tester.tap(textOK);

      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);
      await tester.fling(widgetOptionMood, const Offset(-400, 0), 2400.0);
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.tap(textAngry);
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.tap(widgetActionButtonClose);
      await tester.pumpAndSettle();
      await tester.tap(textOK);

      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);
      await tester.fling(widgetOptionMood, const Offset(400, 0), 2400.0);
      await tester.pumpAndSettle();
      expect(textHappy, findsOneWidget);

      /// 通知内容操作
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.tap(textLook);
      await tester.pumpAndSettle();
      expect(textGLSX, findsOneWidget);
      await tester.tap(widgetNextButton);
      await tester.pumpAndSettle();
      expect(textJXTJ, findsOneWidget);
      await tester.tap(widgetNextButton);
      await tester.pumpAndSettle();
      expect(textJKKS, findsOneWidget);
      await tester.tap(widgetNextButton);
      await tester.pumpAndSettle();

      /// 帮助文章操作
      await tester.fling(textHelp, const Offset(0, -400), 2400.0);
      await tester.pumpAndSettle();
      expect(widgetHomeArticle1, findsOneWidget);
      expect(widgetHomeArticle2, findsOneWidget);
      await tester.tap(widgetHomeArticle1);
      await tester.pumpAndSettle();
      expect(widgetWebViewClose, findsOneWidget);
      await tester.tap(widgetWebViewClose);
      await tester.pumpAndSettle();
      await tester.tap(widgetHomeArticle2);
      await tester.pumpAndSettle();
      expect(widgetWebViewClose, findsOneWidget);
      await tester.tap(widgetWebViewClose);
      await tester.pumpAndSettle();
    });

    testWidgets('心情页基础操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      final BuildContext context =
          tester.element(find.byKey(const Key('widget_menu_page')));
      final i18n = S.of(context);

      final String nowDay = DateFormat('dd').format(DateTime.now());
      final String nowDay1 = DateFormat('dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final Finder widgetTabMood = find.byKey(const Key('tab_mood'));
      final Finder widgeMoodBody = find.byKey(const Key('widget_mood_body'));
      final Finder widgetAddMoodButton =
          find.byKey(const Key('widget_add_mood_button'));
      final Finder widgetMoodBodyCalendar =
          find.byKey(const Key('widget_mood_body_calendar'));
      final Finder widgetMoodCategorySelectBody =
          find.byKey(const Key('widget_mood_category_select_body'));
      final Finder widgetMoodActionsButton =
          find.byKey(const Key('widget_mood_actions_button'));
      final Finder widgetMoveModalBottomSheet =
          find.byKey(const Key('widget_move_modal_bottom_sheet'));
      final Finder widgetMoodCardSlidableActionButtonEdit =
          find.byKey(const Key('widget_mood_card_slidable_action_button_edit'));
      final Finder widgetMoodCardSlidableActionButtonDelete = find
          .byKey(const Key('widget_mood_card_slidable_action_button_delete'));
      final Finder textMood = find.text(i18n.mood_title);
      final Finder textNowDay = find.text(nowDay);
      final Finder textNowDay1 = find.text(nowDay1);
      final Finder textXZGJRH = find.text(i18n.mood_category_select_title_1);
      final Finder textHYZXQ = find.text(i18n.mood_category_select_title_2);
      final Finder textXQCD = find.text(i18n.mood_data_score_title);
      final Finder textHappy = find.text('开心');
      final Finder textAngry = find.text('生气');
      final Finder notificationRationaleDialog =
          find.byKey(const Key('notification_rationale_dialog'));
      final Finder notificationRationaleOK =
          find.byKey(const Key('notification_rationale_ok'));
      final Finder notificationRationaleClose =
          find.byKey(const Key('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
      }
      await tester.pumpAndSettle();

      /// 心情页基础操作
      await tester.tap(widgetTabMood);
      await tester.pumpAndSettle();
      expect(textMood, findsWidgets);
      await tester.fling(widgeMoodBody, const Offset(0, -500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgeMoodBody, const Offset(0, 500), 2400.0);
      await tester.pumpAndSettle();

      /// 日历操作
      await tester.fling(widgetMoodBodyCalendar, const Offset(500, 0), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const Offset(-500, 0), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const Offset(0, 500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const Offset(0, 500), 2400.0);
      await tester.pumpAndSettle();
      expect(textNowDay, findsWidgets);
      expect(textNowDay1, findsWidgets);
      await tester.tap(textNowDay1.last);
      await tester.pumpAndSettle();
      await tester.tap(textNowDay.last);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const Offset(0, -500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const Offset(0, -500), 2400.0);
      await tester.pumpAndSettle();

      /// 添加选择心情和切换心情
      await tester.tap(widgetAddMoodButton);
      await tester.pumpAndSettle();
      expect(textXZGJRH, findsOneWidget);
      expect(textHappy, findsOneWidget);
      await tester.fling(
        widgetMoodCategorySelectBody,
        const Offset(0, -500),
        2400.0,
      );
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.fling(
        widgetMoodCategorySelectBody,
        const Offset(0, 500),
        2400.0,
      );
      await tester.pumpAndSettle();
      expect(textHappy, findsOneWidget);
      await tester.tap(textHappy);
      await tester.pumpAndSettle();
      expect(textHappy, findsOneWidget);
      expect(textXQCD, findsOneWidget);
      await tester.tap(textHappy);
      await tester.pumpAndSettle();
      expect(textHYZXQ, findsOneWidget);
      expect(textHappy, findsOneWidget);
      await tester.fling(
        widgetMoodCategorySelectBody,
        const Offset(0, -500),
        2400.0,
      );
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.tap(textAngry);
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      expect(textXQCD, findsOneWidget);
      await tester.tap(widgetMoodActionsButton);
      await tester.pumpAndSettle();

      /// 添加心情后，心情页基础操作
      expect(textAngry, findsWidgets);
      await tester.tap(textAngry.last);
      await tester.pumpAndSettle();
      expect(textAngry, findsWidgets);
      await tester.fling(
        widgetMoveModalBottomSheet,
        const Offset(0, 400),
        2400.0,
      );
      await tester.pumpAndSettle();
      await tester.fling(textAngry.last, const Offset(-400, 0), 2400.0);
      await tester.pumpAndSettle();
      expect(widgetMoodCardSlidableActionButtonEdit, findsOneWidget);
      expect(widgetMoodCardSlidableActionButtonDelete, findsOneWidget);
      await tester.fling(widgeMoodBody, const Offset(0, 500), 2400.0);
      await tester.pumpAndSettle();
      expect(widgetMoodCardSlidableActionButtonEdit, findsNothing);
      expect(widgetMoodCardSlidableActionButtonDelete, findsNothing);
    });

    testWidgets('统计页基础操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      final BuildContext context =
          tester.element(find.byKey(const Key('widget_menu_page')));
      final i18n = S.of(context);

      final Finder widgetTabStatistic = find.byKey(const Key('tab_statistic'));
      final Finder widgetStatisticBody =
          find.byKey(const Key('widget_statistic_body'));
      final Finder textStatistic = find.text(i18n.statistic_title);
      final Finder textMoodStatistic =
          find.text(i18n.statistic_moodStatistics_title);
      final Finder textMoodDay7 = find.text(i18n.statistic_filter_7d);
      final Finder textMoodDay15 = find.text(i18n.statistic_filter_15d);
      final Finder textMoodDay30 = find.text(i18n.statistic_filter_30d);
      Finder textMoodDesc(int day) =>
          find.text(i18n.statistic_moodScoreAverage_content(day));
      final Finder notificationRationaleDialog =
          find.byKey(const Key('notification_rationale_dialog'));
      final Finder notificationRationaleOK =
          find.byKey(const Key('notification_rationale_ok'));
      final Finder notificationRationaleClose =
          find.byKey(const Key('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
      }
      await tester.pumpAndSettle();

      /// 统计页基础操作
      await tester.tap(widgetTabStatistic);
      await tester.pumpAndSettle();
      expect(textStatistic, findsWidgets);
      await tester.fling(widgetStatisticBody, const Offset(0, -500), 2400.0);
      await tester.pumpAndSettle();
      expect(textMoodStatistic, findsOneWidget);
      await tester.fling(widgetStatisticBody, const Offset(0, 500), 2400.0);
      await tester.pumpAndSettle();

      /// 切换统计范围
      expect(textMoodDay7, findsOneWidget);
      expect(textMoodDay15, findsOneWidget);
      expect(textMoodDay30, findsOneWidget);
      await tester.tap(textMoodDay15);
      await tester.pumpAndSettle();
      expect(textMoodDesc(15), findsWidgets);
      await tester.tap(textMoodDay30);
      await tester.pumpAndSettle();
      expect(textMoodDesc(30), findsWidgets);
      await tester.tap(textMoodDay7);
      await tester.pumpAndSettle();
      expect(textMoodDesc(7), findsWidgets);
    });
  });
}
