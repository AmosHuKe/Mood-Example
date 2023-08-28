import 'package:flutter/material.dart';

///
import 'package:intl/intl.dart';

///
import 'package:moodexample/db/db.dart';
import 'package:moodexample/common/utils.dart';

///
import 'package:moodexample/view_models/statistic/statistic_view_model.dart';

/// 统计相关
class StatisticService {
  /// 获取APP累计记录天数
  static Future<void> getAPPUsageDays(
    StatisticViewModel statisticViewModel,
  ) async {
    // 查询
    final list = await DB.db.selectAPPUsageDays();
    debugPrint('获取APP使用天数$list');
    final int count = list[0]['dayCount'] ?? 0;
    // 赋值
    statisticViewModel.daysCount = count;
  }

  /// 获取APP累计记录条数
  static Future<void> getAPPMoodCount(
    StatisticViewModel statisticViewModel,
  ) async {
    // 查询
    final list = await DB.db.selectAPPMoodCount();
    debugPrint('APP累计记录条数$list');
    final int count = list[0]['moodCount'] ?? 0;
    // 赋值
    statisticViewModel.moodCount = count;
  }

  /// 获取平均情绪波动
  static Future<void> getMoodScoreAverage(
    StatisticViewModel statisticViewModel,
  ) async {
    // 查询
    final list = await DB.db.selectMoodScoreAverage();
    debugPrint('平均情绪波动$list');
    final int count = list[0]['moodScoreAverage'] ?? 0;
    // 赋值
    statisticViewModel.moodScoreAverage = count;
  }

  /// 获取近日情绪波动
  ///
  /// [days] 往前获取的天数
  static Future<void> getMoodScoreAverageRecently(
    StatisticViewModel statisticViewModel, {
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
    debugPrint('近$days日情绪波动$dataList');

    // 赋值
    statisticViewModel.moodScoreAverageRecently = dataList;
  }

  /// 获取近7日心情数量统计
  ///
  /// [days] 往前获取的天数
  static Future<void> getDateMoodCount(
    StatisticViewModel statisticViewModel, {
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
    debugPrint('近$days日心情数量统计$list');

    // 赋值
    statisticViewModel.dateMoodCount = list;
  }
}
