import '../../../domain/models/mood/mood_data_model.dart';
import '../../database/database.dart';
import '../../database/tables/mood_info.dart';

class DataImportExportDao {
  DataImportExportDao({required DB database}) : _database = database;

  final DB _database;

  /// 查询所有心情详情
  Future<List<Map<String, Object?>>> getMoodDataAll() async {
    final db = await _database.database;
    final list = await db.query(MoodInfo.tableName, orderBy: '${MoodInfo.create_time} desc');
    return list;
  }

  /// 添加心情详细数据
  Future<bool> addMoodDataAll(List<MoodDataModel> moodDataList) async {
    final db = await _database.database;
    var result = true;
    await db.transaction((txn) async {
      for (final moodData in moodDataList) {
        final txnResult = await txn.insert(MoodInfo.tableName, moodData.toJson());
        if (txnResult <= 0) result = false;
      }
    });
    return result;
  }
}
