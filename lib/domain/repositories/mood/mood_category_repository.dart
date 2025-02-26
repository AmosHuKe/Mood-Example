import '../../../utils/result.dart';
import '../../models/mood/mood_category_model.dart';

abstract class MoodCategoryRepository {
  /// 获取所有心情类别
  Future<Result<List<MoodCategoryModel>>> getMoodCategoryAll();

  /// 获取是否初始化心情类别默认值
  ///
  Future<Result<bool?>> getInitMoodCategoryDefault();

  /// 设置心情类别默认值
  ///
  /// - [moodCategoryList] 需要设置的默认值
  Future<Result<bool>> setMoodCategoryDefault(List<MoodCategoryModel> moodCategoryList);
}
