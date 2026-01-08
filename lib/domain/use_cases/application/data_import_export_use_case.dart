import '../../../shared/utils/log_utils.dart';
import '../../../shared/utils/result.dart';
import '../../models/mood/mood_data_model.dart';
import '../../repositories/application/data_import_export_repository.dart';

class DataImportExportUseCase {
  DataImportExportUseCase({required DataImportExportRepository dataImportExportRepository})
    : _dataImportExportRepository = dataImportExportRepository;

  final DataImportExportRepository _dataImportExportRepository;

  /// 获取所有心情数据
  Future<Result<List<MoodDataModel>>> getMoodDataAll() async {
    final result = await _dataImportExportRepository.getMoodDataAll();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<List<MoodDataModel>>():
        return .success(result.value);
      case Error<List<MoodDataModel>>():
        return .error(result.error);
    }
  }

  /// 添加心情数据
  Future<Result<bool>> addMoodDataAll(List<MoodDataModel> moodDataList) async {
    if (moodDataList.length <= 0) return .error(Exception('心情数据不能为空'));
    final result = await _dataImportExportRepository.addMoodDataAll(moodDataList);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }
}
