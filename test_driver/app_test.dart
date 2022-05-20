import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

///
import 'package:moodexample/config/multiple_themes.dart';
import 'package:moodexample/config/language.dart';

void main() {
  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  tearDownAll(() async {
    await driver.close();
  });

  test("切换底部菜单 Tab", () async {
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("tab_home"));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("tab_mood"));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("tab_statistic"));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("tab_home"));
    await Future.delayed(const Duration(seconds: 2));
  });

  test("首页基础操作", () async {
    await driver.tap(find.byValueKey("tab_home"));

    /// 整体页面滑动
    await driver.waitFor(find.text("Hi~"));
    final finderWidgetHomeBody = find.byValueKey("widget_home_body");
    await driver.scroll(
        finderWidgetHomeBody, 0, -800, const Duration(milliseconds: 500));
    await driver.waitFor(find.text("情绪管理"));
    await driver.scroll(
        finderWidgetHomeBody, 0, 800, const Duration(milliseconds: 500));
    await driver.waitFor(find.text("Hi~"));

    /// 心情操作卡片
    final finderWidgetOptionMood = find.byValueKey("widget_option_mood");
    await driver.tap(find.text("开心"));
    await driver.waitFor(find.text("开心"));
    driver.tap(find.byValueKey("widget_action_button_close"));
    await driver.tap(find.text("确认"));
    await driver.scroll(
        finderWidgetOptionMood, -500, 0, const Duration(milliseconds: 500));
    await driver.tap(find.text("生气"));
    await driver.waitFor(find.text("生气"));
    driver.tap(find.byValueKey("widget_action_button_close"));
    await driver.tap(find.text("确认"));
    await driver.scroll(
        finderWidgetOptionMood, 500, 0, const Duration(milliseconds: 500));

    /// 通知内容
    await driver.tap(find.text("查看"));
    await driver.waitFor(find.text("管理思绪"));
    await driver.tap(find.byValueKey("widget_next_bottom"));
    await driver.waitFor(find.text("精心统计"));
    await driver.tap(find.byValueKey("widget_next_bottom"));
    await driver.waitFor(find.text("即刻开始"));
    await driver.tap(find.byValueKey("widget_next_bottom"));
  });

  group("侧栏基础操作", () {
    test("侧栏打开", () async {
      await driver.waitFor(find.byValueKey("tab_screen_left"));
      await driver.tap(find.byValueKey("tab_screen_left"));
      await driver.waitFor(find.text("关于"));
    });

    test("数据操作", () async {
      await driver.tap(find.text("数据"));
      await driver.waitFor(find.text("导入数据"));
      await driver.tap(find.text("导入数据"));
      await driver.tap(find.text("导出数据"));
      await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
          400, const Duration(milliseconds: 200));
      await driver.waitForAbsent(find.text("导入数据"));
    });

    test("主题操作", () async {
      await driver.tap(find.text("主题"));
      await driver.waitFor(find.text("主题外观"));
      List appMultipleThemesModeKey = [];
      appMultipleThemesMode
          .forEach((key, value) => appMultipleThemesModeKey.add(key));

      await driver.tap(find.text("普通模式"));
      await Future.delayed(const Duration(seconds: 1));
      await Future.forEach(appMultipleThemesModeKey, (key) async {
        await driver.tap(find.byValueKey("widget_multiple_themes_card_$key"),
            timeout: const Duration(seconds: 2));
      });
      await driver.tap(find.text("深色模式"));
      await Future.delayed(const Duration(seconds: 1));
      await Future.forEach(appMultipleThemesModeKey, (key) async {
        await driver.tap(find.byValueKey("widget_multiple_themes_card_$key"),
            timeout: const Duration(seconds: 2));
      });
      await driver.tap(find.text("跟随系统"));
      await Future.delayed(const Duration(seconds: 1));
      await driver.tap(find.byValueKey("widget_multiple_themes_card_default"),
          timeout: const Duration(seconds: 2));

      await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
          400, const Duration(milliseconds: 200));
      await driver.waitForAbsent(find.text("主题外观"));
    });

    test("语言操作", () async {
      await driver.tap(find.text("语言"));
      await driver.waitFor(find.text("简体中文"));
      List language = [];
      for (var element in languageConfig) {
        language.add(element["language"]);
      }
      await Future.forEach(language, (e) async {
        await driver.tap(find.text(e.toString()),
            timeout: const Duration(seconds: 2));
      });
      await driver.tap(find.text("English"),
          timeout: const Duration(seconds: 2));
      await driver.tap(find.text("System"),
          timeout: const Duration(seconds: 2));
      await driver.scroll(find.byValueKey("widget_move_modal_bottom_sheet"), 0,
          400, const Duration(milliseconds: 200));
      await driver.waitForAbsent(find.text("简体中文"));
    });
    // test("实验室操作", () async {
    //   await driver.tap(find.text("实验室"));
    //   await driver.waitFor(find.text("实验室"));
    //   driver.getTopLeft(find.byValueKey("widget_laboratory_page"));
    //   // await driver.scroll(find.byValueKey("widget_laboratory_page"), 400, 0,
    //   //     const Duration(milliseconds: 200));
    // });
    test("侧栏关闭", () async {
      await driver.tap(find.byValueKey("widget_menu_screen_left_logo"));
    });
  });
}
