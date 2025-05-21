import '../../../domain/models/mood/mood_data_model.dart';
import '../../database/database.dart';
import '../../database/tables/mood_info.dart';

class MoodDataDao {
  MoodDataDao({required DB database}) : _database = database;

  final DB _database;

  /// 查询心情详情
  ///
  /// - [datetime] 查询日期 (2022-01-04)
  Future<List<Map<String, Object?>>> getMoodData(String datetime) async {
    final db = await _database.database;
    final list = await db.query(
      MoodInfo.tableName,
      orderBy: '${MoodInfo.create_time} asc, ${MoodInfo.mood_id} desc',
      where: '${MoodInfo.create_time} like ?',
      whereArgs: ['$datetime%'],
    );
    return list;
  }

  /// 新增心情详情
  Future<bool> addMoodData(MoodDataModel moodData) async {
    final db = await _database.database;
    final result = await db.insert(MoodInfo.tableName, moodData.toJson());
    return result > 0;
  }

  /// 修改心情详情
  Future<bool> editMoodData(MoodDataModel moodData) async {
    final db = await _database.database;
    final result = await db.update(
      MoodInfo.tableName,
      moodData.toJson(),
      where: '${MoodInfo.mood_id} = ?',
      whereArgs: [moodData.mood_id],
    );
    return result > 0;
  }

  /// 删除心情详情
  ///
  /// - [moodId] 心情 ID
  Future<bool> deleteMoodData(int moodId) async {
    final db = await _database.database;
    final result = await db.delete(
      MoodInfo.tableName,
      where: '${MoodInfo.mood_id} = ?',
      whereArgs: [moodId],
    );
    return result > 0;
  }

  /// 查询所有心情数据的记录日期数据
  Future<List<Map<String, Object?>>> getMoodRecordDateAll() async {
    final db = await _database.database;
    final list = await db.rawQuery('''
      select 
        distinct date(${MoodInfo.create_time}) as record_date,
        ${MoodInfo.icon} 
      from ${MoodInfo.tableName} 
      group by record_date 
    ''');
    return list;
  }
}
