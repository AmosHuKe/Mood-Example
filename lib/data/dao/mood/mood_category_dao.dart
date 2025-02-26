import '../../../domain/models/mood/mood_category_model.dart';
import '../../database/database.dart';
import '../../database/shared_preferences_db.dart';
import '../../database/tables/mood_info_category.dart';

class MoodCategoryDao {
  MoodCategoryDao({required DB database, required SharedPreferencesDB sharedPreferencesDB})
    : _database = database,
      _sharedPreferencesDB = sharedPreferencesDB;

  final DB _database;
  final SharedPreferencesDB _sharedPreferencesDB;

  /// 查询所有心情类别
  Future<List<Map<String, Object?>>> getMoodCategoryAll() async {
    final db = await _database.database;
    final list = await db.query(MoodInfoCategory.tableName);
    return list;
  }

  /// 设置默认心情类别
  Future<bool> setMoodCategoryDefault(List<MoodCategoryModel> moodCategoryList) async {
    final db = await _database.database;
    var result = true;
    await db.transaction((txn) async {
      for (var i = 0; i < moodCategoryList.length; i++) {
        final dbResult = await txn.insert(MoodInfoCategory.tableName, moodCategoryList[i].toJson());
        if (dbResult <= 0) result = false;
      }
    });
    return result;
  }

  /// 设置 是否填充完成【心情类别】表默认值
  Future<void> setInitMoodCategoryDefaultType(bool value) async {
    await _sharedPreferencesDB.sps.setBool(SharedPreferencesKey.initMoodCategoryDefaultType, value);
  }

  /// 获取 是否填充完成【心情类别】表默认值
  Future<bool?> getInitMoodCategoryDefaultType() async {
    return _sharedPreferencesDB.sps.getBool(SharedPreferencesKey.initMoodCategoryDefaultType);
  }
}
