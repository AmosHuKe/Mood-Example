import 'dart:convert';
import '../../../shared/utils/log_utils.dart';
import '../../../shared/utils/result.dart';
import '../../models/statistic/statistic_model.dart';
import '../../repositories/statistic/statistic_repository.dart';

class StatisticUseCase {
  StatisticUseCase({required StatisticRepository statisticRepository})
    : _statisticRepository = statisticRepository;

  final StatisticRepository _statisticRepository;

  /// 获取 App 累计记录天数
  Future<Result<int>> getAppUsageDays() async {
    final result = await _statisticRepository.getAppUsageDays();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<int>():
        return .success(result.value);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取 App 累计记录条数
  Future<Result<int>> getAppMoodCount() async {
    final result = await _statisticRepository.getAppMoodCount();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<int>():
        return .success(result.value);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取平均情绪波动
  Future<Result<int>> getMoodScoreAverage() async {
    final result = await _statisticRepository.getMoodScoreAverage();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<int>():
        return .success(result.value);
      case Error<int>():
        return .error(result.error);
    }
  }

  /// 获取近日情绪波动统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodScoreAverageRecentlyModel>>> getMoodScoreAverageRecently(
    int days,
  ) async {
    final result = await _statisticRepository.getMoodScoreAverageRecently(days);
    switch (result) {
      case Success<List<StatisticMoodScoreAverageRecentlyModel>>():
        if (Log.isDebug) {
          Log.instance.resultStackTraceLog(StackTrace.current, result, jsonEncode(result.value));
        }
        return .success(result.value);
      case Error<List<StatisticMoodScoreAverageRecentlyModel>>():
        if (Log.isDebug) {
          Log.instance.resultStackTraceLog(StackTrace.current, result);
        }
        return .error(result.error);
    }
  }

  /// 获取近日心情数量统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodCountRecentlyModel>>> getMoodCountRecently(int days) async {
    final result = await _statisticRepository.getMoodCountRecently(days);
    switch (result) {
      case Success<List<StatisticMoodCountRecentlyModel>>():
        if (Log.isDebug) {
          Log.instance.resultStackTraceLog(StackTrace.current, result, jsonEncode(result.value));
        }
        return .success(result.value);
      case Error<List<StatisticMoodCountRecentlyModel>>():
        if (Log.isDebug) {
          Log.instance.resultStackTraceLog(StackTrace.current, result);
        }
        return .error(result.error);
    }
  }
}
