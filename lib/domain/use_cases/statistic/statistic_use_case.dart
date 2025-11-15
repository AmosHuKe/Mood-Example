import 'dart:convert';
import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../models/statistic/statistic_model.dart';
import '../../repositories/statistic/statistic_repository.dart';

class StatisticUseCase {
  StatisticUseCase({required StatisticRepository statisticRepository})
    : _statisticRepository = statisticRepository;

  final StatisticRepository _statisticRepository;

  void _log(Object? value, {Result<Object?> result = const .success(null)}) {
    LogUtils.log('${'[${this.runtimeType}]'.blue} ${value}', result: result);
  }

  /// 获取 App 累计记录天数
  Future<Result<int>> getAppUsageDays() async {
    final result = await _statisticRepository.getAppUsageDays();
    switch (result) {
      case Success<int>():
        _log('${getAppUsageDays.toString()} ${result.value}', result: result);
        return .success(result.value);
      case Error<int>():
        _log('${getAppUsageDays.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取 App 累计记录条数
  Future<Result<int>> getAppMoodCount() async {
    final result = await _statisticRepository.getAppMoodCount();
    switch (result) {
      case Success<int>():
        _log('${getAppMoodCount.toString()} ${result.value}', result: result);
        return .success(result.value);
      case Error<int>():
        _log('${getAppMoodCount.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取平均情绪波动
  Future<Result<int>> getMoodScoreAverage() async {
    final result = await _statisticRepository.getMoodScoreAverage();
    switch (result) {
      case Success<int>():
        _log('${getMoodScoreAverage.toString()} ${result.value}', result: result);
        return .success(result.value);
      case Error<int>():
        _log('${getMoodScoreAverage.toString()} ${result.error}', result: result);
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
        _log(
          '${getMoodScoreAverageRecently.toString()} ${jsonEncode(result.value)}',
          result: result,
        );
        return .success(result.value);
      case Error<List<StatisticMoodScoreAverageRecentlyModel>>():
        _log('${getMoodScoreAverageRecently.toString()} ${result.error}', result: result);
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
        _log('${getMoodCountRecently.toString()} ${jsonEncode(result.value)}', result: result);
        return .success(result.value);
      case Error<List<StatisticMoodCountRecentlyModel>>():
        _log('${getMoodCountRecently.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }
}
