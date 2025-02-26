import '../../../utils/result.dart';
import '../../models/mood/mood_data_model.dart';
import '../../repositories/mood/mood_data_repository.dart';

class MoodDataUseCase {
  MoodDataUseCase({required MoodDataRepository moodDataRepository})
    : _moodDataRepository = moodDataRepository;

  final MoodDataRepository _moodDataRepository;

  /// 获取心情数据
  ///
  /// - [dateTime] 当前选择的日期
  Future<Result<List<MoodDataModel>>> getMoodDataByDateTime(DateTime dateTime) async {
    return _moodDataRepository.getMoodDataByDateTime(dateTime);
  }

  /// 获取所有心情数据
  Future<Result<List<MoodDataModel>>> getMoodDataAll() async {
    return _moodDataRepository.getMoodDataAll();
  }

  /// 获取所有心情数据的记录日期数据
  Future<Result<List<MoodRecordDateModel>>> getMoodRecordDateAll() async {
    return _moodDataRepository.getMoodRecordDateAll();
  }

  /// 添加心情详细数据
  Future<Result<bool>> addMoodData(MoodDataModel moodData) async {
    if (moodData.mood_id != null) return Result.error(Exception('MoodDataModel.mood_id 必须为空'));
    return _moodDataRepository.addMoodData(moodData);
  }

  /// 修改心情详细数据
  Future<Result<bool>> editMoodData(MoodDataModel moodData) async {
    if (moodData.mood_id == null) return Result.error(Exception('MoodDataModel.mood_id 不能为空'));
    return _moodDataRepository.editMoodData(moodData);
  }

  /// 删除心情详细数据
  ///
  /// - [moodId] 心情 ID
  Future<Result<bool>> deleteMoodData(int moodId) async {
    return _moodDataRepository.deleteMoodData(moodId);
  }
}
