import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  tearDownAll(() async {
    await driver.close();
  });
  test('切换底部菜单 Tab', () async {
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey('tab_home'));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey('tab_mood'));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey('tab_statistic'));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey('tab_home'));
    await Future.delayed(const Duration(seconds: 2));
  });

  test("侧栏打开关闭", () async {
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("tab_screen_left"));
    await Future.delayed(const Duration(seconds: 2));
    await driver.tap(find.byValueKey("widget_menu_screen_left_logo"));
    await Future.delayed(const Duration(seconds: 2));
  });
}
