import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/models/mood/mood_model.dart';

import 'package:moodexample/db/database/table_mood_info.dart';
import 'package:moodexample/db/database/table_mood_info_category.dart';

class DB {
  DB._();
  static final DB db = DB._();
  late Database _db;

  /// 数据库版本号
  static const int _version = 1;

  /// 数据库名称
  static const String _databaseName = 'moodDB.db';

  Future<Database> get database async {
    _db = await createDatabase();
    return _db;
  }

  /// 创建
  Future<Database> createDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);
    final Database db = await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  Future close() async => _db.close();

  /// 创建
  void _onCreate(Database db, int newVersion) async {
    print('_onCreate 新版本:$newVersion');
    final batch = db.batch();

    /// 心情详细内容表
    final tableMoodInfo = TableMoodInfo();
    batch.execute(tableMoodInfo.dropTable);
    batch.execute(tableMoodInfo.createTable);

    /// 心情分类表
    final tableMoodInfoCategory = TableMoodInfoCategory();
    batch.execute(tableMoodInfoCategory.dropTable);
    batch.execute(tableMoodInfoCategory.createTable);
    await batch.commit();
  }

  /// 升级
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('_onUpgrade 旧版本:$oldVersion');
    print('_onUpgrade 新版本:$newVersion');

    final batch = db.batch();

    /// 升级逻辑

    await batch.commit();
  }

  /*** 心情详情内容相关 ***/

  /// 查询心情详情
  ///
  /// [datetime] 查询日期（2022-01-04)
  ///
  Future<List> selectMood(String datetime) async {
    final db = await database;
    final List list = await db.query(
      TableMoodInfo.tableName,
      orderBy:
          '${TableMoodInfo.fieldCreateTime} asc, ${TableMoodInfo.fieldMoodId} desc',
      where: '''
        ${TableMoodInfo.fieldCreateTime} like ? 
      ''',
      whereArgs: ['$datetime%'],
    );
    return list;
  }

  /// 新增心情详情
  Future<bool> insertMood(MoodData moodData) async {
    final db = await database;
    final int result =
        await db.insert(TableMoodInfo.tableName, moodData.toJson());
    return result > 0;
  }

  /// 修改心情详情
  Future<bool> updateMood(MoodData moodData) async {
    final db = await database;
    final int result = await db.update(
      TableMoodInfo.tableName,
      moodData.toJson(),
      where: '${TableMoodInfo.fieldMoodId} = ?',
      whereArgs: [moodData.moodId],
    );
    return result > 0;
  }

  /// 删除心情
  Future<bool> deleteMood(MoodData moodData) async {
    final db = await database;
    final int result = await db.delete(
      TableMoodInfo.tableName,
      where: '${TableMoodInfo.fieldMoodId} = ?',
      whereArgs: [moodData.moodId],
    );
    return result > 0;
  }

  /// 查询所有已记录心情的日期
  Future<List> selectMoodRecordDate() async {
    final db = await database;
    final List list = await db.rawQuery('''
      SELECT 
        DISTINCT DATE(${TableMoodInfo.fieldCreateTime}) as recordDate,
        ${TableMoodInfo.fieldIcon} 
      FROM ${TableMoodInfo.tableName} 
      group by recordDate 
    ''');
    return list;
  }

  /// 查询所有心情详情
  Future<List> selectAllMood() async {
    final db = await database;
    final List list = await db.query(
      TableMoodInfo.tableName,
      orderBy: '${TableMoodInfo.fieldCreateTime} desc',
    );
    return list;
  }

  /*** 心情类别相关 ***/

  /// 查询所有心情类别
  Future<List> selectMoodCategoryAll() async {
    final db = await database;
    final List list = await db.query(TableMoodInfoCategory.tableName);
    return list;
  }

  /// 设置默认心情类别
  Future<bool> insertMoodCategoryDefault(
    MoodCategoryData moodCategoryData,
  ) async {
    final db = await database;
    final int result = await db.insert(
      TableMoodInfoCategory.tableName,
      moodCategoryData.toJson(),
    );
    return result > 0;
  }

  /*** 统计相关 ***/

  /// 统计-APP累计记录天数
  Future<List> selectAPPUsageDays() async {
    final db = await database;
    final List days = await db.rawQuery(
      'SELECT count(DISTINCT DATE(${TableMoodInfo.fieldCreateTime})) as dayCount FROM ${TableMoodInfo.tableName}',
    );
    return days;
  }

  /// 统计-APP累计记录条数
  Future<List> selectAPPMoodCount() async {
    final db = await database;
    final List count = await db.rawQuery(
      'SELECT count(${TableMoodInfo.fieldMoodId}) as moodCount FROM ${TableMoodInfo.tableName}',
    );
    return count;
  }

  /// 统计-平均情绪波动
  Future<List> selectMoodScoreAverage() async {
    final db = await database;
    final List count = await db.rawQuery('''
      SELECT 
        (sum(${TableMoodInfo.fieldScore})/count(${TableMoodInfo.fieldMoodId})) as moodScoreAverage 
      FROM ${TableMoodInfo.tableName}
    ''');
    return count;
  }

  /// 统计-按日期获取平均情绪波动
  ///
  /// [datetime] 日期平均情绪波动 例如 2022-01-01
  ///
  Future<List> selectDateMoodScoreAverage(String datetime) async {
    final db = await database;
    final List score = await db.rawQuery(
      '''
        SELECT 
          (sum(${TableMoodInfo.fieldScore})/count(${TableMoodInfo.fieldMoodId})) as moodScoreAverage 
        FROM ${TableMoodInfo.tableName} 
        WHERE ${TableMoodInfo.fieldCreateTime} like ?
      ''',
      ['$datetime%'],
    );
    return score;
  }

  /// 统计-按日期时间段获取心情数量统计
  ///
  /// [startTime] 开始时间 例如 2022-01-01 00:00:00
  ///
  /// [endTime] 结束时间 例如 2022-01-01 23:59:59
  Future<List> selectDateMoodCount(String startTime, String endTime) async {
    final db = await database;
    final List count = await db.rawQuery(
      '''
        SELECT 
          ${TableMoodInfo.fieldIcon},
          ${TableMoodInfo.fieldTitle},
          count(${TableMoodInfo.fieldMoodId}) as count 
        FROM ${TableMoodInfo.tableName} 
        WHERE ${TableMoodInfo.fieldCreateTime} >= ? and 
              ${TableMoodInfo.fieldCreateTime} <= ? 
        group by ${TableMoodInfo.fieldTitle} 
        order by count asc
      ''',
      [startTime, endTime],
    );
    return count;
  }
}
