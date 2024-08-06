import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:moodexample/db/db.dart';
import 'package:moodexample/common/utils.dart';

import 'package:moodexample/models/statistic/statistic_model.dart';

/// 统计相关
class StatisticService {
  /// 获取APP累计记录天数
  static Future<int> getAPPUsageDays() async {
    final list = await DB.instance.selectAPPUsageDays();
    print('获取APP使用天数$list');
    return list[0]['dayCount'] ?? 0;
  }

  /// 获取APP累计记录条数
  static Future<int> getAPPMoodCount() async {
    final list = await DB.instance.selectAPPMoodCount();
    print('APP累计记录条数$list');
    return list[0]['moodCount'] ?? 0;
  }

  /// 获取平均情绪波动
  static Future<int> getMoodScoreAverage() async {
    final list = await DB.instance.selectMoodScoreAverage();
    print('平均情绪波动$list');
    return list[0]['moodScoreAverage'] ?? 0;
  }

  /// 获取近日情绪波动
  ///
  /// [days] 往前获取的天数
  static Future<List<StatisticMoodScoreAverageRecentlyData>>
      getMoodScoreAverageRecently({int days = 7}) async {
    /// 数据
    final List<StatisticMoodScoreAverageRecentlyData> dataList = [];
    final nowDate = DateTime.parse(getDatetimeNow('yyyy-MM-dd'));
    // 获取近日日期
    for (int i = days - 1; i >= 0; i--) {
      final String date =
          DateFormat('yyyy-MM-dd').format(nowDate.subtract(Duration(days: i)));
      // 查询
      final list = await DB.instance.selectDateMoodScoreAverage(date);
      final int count = list[0]['moodScoreAverage'] ?? 0;
      dataList.add(
        statisticMoodScoreAverageRecentlyDataFromJson(
          json.encode({'datetime': date, 'score': count}),
        ),
      );
    }
    return dataList;
  }

  /// 获取近日心情数量统计
  ///
  /// [days] 往前获取的天数
  static Future<List<StatisticDateMoodCountData>> getDateMoodCount({
    int days = 7,
  }) async {
    /// 数据
    final List<StatisticDateMoodCountData> dataList = [];
    final nowDate = DateTime.parse(getDatetimeNow('yyyy-MM-dd'));
    // 获取近7日日期
    final String startTime =
        "${DateFormat("yyyy-MM-dd").format(nowDate.subtract(Duration(days: days)))} 00:00:00";
    final String endTime =
        "${DateFormat("yyyy-MM-dd").format(nowDate)} 23:59:59";
    // 查询
    final list = await DB.instance.selectDateMoodCount(startTime, endTime);
    for (final value in list) {
      dataList.add(statisticDateMoodCountDataFromJson(json.encode(value)));
    }
    return dataList;
  }
}
