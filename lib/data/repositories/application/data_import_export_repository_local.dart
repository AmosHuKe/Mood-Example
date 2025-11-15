import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_data_model.dart';
import '../../../domain/repositories/application/data_import_export_repository.dart';
import '../../dao/application/data_import_export_dao.dart';

class DataImportExportRepositoryLocal implements DataImportExportRepository {
  DataImportExportRepositoryLocal({required DataImportExportDao dataImportExportDao})
    : _dataImportExportDao = dataImportExportDao;

  final DataImportExportDao _dataImportExportDao;

  @override
  Future<Result<List<MoodDataModel>>> getMoodDataAll() async {
    try {
      final moodData = await _dataImportExportDao.getMoodDataAll();
      return .success(
        moodData.map((value) {
          return MoodDataModel.fromJson(value);
        }).toList(),
      );
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> addMoodDataAll(List<MoodDataModel> moodDataList) async {
    try {
      final result = await _dataImportExportDao.addMoodDataAll(moodDataList);
      return .success(result);
    } on Exception catch (e) {
      return .error(e);
    }
  }
}
