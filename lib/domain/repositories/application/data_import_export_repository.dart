import '../../../utils/result.dart';
import '../../models/mood/mood_data_model.dart';

abstract class DataImportExportRepository {
  /// 获取所有心情数据
  Future<Result<List<MoodDataModel>>> getMoodDataAll();

  /// 添加心情数据
  Future<Result<bool>> addMoodDataAll(List<MoodDataModel> moodDataList);
}
