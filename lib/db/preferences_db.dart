import 'package:shared_preferences/shared_preferences.dart';

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
}
