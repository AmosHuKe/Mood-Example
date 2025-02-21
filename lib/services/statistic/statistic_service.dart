import 'package:intl/intl.dart';
import '../../common/utils.dart';
import '../../database/database.dart';
import '../../models/statistic/statistic_model.dart';

/// 统计相关
class StatisticService {
  const StatisticService._();

  /// 获取APP累计记录天数
  static Future<int> getAPPUsageDays() async {
    final list = await DB.instance.selectAppUsageDays();
    print('获取APP使用天数$list');
    return int.tryParse(list[0]['dayCount'].toString()) ?? 0;
  }

  /// 获取APP累计记录条数
  static Future<int> getAPPMoodCount() async {
    final list = await DB.instance.selectAppMoodCount();
    print('APP累计记录条数$list');
    return int.tryParse(list[0]['moodCount'].toString()) ?? 0;
  }

  /// 获取平均情绪波动
  static Future<int> getMoodScoreAverage() async {
    final list = await DB.instance.selectMoodScoreAverage();
    print('平均情绪波动$list');
    return int.tryParse(list[0]['moodScoreAverage'].toString()) ?? 0;
  }

  /// 获取近日情绪波动
  ///
  /// [days] 往前获取的天数
  static Future<List<StatisticMoodScoreAverageRecentlyData>> getMoodScoreAverageRecently({
    int days = 7,
  }) async {
    /// 数据
    final dataList = <StatisticMoodScoreAverageRecentlyData>[];
    final nowDate = DateTime.parse(Utils.getDatetimeNow('yyyy-MM-dd'));
    // 获取近日日期
    for (var i = days - 1; i >= 0; i--) {
      final date = DateFormat('yyyy-MM-dd').format(nowDate.subtract(Duration(days: i)));
      // 查询
      final list = await DB.instance.selectDateMoodScoreAverage(date);
      final score = int.tryParse(list[0]['moodScoreAverage'].toString()) ?? 0;
      dataList.add(StatisticMoodScoreAverageRecentlyData(datetime: date, score: score));
    }
    return dataList;
  }

  /// 获取近日心情数量统计
  ///
  /// [days] 往前获取的天数
  static Future<List<StatisticDateMoodCountData>> getDateMoodCount({int days = 7}) async {
    /// 数据
    final dataList = <StatisticDateMoodCountData>[];
    final nowDate = DateTime.parse(Utils.getDatetimeNow('yyyy-MM-dd'));
    // 获取近7日日期
    final beginTime =
        "${DateFormat("yyyy-MM-dd").format(nowDate.subtract(Duration(days: days)))} 00:00:00";
    final endTime = "${DateFormat("yyyy-MM-dd").format(nowDate)} 23:59:59";
    // 查询
    final list = await DB.instance.selectDateMoodCount(beginTime, endTime);
    for (final value in list) {
      dataList.add(StatisticDateMoodCountData.fromJson(value));
    }
    return dataList;
  }
}
