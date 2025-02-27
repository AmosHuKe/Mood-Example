import '../../../utils/result.dart';
import '../../models/mood/mood_data_model.dart';
import '../../repositories/application/data_import_export_repository.dart';

class DataImportExportUseCase {
  DataImportExportUseCase({required DataImportExportRepository dataImportExportRepository})
    : _dataImportExportRepository = dataImportExportRepository;

  final DataImportExportRepository _dataImportExportRepository;

  /// 获取所有心情数据
  Future<Result<List<MoodDataModel>>> getMoodDataAll() async {
    return _dataImportExportRepository.getMoodDataAll();
  }

  /// 添加心情数据
  Future<Result<bool>> addMoodDataAll(List<MoodDataModel> moodDataList) async {
    if (moodDataList.length <= 0) return Result.error(Exception('心情数据不能为空'));
    return _dataImportExportRepository.addMoodDataAll(moodDataList);
  }
}
