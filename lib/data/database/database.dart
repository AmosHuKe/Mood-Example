import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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

  Future<void> close() async => _instance?.close();

  /// 创建
  Future<void> _onCreate(Database db, int newVersion) async {
    print('数据库 _onCreate 版本：$newVersion');
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
    print('数据库 _onUpgrade 旧版本：$oldVersion');
    print('数据库 _onUpgrade 新版本：$newVersion');

    final batch = db.batch();

    /// 升级逻辑

    await batch.commit();
  }
}
