/// 心情类别表
abstract final class MoodInfoCategory {
  /// 表名称
  static const String tableName = 'mood_info_category';

  /// 字段名

  /// 类别ID
  static const String category_id = 'category_id';

  /// 类别图标
  static const String icon = 'icon';

  /// 类别名称标题
  static const String title = 'title';

  /// 删除数据库
  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  /// 创建数据库
  static const String createTable =
      '''
      CREATE TABLE $tableName (
        $category_id INTEGER PRIMARY KEY,
        $icon TEXT NOT NULL,
        $title TEXT NOT NULL
      );
    ''';
}
