import 'package:flutter/material.dart';

///
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/app_theme.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// shared_preferences
class PreferencesDB {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  /**
   * APP相关
   */
  /// 打开APP次数
  static const openAPPCount = "openAPPCount";

  /// 主题深色模式
  /// system(默认)：跟随系统 light：普通 dark：深色
  static const themeAPPDarkMode = "themeAPPDarkMode";

  /**
   * 数据库相关
   */
  /// 是否填充完成【心情类别】表默认值
  static const initMoodCategoryDefaultType = "initMoodCategoryDefaultType";

  /**
   * shared_preferences
   */
  /// 设置-是否填充完成【心情类别】表默认值
  Future setInitMoodCategoryDefaultType(bool value) async {
    SharedPreferences prefs = await init();
    prefs.setBool(initMoodCategoryDefaultType, value);
  }

  /// 获取-是否填充完成【心情类别】表默认值
  Future<bool> getInitMoodCategoryDefaultType() async {
    SharedPreferences prefs = await init();
    return prefs.getBool(initMoodCategoryDefaultType) ?? false;
  }

  /// 设置-主题深色模式
  Future setThemeAPPDarkMode(BuildContext context, String value) async {
    SharedPreferences prefs = await init();
    prefs.setString(themeAPPDarkMode, value);
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setThemeMode(darkThemeMode(value));
  }

  /// 获取-主题深色模式
  Future<String> getThemeAPPDarkMode(BuildContext context) async {
    SharedPreferences prefs = await init();
    String themeDarkMode = prefs.getString(themeAPPDarkMode) ?? "system";
    Provider.of<ApplicationViewModel>(context, listen: false)
        .setThemeMode(darkThemeMode(themeDarkMode));
    return themeDarkMode;
  }
}
