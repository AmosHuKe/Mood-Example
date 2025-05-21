/// 心情详细内容表
abstract final class MoodInfo {
  /// 表名称
  static const String tableName = 'mood_info';

  /// 字段名

  /// 心情ID
  static const String mood_id = 'mood_id';

  /// 图标
  static const String icon = 'icon';

  /// 心情（标题）
  static const String title = 'title';

  /// 心情程度分数
  static const String score = 'score';

  /// 心情内容
  static const String content = 'content';

  /// 创建时间
  static const String create_time = 'create_time';

  /// 修改时间
  static const String update_time = 'update_time';

  /// 删除数据库
  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  /// 创建数据库
  static const String createTable =
      '''
      CREATE TABLE $tableName (
        $mood_id INTEGER PRIMARY KEY,
        $icon TEXT NOT NULL,
        $title TEXT NOT NULL,
        $score INT NOT NULL,
        $content TEXT NULL,
        $create_time TEXT NOT NULL,
        $update_time TEXT NOT NULL
      );
    ''';
}
