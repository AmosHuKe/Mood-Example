import 'package:flutter/cupertino.dart';

import 'package:moodexample/models/statistic/statistic_model.dart';
import 'package:moodexample/services/statistic/statistic_service.dart';

/// 统计相关
class StatisticProvider extends ChangeNotifier {
  /// 统计的天数
  int _moodDays = 7;

  /// APP累计记录天数
  int _daysCount = 0;

  /// APP累计记录条数
  int _moodCount = 0;

  /// 平均情绪波动
  int _moodScoreAverage = 0;

  /// 近日情绪波动
  List<StatisticMoodScoreAverageRecentlyData> _moodScoreAverageRecently = [];

  /// 近日心情数量统计
  List<StatisticDateMoodCountData> _dateMoodCount = [];

  /// 获取APP累计使用天数
  void loadDaysCount() async {
    daysCount = await StatisticService.getAPPUsageDays();
  }

  /// 获取APP累计记录条数
  void loadMoodCount() async {
    moodCount = await StatisticService.getAPPMoodCount();
  }

  /// 获取平均情绪波动
  void loadMoodScoreAverage() async {
    moodScoreAverage = await StatisticService.getMoodScoreAverage();
  }

  /// 获取近日情绪波动
  void loadMoodScoreAverageRecently({int days = 7}) async {
    moodScoreAverageRecently =
        await StatisticService.getMoodScoreAverageRecently(days: days);
  }

  /// 获取近日心情数量统计
  void loadDateMoodCount({int days = 7}) async {
    dateMoodCount = await StatisticService.getDateMoodCount(days: days);
  }

  /// 赋值统计的天数
  set moodDays(int moodDays) {
    _moodDays = moodDays;
    notifyListeners();
  }

  /// 赋值APP累计使用天数
  set daysCount(int daysCount) {
    _daysCount = daysCount;
    notifyListeners();
  }

  /// 赋值APP累计记录条数
  set moodCount(int moodCount) {
    _moodCount = moodCount;
    notifyListeners();
  }

  /// 赋值平均情绪波动
  set moodScoreAverage(int moodScoreAverage) {
    _moodScoreAverage = moodScoreAverage;
    notifyListeners();
  }

  /// 赋值近日情绪波动
  set moodScoreAverageRecently(
    List<StatisticMoodScoreAverageRecentlyData> moodScoreAverageRecently,
  ) {
    _moodScoreAverageRecently = moodScoreAverageRecently;
    notifyListeners();
  }

  /// 赋值近日心情数量统计
  set dateMoodCount(List<StatisticDateMoodCountData> dateMoodCount) {
    _dateMoodCount = dateMoodCount;
    notifyListeners();
  }

  /// 统计数据
  int get moodDays => _moodDays;
  int get daysCount => _daysCount;
  int get moodCount => _moodCount;
  int get moodScoreAverage => _moodScoreAverage;
  List<StatisticMoodScoreAverageRecentlyData> get moodScoreAverageRecently =>
      _moodScoreAverageRecently;
  List<StatisticDateMoodCountData> get dateMoodCount => _dateMoodCount;
}
