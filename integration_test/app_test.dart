import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:integration_test/integration_test.dart';

import 'package:moodexample/l10n/gen/app_localizations.dart';
import 'package:moodexample/shared/config/language.dart';
import 'package:moodexample/shared/config/multiple_theme_mode.dart';
import 'package:moodexample/shared/config/dependencies.dart';
import 'package:moodexample/application.dart' show Application;

void main() {
  /// 集成测试环境初始化
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('基础操作测试', () {
    testWidgets('切换底部菜单 Tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(providers: Dependencies.providersLocal, child: const Application()),
      );
      await tester.pumpAndSettle();

      final widgetTabHome = find.byKey(const .new('tab_home'));
      final widgetTabMood = find.byKey(const .new('tab_mood'));
      final widgetTabStatistic = find.byKey(const .new('tab_statistic'));
      final notificationRationaleDialog = find.byKey(const .new('notification_rationale_dialog'));
      final notificationRationaleOK = find.byKey(const .new('notification_rationale_ok'));
      final notificationRationaleClose = find.byKey(const .new('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
        await tester.pumpAndSettle();
      }

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
      await tester.pumpWidget(
        MultiProvider(providers: Dependencies.providersLocal, child: const Application()),
      );
      await tester.pumpAndSettle();
      // await Future.delayed(const .new(seconds: 3));
      final BuildContext context = tester.element(find.byKey(const .new('widget_menu_page')));
      final l10n = AppL10n.of(context);

      final multipleThemeMode = MultipleThemeMode.values;
      final language = [];
      final widgetTabScreenLeft = find.byKey(const .new('tab_screen_left'));
      final widgetMoveModalBottomSheet = find.byKey(const .new('widget_move_modal_bottom_sheet'));
      final widgetLaboratoryPage = find.byKey(const .new('widget_laboratory_page'));
      final widgetLaboratoryBackButton = find.byKey(const .new('widget_laboratory_back_button'));
      final widgetMenuScreenLeftLogo = find.byKey(const .new('widget_menu_screen_left_logo'));
      final widgetWebViewClose = find.byKey(const .new('widget_web_view_close'));
      final textData = find.text(l10n.app_setting_database);
      final textDataExport = find.text(l10n.app_setting_database_export_data);
      final textDataImport = find.text(l10n.app_setting_database_import_data);
      final textSecurity = find.text(l10n.app_setting_security);
      final textTheme = find.text(l10n.app_setting_theme);
      final textThemeSetting = find.text(l10n.app_setting_theme_appearance);
      final textThemeSettingSystem = find.text(l10n.app_setting_theme_appearance_system);
      final textThemeSettingLight = find.text(l10n.app_setting_theme_appearance_light);
      final textThemeSettingDark = find.text(l10n.app_setting_theme_appearance_dark);
      final textLanguage = find.text(l10n.app_setting_language);
      final textLanguageChinese = find.text('简体中文');
      final textLanguageEnglish = find.text('English');
      final textLanguageSystem = find.text('System');
      final textLaboratory = find.text(l10n.app_setting_laboratory);
      final textAbout = find.text(l10n.app_setting_about);
      final notificationRationaleDialog = find.byKey(const .new('notification_rationale_dialog'));
      final notificationRationaleOK = find.byKey(const .new('notification_rationale_ok'));
      final notificationRationaleClose = find.byKey(const .new('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
        await tester.pumpAndSettle();
      }

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

      await tester.fling(widgetMoveModalBottomSheet, const .new(0, 400), 2400.0);
      await tester.pumpAndSettle();

      /// 安全操作
      expect(textSecurity, findsOneWidget);
      await tester.tap(textSecurity);
      await tester.pumpAndSettle();

      await tester.fling(widgetMoveModalBottomSheet, const .new(0, 400), 2400.0);
      await tester.pumpAndSettle();

      /// 主题操作
      expect(textTheme, findsOneWidget);
      await tester.tap(textTheme);
      await tester.pumpAndSettle();
      expect(textThemeSetting, findsOneWidget);

      await tester.tap(textThemeSettingLight);
      await tester.pumpAndSettle();
      await Future.forEach(multipleThemeMode, (key) async {
        await tester.tap(find.byKey(.new('widget_multiple_theme_card_${key.name}')));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingDark);
      await tester.pumpAndSettle();
      await Future.forEach(multipleThemeMode, (key) async {
        await tester.tap(find.byKey(.new('widget_multiple_theme_card_${key.name}')));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingSystem);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(.new('widget_multiple_theme_card_${MultipleThemeMode.kDefault.name}')),
      );

      await tester.fling(widgetMoveModalBottomSheet, const .new(0, 400), 2400.0);
      await tester.pumpAndSettle();

      /// 语言操作
      expect(textLanguage, findsOneWidget);
      await tester.tap(textLanguage);
      await tester.pumpAndSettle();

      for (final element in Language.values) {
        language.add(element.title);
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

      await tester.fling(widgetMoveModalBottomSheet, const .new(0, 400), 2400.0);
      await tester.pumpAndSettle();

      /// 实验室操作
      expect(textLaboratory, findsOneWidget);
      await tester.tap(textLaboratory);
      await tester.pumpAndSettle();
      expect(textLaboratory, findsOneWidget);
      await tester.fling(widgetLaboratoryPage, const .new(0, -400), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetLaboratoryPage, const .new(0, 400), 2400.0);
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
      await tester.pumpWidget(
        MultiProvider(providers: Dependencies.providersLocal, child: const Application()),
      );
      await tester.pumpAndSettle();
      // await Future.delayed(const .new(seconds: 3));
      final BuildContext context = tester.element(find.byKey(const .new('widget_menu_page')));
      final l10n = AppL10n.of(context);

      // Finder widgetHomeBody = find.byKey(const .new("widget_home_body"));
      final widgetTabHome = find.byKey(const .new('tab_home'));
      final widgetOptionMood = find.byKey(const .new('widget_mood_option'));
      final widgetActionButtonClose = find.byKey(const .new('widget_action_button_close'));
      final widgetNextButton = find.byKey(const .new('widget_next_button'));
      final widgetWebViewClose = find.byKey(const .new('widget_web_view_close'));
      final widgetHomeArticle1 = find.byKey(const .new('widget_home_article_1'));
      final widgetHomeArticle2 = find.byKey(const .new('widget_home_article_2'));
      final textHi = find.text(l10n.home_hi);
      final textHelp = find.text(l10n.home_help_title);
      final textHappy = find.text('开心');
      final textAngry = find.text('生气');
      final textOK = find.text(l10n.mood_content_close_button_confirm);
      final textLook = find.text(l10n.home_upgrade_button);
      final textGLSX = find.text(l10n.onboarding_title_1);
      final textJXTJ = find.text(l10n.onboarding_title_2);
      final textJKKS = find.text(l10n.onboarding_title_3);
      final notificationRationaleDialog = find.byKey(const .new('notification_rationale_dialog'));
      final notificationRationaleOK = find.byKey(const .new('notification_rationale_ok'));
      final notificationRationaleClose = find.byKey(const .new('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
        await tester.pumpAndSettle();
      }

      /// 切换到首页，滑动验证内容存在
      await tester.tap(widgetTabHome);
      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);
      await tester.fling(textHelp, const .new(0, -400), 2400.0);
      await tester.pumpAndSettle();
      expect(textHelp, findsOneWidget);
      await tester.fling(textHelp, const .new(0, 400), 2400.0);
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
      await tester.fling(widgetOptionMood, const .new(-400, 0), 2400.0);
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
      await tester.fling(widgetOptionMood, const .new(400, 0), 2400.0);
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
      await tester.fling(textHelp, const .new(0, -400), 2400.0);
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
      await tester.pumpWidget(
        MultiProvider(providers: Dependencies.providersLocal, child: const Application()),
      );
      await tester.pumpAndSettle();
      // await Future.delayed(const .new(seconds: 3));
      final BuildContext context = tester.element(find.byKey(const .new('widget_menu_page')));
      final l10n = AppL10n.of(context);

      final nowDay = DateFormat('dd').format(.now());
      final nowDay1 = DateFormat('dd').format(.now().subtract(const .new(days: 1)));
      final widgetTabMood = find.byKey(const .new('tab_mood'));
      final widgeMoodBody = find.byKey(const .new('widget_mood_body'));
      final widgetAddMoodButton = find.byKey(const .new('widget_add_mood_button'));
      final widgetMoodBodyCalendar = find.byKey(const .new('widget_mood_body_calendar'));
      final widgetMoodCategorySelectBody = find.byKey(
        const .new('widget_mood_category_select_body'),
      );
      final widgetMoodActionsButton = find.byKey(const .new('widget_mood_actions_button'));
      final widgetMoveModalBottomSheet = find.byKey(const .new('widget_move_modal_bottom_sheet'));
      final widgetMoodCardSlidableActionButtonEdit = find.byKey(
        const .new('widget_mood_card_slidable_action_button_edit'),
      );
      final widgetMoodCardSlidableActionButtonDelete = find.byKey(
        const .new('widget_mood_card_slidable_action_button_delete'),
      );
      final textMood = find.text(l10n.mood_title);
      final textNowDay = find.text(nowDay);
      final textNowDay1 = find.text(nowDay1);
      final textXZGJRH = find.text(l10n.mood_category_select_title_1);
      final textHYZXQ = find.text(l10n.mood_category_select_title_2);
      final textXQCD = find.text(l10n.mood_data_score_title);
      final textHappy = find.text('开心');
      final textAngry = find.text('生气');
      final notificationRationaleDialog = find.byKey(const .new('notification_rationale_dialog'));
      final notificationRationaleOK = find.byKey(const .new('notification_rationale_ok'));
      final notificationRationaleClose = find.byKey(const .new('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
        await tester.pumpAndSettle();
      }

      /// 心情页基础操作
      await tester.tap(widgetTabMood);
      await tester.pumpAndSettle();
      expect(textMood, findsWidgets);
      await tester.fling(widgeMoodBody, const .new(0, -500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgeMoodBody, const .new(0, 500), 2400.0);
      await tester.pumpAndSettle();

      /// 日历操作
      await tester.fling(widgetMoodBodyCalendar, const .new(500, 0), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const .new(-500, 0), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const .new(0, 500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const .new(0, 500), 2400.0);
      await tester.pumpAndSettle();
      expect(textNowDay, findsWidgets);
      expect(textNowDay1, findsWidgets);
      await tester.tap(textNowDay1.last);
      await tester.pumpAndSettle();
      await tester.tap(textNowDay.last);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const .new(0, -500), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(widgetMoodBodyCalendar, const .new(0, -500), 2400.0);
      await tester.pumpAndSettle();

      /// 添加选择心情和切换心情
      await tester.tap(widgetAddMoodButton);
      await tester.pumpAndSettle();
      expect(textXZGJRH, findsOneWidget);
      expect(textHappy, findsOneWidget);
      await tester.fling(widgetMoodCategorySelectBody, const .new(0, -500), 2400.0);
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.fling(widgetMoodCategorySelectBody, const .new(0, 500), 2400.0);
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
      await tester.fling(widgetMoodCategorySelectBody, const .new(0, -500), 2400.0);
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
      await tester.fling(widgetMoveModalBottomSheet, const .new(0, 400), 2400.0);
      await tester.pumpAndSettle();
      await tester.fling(textAngry.last, const .new(-400, 0), 2400.0);
      await tester.pumpAndSettle();
      expect(widgetMoodCardSlidableActionButtonEdit, findsOneWidget);
      expect(widgetMoodCardSlidableActionButtonDelete, findsOneWidget);
      await tester.fling(widgeMoodBody, const .new(0, 500), 2400.0);
      await tester.pumpAndSettle();
      expect(widgetMoodCardSlidableActionButtonEdit, findsNothing);
      expect(widgetMoodCardSlidableActionButtonDelete, findsNothing);
    });

    testWidgets('统计页基础操作', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(providers: Dependencies.providersLocal, child: const Application()),
      );
      await tester.pumpAndSettle();
      // await Future.delayed(const .new(seconds: 3));
      final BuildContext context = tester.element(find.byKey(const .new('widget_menu_page')));
      final l10n = AppL10n.of(context);

      final widgetTabStatistic = find.byKey(const .new('tab_statistic'));
      final widgetStatisticBody = find.byKey(const .new('widget_statistic_body'));
      final textStatistic = find.text(l10n.statistic_title);
      final textMoodStatistic = find.text(l10n.statistic_moodStatistics_title);
      final textMoodDay7 = find.text(l10n.statistic_filter_7d);
      final textMoodDay15 = find.text(l10n.statistic_filter_15d);
      final textMoodDay30 = find.text(l10n.statistic_filter_30d);
      Finder textMoodDesc(int day) => find.text(l10n.statistic_moodScoreAverage_content(day));
      final notificationRationaleDialog = find.byKey(const .new('notification_rationale_dialog'));
      final notificationRationaleOK = find.byKey(const .new('notification_rationale_ok'));
      final notificationRationaleClose = find.byKey(const .new('notification_rationale_close'));

      /// 通知权限
      if (await notificationRationaleDialog.tryEvaluate()) {
        expect(notificationRationaleOK, findsOneWidget);
        expect(notificationRationaleClose, findsOneWidget);
        await tester.tap(notificationRationaleClose);
        await tester.pumpAndSettle();
      }

      /// 统计页基础操作
      await tester.tap(widgetTabStatistic);
      await tester.pumpAndSettle();
      expect(textStatistic, findsWidgets);
      await tester.fling(widgetStatisticBody, const .new(0, -500), 2400.0);
      await tester.pumpAndSettle();
      expect(textMoodStatistic, findsOneWidget);
      await tester.fling(widgetStatisticBody, const .new(0, 500), 2400.0);
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
