/// 心情详细内容表
class TableMoodInfo {
  /// 表名称
  static const String tableName = 'mood_info';

  /// 字段名

  /// 心情ID
  static const String fieldMoodId = 'moodId';

  /// 图标
  static const String fieldIcon = 'icon';

  /// 心情（标题）
  static const String fieldTitle = 'title';

  /// 心情程度分数
  static const String fieldScore = 'score';

  /// 心情内容
  static const String fieldContent = 'content';

  /// 创建时间
  static const String fieldCreateTime = 'createTime';

  /// 修改时间
  static const String fieldUpdateTime = 'updateTime';

  /// 删除数据库
  final String dropTable = 'DROP TABLE IF EXISTS $tableName';

  /// 创建数据库
  final String createTable = '''
      CREATE TABLE $tableName (
        $fieldMoodId INTEGER PRIMARY KEY,
        $fieldIcon TEXT,
        $fieldTitle TEXT,
        $fieldScore INT,
        $fieldContent TEXT,
        $fieldCreateTime VARCHAR(40),
        $fieldUpdateTime VARCHAR(40)
      );
    ''';
}
