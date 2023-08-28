///
import 'package:intl/intl.dart';

///
import 'package:moodexample/db/db.dart';
import 'package:moodexample/common/utils.dart';

///
import 'package:moodexample/providers/statistic/statistic_provider.dart';

/// 统计相关
class StatisticService {
  /// 获取APP累计记录天数
  static Future<void> getAPPUsageDays(
    StatisticProvider statisticProvider,
  ) async {
    // 查询
    final list = await DB.db.selectAPPUsageDays();
    print('获取APP使用天数$list');
    final int count = list[0]['dayCount'] ?? 0;
    // 赋值
    statisticProvider.daysCount = count;
  }

  /// 获取APP累计记录条数
  static Future<void> getAPPMoodCount(
    StatisticProvider statisticProvider,
  ) async {
    // 查询
    final list = await DB.db.selectAPPMoodCount();
    print('APP累计记录条数$list');
    final int count = list[0]['moodCount'] ?? 0;
    // 赋值
    statisticProvider.moodCount = count;
  }

  /// 获取平均情绪波动
  static Future<void> getMoodScoreAverage(
    StatisticProvider statisticProvider,
  ) async {
    // 查询
    final list = await DB.db.selectMoodScoreAverage();
    print('平均情绪波动$list');
    final int count = list[0]['moodScoreAverage'] ?? 0;
    // 赋值
    statisticProvider.moodScoreAverage = count;
  }

  /// 获取近日情绪波动
  ///
  /// [days] 往前获取的天数
  static Future<void> getMoodScoreAverageRecently(
    StatisticProvider statisticProvider, {
    int days = 7,
  }) async {
    /// 数据
    late final List<Map<String, dynamic>> dataList = [];
    final nowDate = DateTime.parse(getDatetimeNow('yyyy-MM-dd'));
    // 获取近7日日期
    for (int i = (days - 1); i >= 0; i--) {
      late final String date =
          DateFormat('yyyy-MM-dd').format(nowDate.subtract(Duration(days: i)));
      // 查询
      final list = await DB.db.selectDateMoodScoreAverage(date);
      final int count = list[0]['moodScoreAverage'] ?? 0;
      dataList.add({
        'datetime': date,
        'score': count,
      });
    }
    print('近$days日情绪波动$dataList');

    // 赋值
    statisticProvider.moodScoreAverageRecently = dataList;
  }

  /// 获取近7日心情数量统计
  ///
  /// [days] 往前获取的天数
  static Future<void> getDateMoodCount(
    StatisticProvider statisticProvider, {
    int days = 7,
  }) async {
    /// 数据
    final nowDate = DateTime.parse(getDatetimeNow('yyyy-MM-dd'));
    // 获取近7日日期
    final String startTime =
        "${DateFormat("yyyy-MM-dd").format(nowDate.subtract(Duration(days: days)))} 00:00:00";
    final String endTime =
        "${DateFormat("yyyy-MM-dd").format(nowDate)} 23:59:59";
    // 查询
    final list = await DB.db.selectDateMoodCount(startTime, endTime);
    print('近$days日心情数量统计$list');

    // 赋值
    statisticProvider.dateMoodCount = list;
  }
}
