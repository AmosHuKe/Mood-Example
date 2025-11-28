import 'dart:convert';
import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../models/mood/mood_category_model.dart';
import '../../repositories/mood/mood_category_repository.dart';

class MoodCategoryLoadUseCase {
  MoodCategoryLoadUseCase({required MoodCategoryRepository moodCategoryRepository})
    : _moodCategoryRepository = moodCategoryRepository;

  final MoodCategoryRepository _moodCategoryRepository;

  Future<Result<List<MoodCategoryModel>>> execute() async {
    /// 默认值
    const moodCategoryList = <MoodCategoryModel>[
      .new(icon: '😊', title: '开心'),
      .new(icon: '🎉', title: '惊喜'),
      .new(icon: '🤡', title: '滑稽'),
      .new(icon: '😅', title: '尴尬'),
      .new(icon: '😟', title: '伤心'),
      .new(icon: '🤯', title: '惊讶'),
      .new(icon: '🤩', title: '崇拜'),
      .new(icon: '😡', title: '生气'),
    ];
    final getInitMoodCategoryDefaultResult = await _moodCategoryRepository
        .getInitMoodCategoryDefault();
    switch (getInitMoodCategoryDefaultResult) {
      case Success<bool?>():
        {
          /// 是否始化默认值
          if (getInitMoodCategoryDefaultResult.value ?? false) {
            return _getMoodCategoryAll();
          } else {
            final setMoodCategoryDefaultResult = await _moodCategoryRepository
                .setMoodCategoryDefault(moodCategoryList);
            switch (setMoodCategoryDefaultResult) {
              case Success<bool>():
                LogUtils.stackTraceLog(StackTrace.current, result: setMoodCategoryDefaultResult);
                return _getMoodCategoryAll();
              case Error<bool>():
                LogUtils.stackTraceLog(StackTrace.current, result: setMoodCategoryDefaultResult);
                return .error(setMoodCategoryDefaultResult.error);
            }
          }
        }
      case Error<bool?>():
        LogUtils.stackTraceLog(StackTrace.current, result: getInitMoodCategoryDefaultResult);
        return .error(getInitMoodCategoryDefaultResult.error);
    }
  }

  /// 获取所有心情类别
  Future<Result<List<MoodCategoryModel>>> _getMoodCategoryAll() async {
    final getMoodCategoryAllResult = await _moodCategoryRepository.getMoodCategoryAll();
    switch (getMoodCategoryAllResult) {
      case Success<List<MoodCategoryModel>>():
        LogUtils.stackTraceLog(
          StackTrace.current,
          result: getMoodCategoryAllResult,
          message: json.encode(getMoodCategoryAllResult.value),
        );
        return .success(getMoodCategoryAllResult.value);
      case Error<List<MoodCategoryModel>>():
        LogUtils.stackTraceLog(StackTrace.current, result: getMoodCategoryAllResult);
        return .error(getMoodCategoryAllResult.error);
    }
  }
}
