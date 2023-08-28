/// 心情类别表
class TableMoodInfoCategory {
  /// 表名称
  static const String tableName = 'mood_info_category';

  /// 字段名

  /// 类别ID
  static const String fieldCategoryId = 'categoryId';

  /// 类别图标
  static const String fieldIcon = 'icon';

  /// 类别名称标题
  static const String fieldTitle = 'title';

  /// 删除数据库
  final String dropTable = 'DROP TABLE IF EXISTS $tableName';

  /// 创建数据库
  final String createTable = '''
      CREATE TABLE $tableName (
        $fieldCategoryId INTEGER PRIMARY KEY,
        $fieldIcon TEXT,
        $fieldTitle TEXT
      );
    ''';
}
