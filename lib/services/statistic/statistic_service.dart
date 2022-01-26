///
import 'package:intl/intl.dart';

///
import 'package:moodexample/db/db.dart';
import 'package:moodexample/common/utils.dart';

///
import 'package:moodexample/view_models/statistic/statistic_view_model.dart';

///
class StatisticService {
  /// 获取APP累计记录天数
  static Future<void> getAPPUsageDays(
      StatisticViewModel statisticViewModel) async {
    // 查询
    final list = await DB.db.selectAPPUsageDays();
    print("获取APP使用天数" + list.toString());
    final int count = list[0]['dayCount'] ?? 0;
    // 赋值
    statisticViewModel.setDaysCount(count);
  }

  /// 获取APP累计记录条数
  static Future<void> getAPPMoodCount(
      StatisticViewModel statisticViewModel) async {
    // 查询
    final list = await DB.db.selectAPPMoodCount();
    print("APP累计记录条数" + list.toString());
    final int count = list[0]['moodCount'] ?? 0;
    // 赋值
    statisticViewModel.setMoodCount(count);
  }

  /// 获取平均情绪波动
  static Future<void> getMoodScoreAverage(
      StatisticViewModel statisticViewModel) async {
    // 查询
    final list = await DB.db.selectMoodScoreAverage();
    print("平均情绪波动" + list.toString());
    final int count = list[0]['moodScoreAverage'] ?? 0;
    // 赋值
    statisticViewModel.setMoodScoreAverage(count);
  }

  /// 获取近日情绪波动
  ///
  /// @param StatisticViewModel statisticViewModel
  ///
  /// @param {int} days 往前获取的天数
  static Future<void> getMoodScoreAverageRecently(
      StatisticViewModel statisticViewModel,
      {int days = 7}) async {
    /// 数据
    late List<Map<String, dynamic>> dataList = [];
    final nowDate = DateTime.parse(getDatetimeNow("yyyy-MM-dd"));
    // 获取近7日日期
    for (int i = (days - 1); i >= 0; i--) {
      late String date =
          DateFormat("yyyy-MM-dd").format(nowDate.subtract(Duration(days: i)));
      // 查询
      final list = await DB.db.selectDateMoodScoreAverage(date);
      final int count = list[0]['moodScoreAverage'] ?? 0;
      dataList.add({
        "datetime": date,
        "score": count,
      });
    }
    print("近$days日情绪波动" + dataList.toString());

    // 赋值
    statisticViewModel.setMoodScoreAverageRecently(dataList);
  }

  /// 获取近7日心情数量统计
  ///
  /// @param StatisticViewModel statisticViewModel
  ///
  /// @param {int} days 往前获取的天数
  static Future<void> getDateMoodCount(StatisticViewModel statisticViewModel,
      {int days = 7}) async {
    /// 数据
    final nowDate = DateTime.parse(getDatetimeNow("yyyy-MM-dd"));
    // 获取近7日日期
    final String startTime = DateFormat("yyyy-MM-dd")
            .format(nowDate.subtract(Duration(days: days))) +
        " 00:00:00";
    final String endTime =
        DateFormat("yyyy-MM-dd").format(nowDate) + " 23:59:59";
    // 查询
    final list = await DB.db.selectDateMoodCount(startTime, endTime);
    print("近$days日心情数量统计" + list.toString());

    // 赋值
    statisticViewModel.setDateMoodCount(list);
  }
}
