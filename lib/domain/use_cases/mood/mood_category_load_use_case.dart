import '../../../utils/result.dart';
import '../../models/mood/mood_category_model.dart';
import '../../repositories/mood/mood_category_repository.dart';

class MoodCategoryLoadUseCase {
  MoodCategoryLoadUseCase({required MoodCategoryRepository moodCategoryRepository})
    : _moodCategoryRepository = moodCategoryRepository;

  final MoodCategoryRepository _moodCategoryRepository;

  Future<Result<List<MoodCategoryModel>>> execute() async {
    /// 默认值
    const moodCategoryList = [
      MoodCategoryModel(icon: '😊', title: '开心'),
      MoodCategoryModel(icon: '🎉', title: '惊喜'),
      MoodCategoryModel(icon: '🤡', title: '滑稽'),
      MoodCategoryModel(icon: '😅', title: '尴尬'),
      MoodCategoryModel(icon: '😟', title: '伤心'),
      MoodCategoryModel(icon: '🤯', title: '惊讶'),
      MoodCategoryModel(icon: '🤩', title: '崇拜'),
      MoodCategoryModel(icon: '😡', title: '生气'),
    ];
    final getInitMoodCategoryDefaultResult =
        await _moodCategoryRepository.getInitMoodCategoryDefault();
    switch (getInitMoodCategoryDefaultResult) {
      case Success<bool?>():
        {
          /// 是否始化默认值
          if (getInitMoodCategoryDefaultResult.value ?? false) {
            return _moodCategoryRepository.getMoodCategoryAll();
          } else {
            final setMoodCategoryDefaultResult = await _moodCategoryRepository
                .setMoodCategoryDefault(moodCategoryList);
            switch (setMoodCategoryDefaultResult) {
              case Success<bool>():
                {
                  return _moodCategoryRepository.getMoodCategoryAll();
                }
              case Error<bool>():
                print('MoodCategoryInitUseCase error: ${setMoodCategoryDefaultResult.error}');
                return Result.error(setMoodCategoryDefaultResult.error);
            }
          }
        }
      case Error<bool?>():
        print('MoodCategoryInitUseCase error: ${getInitMoodCategoryDefaultResult.error}');
        return Result.error(getInitMoodCategoryDefaultResult.error);
    }
  }
}
