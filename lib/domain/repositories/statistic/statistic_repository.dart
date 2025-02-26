// dart format width=200
import '../../../utils/result.dart';
import '../../models/statistic/statistic_model.dart';

abstract class StatisticRepository {
  /// 获取 App 累计记录天数
  Future<Result<int>> getAppUsageDays();

  /// 获取 App 累计记录条数
  Future<Result<int>> getAppMoodCount();

  /// 获取平均情绪波动
  Future<Result<int>> getMoodScoreAverage();

  /// 获取近日情绪波动统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodScoreAverageRecentlyModel>>> getMoodScoreAverageRecently(int days);

  /// 获取近日心情数量统计
  ///
  /// - [days] 获取的天数
  Future<Result<List<StatisticMoodCountRecentlyModel>>> getMoodCountRecently(int days);
}
