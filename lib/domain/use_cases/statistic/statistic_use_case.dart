import 'dart:convert';
import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../models/statistic/statistic_model.dart';
import '../../repositories/statistic/statistic_repository.dart';

class StatisticUseCase {
  StatisticUseCase({required StatisticRepository statisticRepository})
    : _statisticRepository = statisticRepository;

  final StatisticRepository _statisticRepository;

  /// 获取 App 累计记录天数
  Future<Result<int>> getAppUsageDays() async {
    final result = await _statisticRepository.getAppUsageDays();
    switch (result) {
      case Success<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .success(result.value);
      case Error<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 获取 App 累计记录条数
  Future<Result<int>> getAppMoodCount() async {
    final result = await _statisticRepository.getAppMoodCount();
    switch (result) {
      case Success<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .success(result.value);
      case Error<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 获取平均情绪波动
  Future<Result<int>> getMoodScoreAverage() async {
    final result = await _statisticRepository.getMoodScoreAverage();
    switch (result) {
      case Success<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .success(result.value);
      case Error<int>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
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
        LogUtils.stackTraceLog(
          StackTrace.current,
          result: result,
          message: jsonEncode(result.value),
        );
        return .success(result.value);
      case Error<List<StatisticMoodScoreAverageRecentlyModel>>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
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
        LogUtils.stackTraceLog(
          StackTrace.current,
          result: result,
          message: jsonEncode(result.value),
        );
        return .success(result.value);
      case Error<List<StatisticMoodCountRecentlyModel>>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }
}
