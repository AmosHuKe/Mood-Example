import 'package:flutter/widgets.dart';
import '../../utils/result.dart';
import '../../domain/models/statistic/statistic_model.dart';
import '../../domain/use_cases/statistic/statistic_use_case.dart';

class StatisticViewModel extends ChangeNotifier {
  StatisticViewModel({required StatisticUseCase statisticUseCase})
    : _statisticUseCase = statisticUseCase {
    load();
  }

  final StatisticUseCase _statisticUseCase;

  /// 筛选统计天数
  static const _statisticFilterDays = <int>[7, 15, 30];
  List<int> get statisticFilterDays => _statisticFilterDays;

  /// 选择的统计天数
  int _selectDays = 7;
  int get selectDays => _selectDays;
  set selectDays(int value) {
    _selectDays = value;
    notifyListeners();
  }

  /// App 累计记录天数
  int _appUsageDays = 0;
  int get appUsageDays => _appUsageDays;

  /// App 累计记录条数
  int _appMoodCount = 0;
  int get appMoodCount => _appMoodCount;

  /// 平均情绪波动
  int _moodScoreAverage = 0;
  int get moodScoreAverage => _moodScoreAverage;

  /// 近日情绪波动统计
  List<StatisticMoodScoreAverageRecentlyModel> _moodScoreAverageRecently = [];
  List<StatisticMoodScoreAverageRecentlyModel> get moodScoreAverageRecently =>
      _moodScoreAverageRecently;

  /// 近日心情数量统计
  List<StatisticMoodCountRecentlyModel> _moodCountRecently = [];
  List<StatisticMoodCountRecentlyModel> get moodCountRecently => _moodCountRecently;

  Future<void> load() async {
    await loadAppUsageDays();
    await loadAppMoodCount();
    await loadMoodScoreAverage();
    await loadMoodScoreAverageRecently();
    await loadMoodCountRecently();
  }

  /// 获取 App 累计记录天数
  Future<Result<void>> loadAppUsageDays() async {
    final result = await _statisticUseCase.getAppUsageDays();
    switch (result) {
      case Success<int>():
        _appUsageDays = result.value;
        notifyListeners();
        return const .success(null);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取 App 累计记录条数
  Future<Result<void>> loadAppMoodCount() async {
    final result = await _statisticUseCase.getAppMoodCount();
    switch (result) {
      case Success<int>():
        _appMoodCount = result.value;
        notifyListeners();
        return const .success(null);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取平均情绪波动
  Future<Result<void>> loadMoodScoreAverage() async {
    final result = await _statisticUseCase.getMoodScoreAverage();
    switch (result) {
      case Success<int>():
        _moodScoreAverage = result.value;
        notifyListeners();
        return const .success(null);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取近日情绪波动统计
  Future<Result<void>> loadMoodScoreAverageRecently() async {
    final result = await _statisticUseCase.getMoodScoreAverageRecently(_selectDays);
    switch (result) {
      case Success<List<StatisticMoodScoreAverageRecentlyModel>>():
        _moodScoreAverageRecently = result.value;
        notifyListeners();
        return const .success(null);
      case Error<List<StatisticMoodScoreAverageRecentlyModel>>():
        return .error(result.error);
    }
  }

  /// 获取近日心情数量统计
  Future<Result<void>> loadMoodCountRecently() async {
    final result = await _statisticUseCase.getMoodCountRecently(_selectDays);
    switch (result) {
      case Success<List<StatisticMoodCountRecentlyModel>>():
        _moodCountRecently = result.value;
        notifyListeners();
        return const .success(null);
      case Error<List<StatisticMoodCountRecentlyModel>>():
        return .error(result.error);
    }
  }
}
