import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';

///
import 'package:moodexample/main.dart' as app;

///
import 'package:moodexample/config/language.dart';
import 'package:moodexample/config/multiple_themes.dart';

void main() {
  /// 集成测试环境的初始化
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("基础操作测试", () {
    testWidgets("切换底部菜单 Tab", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder widgetTabHome = find.byKey(const Key("tab_home"));
      Finder widgetTabMood = find.byKey(const Key("tab_mood"));
      Finder widgetTabStatistic = find.byKey(const Key("tab_statistic"));

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

    testWidgets("侧栏基础操作", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      List appMultipleThemesModeKey = [];
      List language = [];
      Finder widgetTabScreenLeft = find.byKey(const Key("tab_screen_left"));
      Finder widgetMoveModalBottomSheet =
          find.byKey(const Key("widget_move_modal_bottom_sheet"));
      Finder widgetLaboratoryPage =
          find.byKey(const Key("widget_laboratory_page"));
      Finder widgetMenuScreenLeftLogo =
          find.byKey(const Key("widget_menu_screen_left_logo"));
      Finder textData = find.text("数据");
      Finder textDataExport = find.text("导出数据");
      Finder textDataImport = find.text("导入数据");
      Finder textTheme = find.text("主题");
      Finder textThemeSetting = find.text("主题外观");
      Finder textThemeSettingSystem = find.text("跟随系统");
      Finder textThemeSettingLight = find.text("普通模式");
      Finder textThemeSettingDark = find.text("深色模式");
      Finder textLanguage = find.text("语言");
      Finder textLanguageChinese = find.text("简体中文");
      Finder textLanguageEnglish = find.text("English");
      Finder textLanguageSystem = find.text("System");
      Finder textLaboratory = find.text("实验室");
      Finder textAbout = find.text("关于");

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
          widgetMoveModalBottomSheet, const Offset(0, 400), 2400.0);
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
        await tester.tap(find.byKey(Key("widget_multiple_themes_card_$key")));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingDark);
      await tester.pumpAndSettle();
      await Future.forEach(appMultipleThemesModeKey, (key) async {
        await tester.tap(find.byKey(Key("widget_multiple_themes_card_$key")));
        await tester.pumpAndSettle();
      });

      await tester.tap(textThemeSettingSystem);
      await tester.pumpAndSettle();
      await tester
          .tap(find.byKey(const Key("widget_multiple_themes_card_default")));

      await tester.fling(
          widgetMoveModalBottomSheet, const Offset(0, 400), 2400.0);
      await tester.pumpAndSettle();

      /// 语言操作
      expect(textLanguage, findsOneWidget);
      await tester.tap(textLanguage);
      await tester.pumpAndSettle();

      for (var element in languageConfig) {
        language.add(element["language"]);
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
          widgetMoveModalBottomSheet, const Offset(0, 400), 2400.0);
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
      await tester.dragFrom(const Offset(5, 100), const Offset(400, 100));
      await tester.pumpAndSettle();

      /// 侧栏关闭
      await tester.tap(widgetMenuScreenLeftLogo);
      await tester.pumpAndSettle();
    });

    testWidgets("首页基础操作", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder widgetHomeBody = find.byKey(const Key("widget_home_body"));
      Finder widgetTabHome = find.byKey(const Key("tab_home"));
      Finder widgetOptionMood = find.byKey(const Key("widget_option_mood"));
      Finder widgetActionButtonClose =
          find.byKey(const Key("widget_action_button_close"));
      Finder widgetNextButton = find.byKey(const Key("widget_next_button"));
      Finder textHi = find.text("Hi~");
      Finder textHelp = find.text("帮助");
      Finder textHappy = find.text("开心");
      Finder textAngry = find.text("生气");
      Finder textOK = find.text("确认");
      Finder textLook = find.text("查看");
      Finder textGLSX = find.text("管理思绪");
      Finder textJXTJ = find.text("精心统计");
      Finder textJKKS = find.text("即刻开始");

      /// 切换到首页，滑动验证内容存在
      await tester.tap(widgetTabHome);
      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);
      await tester.fling(widgetHomeBody, const Offset(0, -400), 2400.0);
      await tester.pumpAndSettle();
      expect(textHelp, findsOneWidget);
      await tester.fling(widgetHomeBody, const Offset(0, 400), 2400.0);
      await tester.pumpAndSettle();
      expect(textHi, findsOneWidget);

      /// 心情操作卡片，首尾滑动触发操作
      expect(textHappy, findsOneWidget);
      await tester.tap(textHappy);
      await tester.pumpAndSettle();
      expect(textHappy, findsOneWidget);
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
    });

    testWidgets("心情页基础操作", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String nowDay = DateFormat("dd").format(DateTime.now());
      String nowDay1 = DateFormat("dd")
          .format(DateTime.now().subtract(const Duration(days: 1)));
      Finder widgetTabMood = find.byKey(const Key("tab_mood"));
      Finder widgeMoodBody = find.byKey(const Key("widget_mood_body"));
      Finder widgetAddMoodButton =
          find.byKey(const Key("widget_add_mood_button"));
      Finder widgetMoodBodyCalendar =
          find.byKey(const Key("widget_mood_body_calendar"));
      Finder widgetMoodCategorySelectBody =
          find.byKey(const Key("widget_mood_category_select_body"));
      Finder widgetMoodActionsButton =
          find.byKey(const Key("widget_mood_actions_button"));
      Finder widgetMoveModalBottomSheet =
          find.byKey(const Key("widget_move_modal_bottom_sheet"));
      Finder widgetMoodCardSlidableActionButtonEdit =
          find.byKey(const Key("widget_mood_card_slidable_action_button_edit"));
      Finder widgetMoodCardSlidableActionButtonDelete = find
          .byKey(const Key("widget_mood_card_slidable_action_button_delete"));
      Finder textMood = find.text("心情");
      Finder textNowDay = find.text(nowDay);
      Finder textNowDay1 = find.text(nowDay1);
      Finder textXZGJRH = find.text("现在感觉如何");
      Finder textHYZXQ = find.text("换一种心情？");
      Finder textXQCD = find.text("心情程度");
      Finder textHappy = find.text("开心");
      Finder textAngry = find.text("生气");

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
          widgetMoodCategorySelectBody, const Offset(0, -500), 2400.0);
      await tester.pumpAndSettle();
      expect(textAngry, findsOneWidget);
      await tester.fling(
          widgetMoodCategorySelectBody, const Offset(0, 500), 2400.0);
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
          widgetMoodCategorySelectBody, const Offset(0, -500), 2400.0);
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
          widgetMoveModalBottomSheet, const Offset(0, 400), 2400.0);
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
  });
}
