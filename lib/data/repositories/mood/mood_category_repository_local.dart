import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_category_model.dart';
import '../../../domain/repositories/mood/mood_category_repository.dart';
import '../../dao/mood/mood_category_dao.dart';

class MoodCategoryRepositoryLocal implements MoodCategoryRepository {
  MoodCategoryRepositoryLocal({required MoodCategoryDao moodCategoryDao})
    : _moodCategoryDao = moodCategoryDao;

  final MoodCategoryDao _moodCategoryDao;

  @override
  Future<Result<List<MoodCategoryModel>>> getMoodCategoryAll() async {
    try {
      final moodCategoryAll = await _moodCategoryDao.getMoodCategoryAll();
      return .success(
        moodCategoryAll.map((value) {
          return MoodCategoryModel.fromJson(value);
        }).toList(),
      );
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool?>> getInitMoodCategoryDefault() async {
    try {
      final initMoodCategoryDefaultType = await _moodCategoryDao.getInitMoodCategoryDefaultType();
      return .success(initMoodCategoryDefaultType);
    } on Exception catch (e) {
      return .error(e);
    }
  }

  @override
  Future<Result<bool>> setMoodCategoryDefault(List<MoodCategoryModel> moodCategoryList) async {
    try {
      final result = await _moodCategoryDao.setMoodCategoryDefault(moodCategoryList);
      if (result) {
        await _moodCategoryDao.setInitMoodCategoryDefaultType(true);
        return const .success(true);
      }
      return const .success(false);
    } on Exception catch (e) {
      return .error(e);
    }
  }
}
