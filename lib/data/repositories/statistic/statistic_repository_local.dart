import '../../../utils/result.dart';
import '../../../utils/utils.dart';
import '../../../domain/models/statistic/statistic_model.dart';
import '../../../domain/repositories/statistic/statistic_repository.dart';
import '../../dao/statistic/statistic_dao.dart';

class StatisticRepositoryLocal implements StatisticRepository {
  StatisticRepositoryLocal({required StatisticDao statisticDao}) : _statisticDao = statisticDao;

  final StatisticDao _statisticDao;

  @override
  Future<Result<int>> getAppUsageDays() async {
    try {
      final data = await _statisticDao.getAppUsageDays();
      final days = int.tryParse(data[0]['dayCount'].toString()) ?? 0;
      return .success(days);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<int>> getAppMoodCount() async {
    try {
      final data = await _statisticDao.getAppMoodCount();
      final count = int.tryParse(data[0]['moodCount'].toString()) ?? 0;
      return .success(count);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<int>> getMoodScoreAverage() async {
    try {
      final data = await _statisticDao.getMoodScoreAverage();
      final moodScoreAverage = int.tryParse(data[0]['moodScoreAverage'].toString()) ?? 0;
      return .success(moodScoreAverage);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<List<StatisticMoodScoreAverageRecentlyModel>>> getMoodScoreAverageRecently(
    int days,
  ) async {
    try {
      final dataList = <StatisticMoodScoreAverageRecentlyModel>[];
      final nowDatetime = DateTime.now();
      for (var i = days - 1; i >= 0; i--) {
        final datetime = Utils.datetimeFormatToString(nowDatetime.subtract(Duration(days: i)));
        final data = await _statisticDao.getDateMoodScoreAverage(datetime);
        final moodScoreAverage = int.tryParse(data[0]['moodScoreAverage'].toString()) ?? 0;
        dataList.add(.new(datetime: datetime, score: moodScoreAverage));
      }
      return .success(dataList);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<List<StatisticMoodCountRecentlyModel>>> getMoodCountRecently(int days) async {
    try {
      final dataList = <StatisticMoodCountRecentlyModel>[];
      final nowDatetime = DateTime.now();
      // 获取日期
      final beginTime =
          '${Utils.datetimeFormatToString(nowDatetime.subtract(.new(days: days)))} 00:00:00';
      final endTime = '${Utils.datetimeFormatToString(nowDatetime)} 23:59:59';
      final data = await _statisticDao.getMoodCount(beginTime, endTime);
      for (final value in data) {
        dataList.add(.fromJson(value));
      }
      return .success(dataList);
    } on Exception catch (e) {
      return .error(e);
    }
  }
}
