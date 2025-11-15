import '../../../utils/utils.dart';
import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_data_model.dart';
import '../../../domain/repositories/mood/mood_data_repository.dart';
import '../../dao/mood/mood_data_dao.dart';

class MoodDataRepositoryLocal implements MoodDataRepository {
  MoodDataRepositoryLocal({required MoodDataDao moodDataDao}) : _moodDataDao = moodDataDao;

  final MoodDataDao _moodDataDao;

  @override
  Future<Result<List<MoodDataModel>>> getMoodDataByDateTime(DateTime dateTime) async {
    try {
      final _dateTime = Utils.datetimeFormatToString(dateTime);
      final moodData = await _moodDataDao.getMoodData(_dateTime);
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
  Future<Result<List<MoodRecordDateModel>>> getMoodRecordDateAll() async {
    try {
      final moodRecordDateData = await _moodDataDao.getMoodRecordDateAll();
      return .success(
        moodRecordDateData.map((value) {
          return MoodRecordDateModel.fromJson(value);
        }).toList(),
      );
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> addMoodData(MoodDataModel moodData) async {
    try {
      final value = await _moodDataDao.addMoodData(moodData);
      return .success(value);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> editMoodData(MoodDataModel moodData) async {
    try {
      final value = await _moodDataDao.editMoodData(moodData);
      return .success(value);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> deleteMoodData(int moodId) async {
    try {
      final value = await _moodDataDao.deleteMoodData(moodId);
      return .success(value);
    } on Exception catch (e) {
      return .error(e);
    }
  }
}
