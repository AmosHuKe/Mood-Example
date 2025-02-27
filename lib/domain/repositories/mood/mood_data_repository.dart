import '../../../utils/result.dart';
import '../../models/mood/mood_data_model.dart';

abstract class MoodDataRepository {
  /// 获取心情数据
  ///
  /// - [dateTime] 当前选择的日期
  Future<Result<List<MoodDataModel>>> getMoodDataByDateTime(DateTime dateTime);

  /// 获取所有心情数据
  /// Future<Result<List<MoodDataModel>>> getMoodDataAll();

  /// 获取所有心情数据的记录日期数据
  Future<Result<List<MoodRecordDateModel>>> getMoodRecordDateAll();

  /// 添加心情详细数据
  Future<Result<bool>> addMoodData(MoodDataModel moodData);

  /// 修改心情详细数据
  Future<Result<bool>> editMoodData(MoodDataModel moodData);

  /// 删除心情详细数据
  ///
  /// - [moodId] 心情 ID
  Future<Result<bool>> deleteMoodData(int moodId);
}
