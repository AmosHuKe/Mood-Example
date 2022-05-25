import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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
      await tester.fling(widgetHomeBody, const Offset(0, -400), 1200.0);
      await tester.pumpAndSettle();
      expect(textHelp, findsOneWidget);
      await tester.fling(widgetHomeBody, const Offset(0, 400), 1200.0);
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
      await tester.fling(widgetOptionMood, const Offset(-400, 0), 1200.0);
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
      await tester.fling(widgetOptionMood, const Offset(400, 0), 1200.0);
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

    testWidgets("侧栏基础操作", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      List appMultipleThemesModeKey = [];
      List language = [];
      Finder widgetTabScreenLeft = find.byKey(const Key("tab_screen_left"));
      Finder widgetMoveModalBottomSheet =
          find.byKey(const Key("widget_move_modal_bottom_sheet"));
      Finder textLogo = find.text("Mood");
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
      // await tester.tap(textLogo);
      // await tester.pumpAndSettle();

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
          widgetMoveModalBottomSheet, const Offset(0, 400), 1200.0);
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
          widgetMoveModalBottomSheet, const Offset(0, 400), 1200.0);
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
          widgetMoveModalBottomSheet, const Offset(0, 400), 1200.0);
      await tester.pumpAndSettle();

      /// 侧栏关闭
      await tester.tap(textLogo);
    });
  });

  // group("侧栏基础操作", () {
  //   test("实验室操作", () async {
  //     await driver.tap(find.text("实验室"));
  //     await driver.waitFor(find.text("实验室"));
  //     var finderWidgetLaboratoryPage =
  //         find.byValueKey("widget_laboratory_page");
  //     await driver.scroll(finderWidgetLaboratoryPage, 0, -500,
  //         const Duration(milliseconds: 500));
  //     await driver.scroll(finderWidgetLaboratoryPage, 0, 500,
  //         const Duration(milliseconds: 500));
  //   });
  //   test("侧栏关闭", () async {
  //     await driver.tap(find.byValueKey("widget_menu_screen_left_logo"));
  //   });
  // });
}
