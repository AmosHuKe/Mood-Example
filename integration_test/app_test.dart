import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

///
import 'package:moodexample/main.dart' as app;

void main() {
  /// 集成测试环境的初始化
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("基础操作测试", () {
    testWidgets("切换底部菜单 Tab", (WidgetTester tester) async {
      app.main();

      /// 等待数据加载
      await tester.pumpAndSettle();

      final widgetTabHome = find.byKey(const Key("tab_home"));
      final widgetTabMood = find.byKey(const Key("tab_mood"));
      final widgetTabStatistic = find.byKey(const Key("tab_statistic"));

      /// 检查菜单是否存在
      expect(widgetTabHome, findsOneWidget);
      expect(widgetTabMood, findsOneWidget);
      expect(widgetTabStatistic, findsOneWidget);

      /// 测试点击
      await tester.tap(widgetTabHome);
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(widgetTabMood);
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(widgetTabStatistic);
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(widgetTabHome);
      await Future.delayed(const Duration(seconds: 1));
    });

    testWidgets("首页基础操作", (WidgetTester tester) async {
      app.main();

      /// 等待数据加载
      await tester.pumpAndSettle();
      final widgetHomeBody = find.byKey(const Key("widget_home_body"));
      final widgetTabHome = find.byKey(const Key("tab_home"));
      final textHi = find.text("Hi~");
      final textHelp = find.text("帮助");

      /// 切换到首页
      await tester.tap(widgetTabHome);
      expect(textHi, findsOneWidget);
      await tester.fling(widgetHomeBody, const Offset(0, -400), 1000.0);
      expect(textHelp, findsOneWidget);
      await Future.delayed(const Duration(seconds: 1));
      await tester.fling(widgetHomeBody, const Offset(0, 400), 1000.0);
      expect(textHi, findsOneWidget);
      await Future.delayed(const Duration(seconds: 1));

      // /// 整体页面滑动
      // await driver.waitFor(find.text("Hi~"));
      // final finderWidgetHomeBody = find.byValueKey("widget_home_body");
      // await driver.scroll(
      //     finderWidgetHomeBody, 0, -800, const Duration(milliseconds: 500));
      // await driver.waitFor(find.text("情绪管理"));
      // await driver.scroll(
      //     finderWidgetHomeBody, 0, 800, const Duration(milliseconds: 500));
      // await driver.waitFor(find.text("Hi~"));

      // /// 心情操作卡片
      // final finderWidgetOptionMood = find.byValueKey("widget_option_mood");
      // await driver.tap(find.text("开心"));
      // await driver.waitFor(find.text("开心"));
      // driver.tap(find.byValueKey("widget_action_button_close"));
      // await driver.tap(find.text("确认"));
      // await driver.scroll(
      //     finderWidgetOptionMood, -500, 0, const Duration(milliseconds: 500));
      // await driver.tap(find.text("生气"));
      // await driver.waitFor(find.text("生气"));
      // driver.tap(find.byValueKey("widget_action_button_close"));
      // await driver.tap(find.text("确认"));
      // await driver.scroll(
      //     finderWidgetOptionMood, 500, 0, const Duration(milliseconds: 500));

      // /// 通知内容
      // await driver.tap(find.text("查看"));
      // await driver.waitFor(find.text("管理思绪"));
      // await driver.tap(find.byValueKey("widget_next_bottom"));
      // await driver.waitFor(find.text("精心统计"));
      // await driver.tap(find.byValueKey("widget_next_bottom"));
      // await driver.waitFor(find.text("即刻开始"));
      // await driver.tap(find.byValueKey("widget_next_bottom"));
    });
  });

  // test("首页基础操作", () async {
  //   await driver.tap(find.byValueKey("tab_home"));

  //   /// 整体页面滑动
  //   await driver.waitFor(find.text("Hi~"));
  //   final finderWidgetHomeBody = find.byValueKey("widget_home_body");
  //   await driver.scroll(
  //       finderWidgetHomeBody, 0, -800, const Duration(milliseconds: 500));
  //   await driver.waitFor(find.text("情绪管理"));
  //   await driver.scroll(
  //       finderWidgetHomeBody, 0, 800, const Duration(milliseconds: 500));
  //   await driver.waitFor(find.text("Hi~"));

  //   /// 心情操作卡片
  //   final finderWidgetOptionMood = find.byValueKey("widget_option_mood");
  //   await driver.tap(find.text("开心"));
  //   await driver.waitFor(find.text("开心"));
  //   driver.tap(find.byValueKey("widget_action_button_close"));
  //   await driver.tap(find.text("确认"));
  //   await driver.scroll(
  //       finderWidgetOptionMood, -500, 0, const Duration(milliseconds: 500));
  //   await driver.tap(find.text("生气"));
  //   await driver.waitFor(find.text("生气"));
  //   driver.tap(find.byValueKey("widget_action_button_close"));
  //   await driver.tap(find.text("确认"));
  //   await driver.scroll(
  //       finderWidgetOptionMood, 500, 0, const Duration(milliseconds: 500));

  //   /// 通知内容
  //   await driver.tap(find.text("查看"));
  //   await driver.waitFor(find.text("管理思绪"));
  //   await driver.tap(find.byValueKey("widget_next_bottom"));
  //   await driver.waitFor(find.text("精心统计"));
  //   await driver.tap(find.byValueKey("widget_next_bottom"));
  //   await driver.waitFor(find.text("即刻开始"));
  //   await driver.tap(find.byValueKey("widget_next_bottom"));
  // });

  // group("侧栏基础操作", () {
  //   test("侧栏打开", () async {
  //     await driver.waitFor(find.byValueKey("tab_screen_left"));
  //     await driver.tap(find.byValueKey("tab_screen_left"));
  //     await driver.waitFor(find.text("关于"));
  //   });

  //   test("数据操作", () async {
  //     await driver.tap(find.text("数据"));
  //     await driver.waitFor(find.text("导入数据"));
  //     await driver.tap(find.text("导入数据"));
  //     await driver.tap(find.text("导出数据"));
  //     await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
  //         400, const Duration(milliseconds: 200));
  //     await driver.waitForAbsent(find.text("导入数据"));
  //   });

  //   test("主题操作", () async {
  //     await driver.tap(find.text("主题"));
  //     await driver.waitFor(find.text("主题外观"));
  //     List appMultipleThemesModeKey = [];
  //     appMultipleThemesMode
  //         .forEach((key, value) => appMultipleThemesModeKey.add(key));

  //     await driver.tap(find.text("普通模式"));
  //     await Future.delayed(const Duration(seconds: 1));
  //     await Future.forEach(appMultipleThemesModeKey, (key) async {
  //       await driver.tap(find.byValueKey("widget_multiple_themes_card_$key"),
  //           timeout: const Duration(seconds: 2));
  //     });
  //     await driver.tap(find.text("深色模式"));
  //     await Future.delayed(const Duration(seconds: 1));
  //     await Future.forEach(appMultipleThemesModeKey, (key) async {
  //       await driver.tap(find.byValueKey("widget_multiple_themes_card_$key"),
  //           timeout: const Duration(seconds: 2));
  //     });
  //     await driver.tap(find.text("跟随系统"));
  //     await Future.delayed(const Duration(seconds: 1));
  //     await driver.tap(find.byValueKey("widget_multiple_themes_card_default"),
  //         timeout: const Duration(seconds: 2));

  //     await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
  //         400, const Duration(milliseconds: 200));
  //     await driver.waitForAbsent(find.text("主题外观"));
  //   });

  //   test("语言操作", () async {
  //     await driver.tap(find.text("语言"));
  //     await driver.waitFor(find.text("简体中文"));
  //     List language = [];
  //     for (var element in languageConfig) {
  //       language.add(element["language"]);
  //     }
  //     await Future.forEach(language, (e) async {
  //       await driver.tap(find.text(e.toString()),
  //           timeout: const Duration(seconds: 2));
  //     });
  //     await driver.tap(find.text("English"),
  //         timeout: const Duration(seconds: 2));
  //     await driver.tap(find.text("System"),
  //         timeout: const Duration(seconds: 2));
  //     await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
  //         400, const Duration(milliseconds: 200));
  //     await driver.waitForAbsent(find.text("简体中文"));
  //   });
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
