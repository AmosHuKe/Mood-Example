import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/mood/mood_category_model.dart';
import '../models/mood/mood_model.dart';

import 'tables/mood_info.dart';
import 'tables/mood_info_category.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  Database? _instance;
  Future<Database> get database async => _instance ??= await createDatabase();

  /// 数据库版本号
  static const int version = 1;

  /// 数据库名称
  static const String databaseName = 'moodDB.db';

  /// 创建
  Future<Database> createDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);
    final db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  Future close() async => _instance?.close();

  /// 创建
  Future<void> _onCreate(Database db, int newVersion) async {
    print('_onCreate 新版本:$newVersion');
    final batch = db.batch();

    /// 心情详细内容表
    batch.execute(MoodInfo.dropTable);
    batch.execute(MoodInfo.createTable);

    /// 心情分类表
    batch.execute(MoodInfoCategory.dropTable);
    batch.execute(MoodInfoCategory.createTable);

    await batch.commit();
  }

  /// 升级
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('_onUpgrade 旧版本:$oldVersion');
    print('_onUpgrade 新版本:$newVersion');

    final batch = db.batch();

    /// 升级逻辑

    await batch.commit();
  }

  /*** 心情详情内容相关 ***/

  /// 查询心情详情
  ///
  /// - [datetime] 查询日期（2022-01-04)
  Future<List<Map<String, Object?>>> selectMood(String datetime) async {
    final db = await database;
    final list = await db.query(
      MoodInfo.tableName,
      orderBy: '${MoodInfo.create_time} asc, ${MoodInfo.mood_id} desc',
      where: '''
        ${MoodInfo.create_time} like ? 
      ''',
      whereArgs: ['$datetime%'],
    );
    return list;
  }

  /// 新增心情详情
  Future<bool> insertMood(MoodData moodData) async {
    final db = await database;
    final result = await db.insert(MoodInfo.tableName, moodData.toJson());
    return result > 0;
  }

  /// 修改心情详情
  Future<bool> updateMood(MoodData moodData) async {
    final db = await database;
    final result = await db.update(
      MoodInfo.tableName,
      moodData.toJson(),
      where: '${MoodInfo.mood_id} = ?',
      whereArgs: [moodData.mood_id],
    );
    return result > 0;
  }

  /// 删除心情
  Future<bool> deleteMood(MoodData moodData) async {
    final db = await database;
    final result = await db.delete(
      MoodInfo.tableName,
      where: '${MoodInfo.mood_id} = ?',
      whereArgs: [moodData.mood_id],
    );
    return result > 0;
  }

  /// 查询所有已记录心情的日期
  Future<List<Map<String, Object?>>> selectMoodRecordDate() async {
    final db = await database;
    final list = await db.rawQuery('''
      SELECT 
        DISTINCT DATE(${MoodInfo.create_time}) as record_date,
        ${MoodInfo.icon} 
      FROM ${MoodInfo.tableName} 
      group by record_date 
    ''');
    return list;
  }

  /// 查询所有心情详情
  Future<List<Map<String, Object?>>> selectAllMood() async {
    final db = await database;
    final list = await db.query(MoodInfo.tableName, orderBy: '${MoodInfo.create_time} desc');
    return list;
  }

  /*** 心情类别相关 ***/

  /// 查询所有心情类别
  Future<List<Map<String, Object?>>> selectMoodCategoryAll() async {
    final db = await database;
    final list = await db.query(MoodInfoCategory.tableName);
    return list;
  }

  /// 设置默认心情类别
  Future<bool> insertMoodCategoryDefault(MoodCategoryData moodCategoryData) async {
    final db = await database;
    final result = await db.insert(MoodInfoCategory.tableName, moodCategoryData.toJson());
    return result > 0;
  }

  /*** 统计相关 ***/

  /// 统计-APP 累计记录天数
  Future<List<Map<String, Object?>>> selectAppUsageDays() async {
    final db = await database;
    final days = await db.rawQuery(
      'SELECT count(DISTINCT DATE(${MoodInfo.create_time})) as dayCount FROM ${MoodInfo.tableName}',
    );
    return days;
  }

  /// 统计-APP 累计记录条数
  Future<List<Map<String, Object?>>> selectAppMoodCount() async {
    final db = await database;
    final count = await db.rawQuery(
      'SELECT count(${MoodInfo.mood_id}) as moodCount FROM ${MoodInfo.tableName}',
    );
    return count;
  }

  /// 统计-平均情绪波动
  Future<List<Map<String, Object?>>> selectMoodScoreAverage() async {
    final db = await database;
    final count = await db.rawQuery('''
      SELECT 
        (sum(${MoodInfo.score})/count(${MoodInfo.mood_id})) as moodScoreAverage 
      FROM ${MoodInfo.tableName}
    ''');
    return count;
  }

  /// 统计-按日期获取平均情绪波动
  ///
  /// - [datetime] 日期平均情绪波动 例如 2022-01-01
  Future<List<Map<String, Object?>>> selectDateMoodScoreAverage(String datetime) async {
    final db = await database;
    final score = await db.rawQuery(
      '''
        SELECT 
          (sum(${MoodInfo.score})/count(${MoodInfo.mood_id})) as moodScoreAverage 
        FROM ${MoodInfo.tableName} 
        WHERE ${MoodInfo.create_time} like ?
      ''',
      ['$datetime%'],
    );
    return score;
  }

  /// 统计-按日期时间段获取心情数量统计
  ///
  /// - [beginTime] 开始时间 例如 2022-01-01 00:00:00
  /// - [endTime] 结束时间 例如 2022-01-01 23:59:59
  Future<List<Map<String, Object?>>> selectDateMoodCount(String beginTime, String endTime) async {
    final db = await database;
    final count = await db.rawQuery(
      '''
        SELECT 
          ${MoodInfo.icon},
          ${MoodInfo.title},
          count(${MoodInfo.mood_id}) as count 
        FROM ${MoodInfo.tableName} 
        WHERE ${MoodInfo.create_time} >= ? and 
              ${MoodInfo.create_time} <= ? 
        group by ${MoodInfo.title} 
        order by count asc
      ''',
      [beginTime, endTime],
    );
    return count;
  }
}
