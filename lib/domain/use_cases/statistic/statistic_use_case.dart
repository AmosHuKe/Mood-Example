import '../../../utils/result.dart';
import '../../models/statistic/statistic_model.dart';
import '../../repositories/statistic/statistic_repository.dart';

class StatisticUseCase {
  StatisticUseCase({required StatisticRepository statisticRepository})
    : _statisticRepository = statisticRepository;

  final StatisticRepository _statisticRepository;

  /// 获取 App 累计记录天数
  Future<Result<int>> getAppUsageDays() async {
    return _statisticRepository.getAppUsageDays();
  }

  /// 获取 App 累计记录条数
  Future<Result<int>> getAppMoodCount() async {
    return _statisticRepository.getAppMoodCount();
  }

  /// 获取平均情绪波动
  Future<Result<int>> getMoodScoreAverage() async {
    return _statisticRepository.getMoodScoreAverage();
  }

  /// 获取近日情绪波动统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodScoreAverageRecentlyModel>>> getMoodScoreAverageRecently(
    int days,
  ) async {
    return _statisticRepository.getMoodScoreAverageRecently(days);
  }

  /// 获取近日心情数量统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodCountRecentlyModel>>> getMoodCountRecently(int days) async {
    return _statisticRepository.getMoodCountRecently(days);
  }
}
