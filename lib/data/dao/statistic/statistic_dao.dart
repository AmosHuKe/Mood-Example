import '../../database/database.dart';
import '../../database/tables/mood_info.dart';

class StatisticDao {
  StatisticDao({required DB database}) : _database = database;

  final DB _database;

  /// App 累计记录天数
  Future<List<Map<String, Object?>>> getAppUsageDays() async {
    final db = await _database.database;
    final days = await db.rawQuery('''
      select
        count(distinct date(${MoodInfo.create_time})) as dayCount 
      from ${MoodInfo.tableName}
    ''');
    return days;
  }

  /// App 累计记录条数
  Future<List<Map<String, Object?>>> getAppMoodCount() async {
    final db = await _database.database;
    final count = await db.rawQuery('''
      select 
        count(${MoodInfo.mood_id}) as moodCount 
      from ${MoodInfo.tableName}
    ''');
    return count;
  }

  /// 平均情绪波动
  Future<List<Map<String, Object?>>> getMoodScoreAverage() async {
    final db = await _database.database;
    final count = await db.rawQuery('''
      select 
        (sum(${MoodInfo.score})/count(${MoodInfo.mood_id})) as moodScoreAverage 
      from ${MoodInfo.tableName}
    ''');
    return count;
  }

  /// 按日期获取平均情绪波动
  ///
  /// - [datetime] 日期平均情绪波动 例如 2022-01-01
  Future<List<Map<String, Object?>>> getDateMoodScoreAverage(String datetime) async {
    final db = await _database.database;
    final score = await db.rawQuery(
      '''
        select 
          (sum(${MoodInfo.score})/count(${MoodInfo.mood_id})) as moodScoreAverage 
        from ${MoodInfo.tableName} 
        where ${MoodInfo.create_time} like ?
      ''',
      ['$datetime%'],
    );
    return score;
  }

  /// 按日期时间段获取心情数量统计
  ///
  /// - [beginTime] 开始时间 例如 2022-01-01 00:00:00
  /// - [endTime] 结束时间 例如 2022-01-01 23:59:59
  Future<List<Map<String, Object?>>> getMoodCount(String beginTime, String endTime) async {
    final db = await _database.database;
    final count = await db.rawQuery(
      '''
        select 
          ${MoodInfo.icon},
          ${MoodInfo.title},
          count(${MoodInfo.mood_id}) as count 
        from ${MoodInfo.tableName} 
        where ${MoodInfo.create_time} >= ? and 
              ${MoodInfo.create_time} <= ? 
        group by ${MoodInfo.title} 
        order by count asc
      ''',
      [beginTime, endTime],
    );
    return count;
  }
}
