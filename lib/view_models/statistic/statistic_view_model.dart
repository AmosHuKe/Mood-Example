import 'package:flutter/cupertino.dart';

/// 统计相关
class StatisticViewModel extends ChangeNotifier {
  /// 统计的天数
  int _moodDays = 7;

  /// APP累计记录天数
  int _daysCount = 0;

  /// APP累计记录条数
  int _moodCount = 0;

  /// 平均情绪波动
  int _moodScoreAverage = 0;

  /// 近日情绪波动
  List<Map<String, dynamic>> _moodScoreAverageRecently = [];

  /// 近日心情数量统计
  List<dynamic> _dateMoodCount = [];

  /// 赋值统计的天数
  setMoodDays(int moodDays) {
    _moodDays = 7;
    _moodDays = moodDays;
  }

  /// 赋值APP累计使用天数
  setDaysCount(int daysCount) {
    _daysCount = 0;
    _daysCount = daysCount;
    notifyListeners();
  }

  /// 赋值APP累计记录条数
  setMoodCount(int moodCount) {
    _moodCount = 0;
    _moodCount = moodCount;
    notifyListeners();
  }

  /// 赋值平均情绪波动
  setMoodScoreAverage(int moodScoreAverage) {
    _moodScoreAverage = 0;
    _moodScoreAverage = moodScoreAverage;
    notifyListeners();
  }

  /// 赋值近日情绪波动
  setMoodScoreAverageRecently(
      List<Map<String, dynamic>> moodScoreAverageRecently) {
    _moodScoreAverageRecently = [];
    _moodScoreAverageRecently = moodScoreAverageRecently;
    notifyListeners();
  }

  /// 赋值近日心情数量统计
  setDateMoodCount(List<dynamic> dateMoodCount) {
    _dateMoodCount = [];
    _dateMoodCount = dateMoodCount;
    notifyListeners();
  }

  /// 统计数据
  int get moodDays => _moodDays;
  int get daysCount => _daysCount;
  int get moodCount => _moodCount;
  int get moodScoreAverage => _moodScoreAverage;
  List<Map<String, dynamic>> get moodScoreAverageRecently =>
      _moodScoreAverageRecently;
  List<dynamic> get dateMoodCount => _dateMoodCount;
}
